//
//  CVTool.m
//  Tip for Day Demo
//
//  Created by Alexcai on 2017/6/21.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//





#import "CVTool.h"

#import <vector>
#include<algorithm>
#include<opencv2/core.hpp>
#include<opencv2/highgui.hpp>
#include<opencv2/imgproc.hpp>
#include <opencv2/imgcodecs/ios.h>

using namespace cv;




Mat _darkChannel ;
std::vector<Mat> _fImageBorderVector(3);
Mat _cvImage;
Mat _fImage;
@implementation CVTool


+ (UIImage *)fetchDarkChannelImage:(UIImage *)sourceImage{
    return [self MatToUIImage:[self darkChannelImage:sourceImage ]];
}


// 根据UIImage 生成 暗通道图
+ (Mat)darkChannelImage:(UIImage *)sourceImg{
    Mat cvImage ;
    UIImageToMat(sourceImg, cvImage,false);
    cvtColor(cvImage, cvImage, COLOR_RGBA2BGR);
    CV_Assert(!cvImage.empty() && cvImage.channels() == 3);
    //图片的归一化
    Mat fImage;
    cvImage.convertTo(fImage,CV_32FC3,1.0/255,0);
    //规定patch的大小,且均为奇数
    int hPatch = 15;
    int vPatch = 15;
    //给归一化的图片添加边界
    Mat fImageBorder;
    copyMakeBorder(fImage,fImageBorder,vPatch/2,vPatch/2,hPatch/2,hPatch/2,BORDER_REPLICATE);
    //分离通道
    std::vector<Mat> fImageBorderVector(3);
    split(fImageBorder,fImageBorderVector);
    //创建darkChannel
    Mat darkChannel(cvImage.rows,cvImage.cols,CV_32FC1);
    double minTemp ,minPixel;
    //根据darkChannel的定义
    for(unsigned int r = 0;r < darkChannel.rows;r++)
    {
        for(unsigned int c = 0;c < darkChannel.cols;c++)
        {
            minPixel = 1.0;
            for(std::vector<Mat>::iterator it = fImageBorderVector.begin() ;it != fImageBorderVector.end();it++){
                Mat roi(*it,cv::Rect(c,r,hPatch,vPatch));
                minMaxLoc(roi,&minTemp);
                minPixel = min(minPixel,minTemp);
            }
            darkChannel.at<float>(r,c) = float(minPixel);
        }
    }
    Mat darkChannel8U;  // 暗通道图
    darkChannel.convertTo(darkChannel8U,CV_8UC1,255,0);
    _darkChannel = darkChannel8U;
    _fImageBorderVector = fImageBorderVector;
    _fImage = fImage;
    _cvImage = cvImage;
    return darkChannel8U;
}

//Mat -> UIImage
+ (UIImage *)MatToUIImage:(Mat)mat{
    if (mat.channels() == 4) {
        cvtColor(mat, mat, CV_BGR2RGB);
    }
    
    NSData *data = [NSData dataWithBytes:mat.data length:mat.elemSize() * mat.total()];
    CGColorSpaceRef colorspace;
    
    if (mat.elemSize() == 1) {
        colorspace = CGColorSpaceCreateDeviceGray();
    }else{
        colorspace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    CGImageRef imageRef = CGImageCreate(mat.cols, mat.rows, 8, 8 *mat.elemSize(), mat.step[0], colorspace, kCGImageAlphaNone|kCGBitmapByteOrderDefault, provider, NULL, false, kCGRenderingIntentDefault);
    
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorspace);
    
    return image;
}

