//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by alexiuce  on 2017/6/29.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      example(of: "subscribe") { 
        let one = 1
        let two = 2
        let three = 3
        let observable = Observable.of(one,two,three)
        _ = observable.subscribe(onNext: { (element) in
            print(element)
        })
    }

}


public func example(of description : String ,action:()->Void){
    print("\n--- Example of: ",description,"---")
    action()
}
