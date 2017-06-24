//
//  CVTool.h
//  Tip for Day Demo
//
//  Created by Alexcai on 2017/6/21.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


@interface CVTool : NSObject


+ (UIImage *)fetchDarkChannelImage:(UIImage *)sourceImage;

+ (UIImage *)fetchNoFogImage;

@end