/** 根据暗通道计算大气光值 A*/
+ (UIImage *)atmosphericlightRemoveFogInImage{
    float top = 0.001;
    int hPatch = 15;
    int vPatch = 15;
    Mat darkChannel = _darkChannel;
    float numberTop = top*darkChannel.rows*darkChannel.cols;
    Mat darkChannelVector;
    darkChannelVector = darkChannel.reshape(1,1);
    Mat_<int> darkChannelVectorIndex;
    sortIdx(darkChannelVector,darkChannelVectorIndex,CV_SORT_EVERY_ROW + CV_SORT_DESCENDING);
    
    //制作掩码
    Mat mask(darkChannelVectorIndex.rows,darkChannelVectorIndex.cols,CV_8UC1);//注意mask的类型必须是CV_8UC1
    for(unsigned int r = 0;r < darkChannelVectorIndex.rows;r++){
        for(unsigned int c = 0;c < darkChannelVectorIndex.cols;c++){
            if(darkChannelVectorIndex.at<int>(r,c) <= numberTop){
                mask.at<uchar>(r,c) = 1;
            }else{
                mask.at<uchar>(r,c) = 0;
            }
        }
    }
    Mat darkChannelIndex = mask.reshape(1,darkChannel.rows);
    std::vector<double> A(3);//分别存取A_b,A_g,A_r
    std::vector<double>::iterator itA = A.begin();
    std::vector<Mat>::iterator it = _fImageBorderVector.begin();
    
    //2.2在求第三步的t(x)时，会用到以下的矩阵，这里可以提前求出
    std::vector<Mat> fImageBorderVectorA(3);
    std::vector<Mat>::iterator itAA = fImageBorderVectorA.begin();
    for( ;it != _fImageBorderVector.end() && itA != A.end() && itAA != fImageBorderVectorA.end();it++,itA++,itAA++)
    {
        Mat roi(*it,cv::Rect(hPatch/2,vPatch/2,darkChannel.cols,darkChannel.rows));
        minMaxLoc(roi,0,&(*itA),0,0,darkChannelIndex);//
        (*itAA) = (*it)/(*itA); //[注意：这个地方有除号，但是没有判断是否等于0]
    }
    // 3. 根据暗通道计算t(x)
    Mat darkChannelA(darkChannel.rows,darkChannel.cols,CV_32FC1);
    float omega = 0.95;//0<w<=1,论文中取值为0.95
    double minTemp ,minPixel;
    //代码和求darkChannel的时候,代码差不多
    for(unsigned int r = 0;r < darkChannel.rows;r++){
        for(unsigned int c = 0;c < darkChannel.cols;c++){
            float minPixel = 1.0;
            for(itAA = fImageBorderVectorA.begin() ;itAA != fImageBorderVectorA.end();itAA++){
                Mat roi(*itAA,cv::Rect(c,r,hPatch,vPatch));
                minMaxLoc(roi,&minTemp);
                minPixel = minPixel > minTemp ? minTemp : minPixel;//  min(minPixel,minTemp);

            }
            darkChannelA.at<float>(r,c) = float(minPixel);
        }
    }
    Mat tx = 1.0 - omega*darkChannelA;
    
    // 4. 根据暗通道它(x),计算结果
    Mat image = _cvImage;
    Mat fImage = _fImage;
    float t0  = 0.1;//论文中取t0 = 0.1
    Mat jx(image.rows,image.cols,CV_32FC3);
    for(size_t r = 0;r < jx.rows;r++)
    {
        for(size_t c =0;c<jx.cols;c++)
        {
            jx.at<Vec3f>(r,c) = Vec3f((fImage.at<Vec3f>(r,c)[0] - A[0])/max(tx.at<float>(r,c),t0)+A[0],(fImage.at<Vec3f>(r,c)[1] - A[1])/max(tx.at<float>(r,c),t0)+A[1],(fImage.at<Vec3f>(r,c)[2] - A[2])/max(tx.at<float>(r,c),t0)+A[2]);
        }
    }

    Mat jx8U;
    jx.convertTo(jx8U,CV_8UC3,255,0);
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileFullPath = [path stringByAppendingPathComponent:@"opencv_temp.png"];
    const char *cPath = fileFullPath.UTF8String;
    imwrite(cPath,jx8U);
    return [UIImage imageWithContentsOfFile:fileFullPath];
//    return [self MatToUIImage:jx8U];
}

+ (UIImage *)fetchNoFogImage{
    return [self atmosphericlightRemoveFogInImage];
}

@end
