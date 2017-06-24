### MyXibView Demo
![](https://img.shields.io/badge/platform-OSX-red.svg)
---
cocoa中使用Xib加载视图,与iOS略有不同,在iOS系统中,苹果对NSNib进行了单独的封装,提供了专门的一个分类供UIKit使用.这造成了在刚刚接触cocoa的时候,会有一些误解.记录如下.

**操作步骤**:

1.创建xib文件,并设置xib中的视图的class类型,以及file's Owner

2.创建视图类,添加核心代码

```swift
 // 加载nib
    NSNib *myXib = [[NSNib alloc]initWithNibNamed:@"MyXibView" bundle:nil];
    // 创建xib视图数组(一个xib中可能有多个view)
    NSArray *xibViews;
    // 从xib中加载视图到定义的视图数组中(topLevelObjects的参数为二级指针)
    BOOL isInstant = [myXib instantiateWithOwner:self topLevelObjects:&xibViews];
    if (isInstant) {  // 加载成功
        // 遍历视图数组
        for (MyXibView *view in xibViews) {
            if (![view isKindOfClass:self]) {
                continue;
            }
            // 找到后返回视图
            return view;
        }
        
    }
    return nil;
```
