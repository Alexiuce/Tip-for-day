//
//  ViewController.swift
//  AVFoundationDemo
//
//  Created by alexiuce  on 2017/6/20.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    // 采集设备硬件
    
    lazy var captureDevice : AVCaptureDevice = {
       
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)!
        return device
    }();
    // 采集会话（用于管理设备输入和输出）
    lazy var session : AVCaptureSession = {
        let session = AVCaptureSession()
        // 添加输入设备到采集会话
        if session.canAddInput(self.inputDevice) {
            session.addInput(self.inputDevice)
        }
        // 添加输出到采集会话
        if session.canAddOutput(self.metaOutput) {
            session.addOutput(self.metaOutput)
            print(self.metaOutput.availableMetadataObjectTypes)
            self.metaOutput.metadataObjectTypes = [AVMetadataObjectTypeFace]
        }
        // 添加视频输出到采集会话
        if session.canAddOutput(self.videoOutput) {
            session.addOutput(self.videoOutput)
        }
        
        return session
    }();
    // 输入设备
    lazy var inputDevice : AVCaptureDeviceInput = {
        let input = try! AVCaptureDeviceInput(device: self.captureDevice)
        return input
    }();
    // 静态图片输出 （拍照时用）
    lazy var imgOutput : AVCaptureStillImageOutput = {
        let output = AVCaptureStillImageOutput()
        return output
    }();
   // 视频输出 （视频流）
    lazy var videoOutput : AVCaptureVideoDataOutput = {
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: self.sessionQueue)
       
        return output
    }();
    // 元数据捕获输出（条码，二维码识别，人脸识别等）
    lazy var metaOutput : AVCaptureMetadataOutput = {
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: self.sessionQueue)
        /** 对于AVCaptureMetadataOutput 的设置，需要在添加到session之后进行，否则报错 */
//        output.metadataObjectTypes = [AVMetadataObjectTypeFace]
        return output
    }();
    // 采集处理队列 ： 视频捕捉时用来处理捕获数据
    lazy var sessionQueue : DispatchQueue = {
        let queue = DispatchQueue(label: "myVideoSessionQueue")
        return queue
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let previewLayer =  AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.frame = view.bounds
        view.layer.addSublayer(previewLayer!)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.session .startRunning()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.session.stopRunning()
    }
}



extension ViewController : AVCaptureMetadataOutputObjectsDelegate{
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
       print(metadataObjects,Thread.current)
    }
}

extension ViewController : AVCaptureVideoDataOutputSampleBufferDelegate{
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        
    }
}

