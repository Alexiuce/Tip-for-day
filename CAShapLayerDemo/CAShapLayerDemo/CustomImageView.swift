//
//  CustomImageView.swift
//  CAShapLayerDemo
//
//  Created by alexiuce  on 2017/7/24.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    let loadingView = CircleLoadView(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(loadingView)
        loadingView.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(loadingView)
        loadingView.frame = bounds
    }

}
