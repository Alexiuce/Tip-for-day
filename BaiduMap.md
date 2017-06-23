### BaiduMap Target
在Swift4.0中集成百度图  

* 准备工作： 
  * 注册百度开发者，并创建应用，获取密钥（AK）
  * 下载SKD（可根据具体情况下载需要的部分）

* 集成 
  参考百度官方指导   
  [基于Swift集成](http://lbsyun.baidu.com/index.php?title=iossdk/guide/swift)  
  
  **注意事项（坑）**  
  * #import < BaiduMapAPI_Map/BMKMapView.h>这里的文件名前多了一个空格，需去掉，否则编译报文件找不到
  * 建议集成时，使用cocoapod方式
  * 在项目中添加一个新Objective-C文件，会自动生成桥接文件，然后再将这个OC文件delete，这样就不需要再手动配置桥接文件路径
  * 应用的info.plist 中，需要设置**Bundle display name**，否则Baidu地图注册时报错
 
* 应用
   
   ```swift
    var _mapView : BMKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       _mapView = BMKMapView(frame: view.bounds)
       view.addSubview(_mapView!)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _mapView?.viewWillAppear()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _mapView?.viewWillDisappear()
    }
}

   ```
  
  
  
  
   
