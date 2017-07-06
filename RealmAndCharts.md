### RealmAndCharts Demo  

![](https://img.shields.io/badge/platform-iOS-blue.svg)
---
#### Realm简介:
>   
>  <code>保存到Realm数据库中的对象需要继承自SDK中的Object</code> 
>  
> <code>如果对象类中的属性字段被重新修改（比如name 后期修改为fullName），需要在真机或模拟器中删除App后重新运行安装，否则会报错：</code>  
> 
> ```swift
>    Migration is required due to the following errors:
> ```
> 

#### Realm 使用 
> 1.集成Realm： 
> 
> ```swift
>    pod 'RealmSwift', '~> 2.0.2'
> ```
>  2.使用Realm：
>   
> * 创建需要存储的类，该类继承自Object
> 
> ```swift
>  class VisitorCount: Object {
>     dynamic var count = 0    
>     dynamic var name = ""
>   }
> ``` 
> 
> * 数据存储到Realm数据库
> 
> ```swift
>    func saveToDatabase(){
>        guard let realm = try? Realm() else {return}
>        try? realm.write {
>            realm.add(需要保存的对象)   
>        }
>      }
> ```
> 
> * 获取Realm中的数据
> 
> ```swift
>   func getVisitorFromDatabase() -> Results<VisitorCount>?{   
>        guard let realm = try? Realm() else {return nil} 
>        // 获取需要存储的类的数据，返回结果为数组 
>        return realm.objects(VisitorCount.self) 
>    }
> ```
> 
> * 删除Realm中的数据
> 
> ```swift
>   func removeAllData(){
>       // 如果数据库不存在，直接返回
>       guard let realm = try? Realm() else {return}
>       // 从Realm数据库中获取数据，若无数据，直接返回
>        guard let visitorCount = getVisitorFromDatabase() else {return}
>       try? realm.write {
>            realm.delete(visitorCount)
>       }
>    }
> ```
> 
> 
> 
> 
> 
>    
> 

---


> **Charts**:
