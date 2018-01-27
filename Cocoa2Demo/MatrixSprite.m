//
//  MatrixSprite.m
//  Cocoa2Demo iOS
//
//  Created by Alexcai on 2018/1/27.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "MatrixSprite.h"


@interface MatrixSprite()

// 单元格子尺寸
@property (nonatomic, assign) CGSize unitSize;
// 地图数组
@property (nonatomic, strong) NSArray *mapArray;
// 格子记录字典:用于存储点击过的格子
@property (nonatomic, strong) NSMutableDictionary *allreadyDict;

@end


@implementation MatrixSprite

+ (instancetype)matrixSprite{
    MatrixSprite *m =  [self spriteWithImageNamed:@"matrix.png"];
    m.unitSize = CGSizeMake(m.boundingBox.size.width * 0.1, m.boundingBox.size.height * 0.1);
    m.allreadyDict = [NSMutableDictionary dictionary];
    m.userInteractionEnabled = YES;
    return m;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{

    CGPoint touchPoint = [touch locationInNode:self];
    // 列
    int col = touchPoint.x / self.unitSize.width;
    // 行
    int row = (self.boundingBox.size.height - touchPoint.y) / self.unitSize.height;
    
    NSString *key = [NSString stringWithFormat:@"%zd%zd",row,col];
    XCLog(@"%@",key);
    if (self.allreadyDict[key]) {return;}
    // type ==  3: head , 17: body, 0: empty;
    int type =  [self.mapArray[row][col] intValue] ;
    self.allreadyDict[key] = @(type);
    XCLog(@"type = %zd",type);
    
}


- (NSArray *)mapArray{
    if (_mapArray == nil) {
        NSString *mapData = [[NSBundle mainBundle] pathForResource:@"planeMap.dat" ofType:nil];
        _mapArray = [NSArray arrayWithContentsOfFile:mapData];
    }
    return _mapArray;
}

@end
