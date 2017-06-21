//
//  XCPhotoEditProtocol.swift
//  Tip for Day Demo
//
//  Created by alexiuce  on 2017/6/21.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import Foundation
import UIKit

protocol XCPhotoEditProtocol {
    func photoEditorDidFinished(_ editPicker: XCPhotoEditPicker , editedImage : UIImage) ;
    func photoEditorDidCancle(_ editPicker : XCPhotoEditPicker) ;
}
