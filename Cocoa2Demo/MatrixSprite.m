//
//  MatrixSprite.m
//  Cocoa2Demo iOS
//
//  Created by Alexcai on 2018/1/27.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "MatrixSprite.h"
#import "OALSimpleAudio.h"

@interface MatrixSprite()

// 单元格子尺寸
@property (nonatomic, assign) CGSize unitSize;
// 地图数组
@property (nonatomic, strong) NSArray *mapArray;
// 格子记录字典:用于存储点击过的格子
@property (nonatomic, strong) NSMutableDictionary *allreadyDict;
@property (nonatomic, weak) id <MatrixtDelegate>delegate;

@end


@implementation MatrixSprite

+ (instancetype)matrixSpriteWithDelegate:(id<MatrixtDelegate>)delegate{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 预先加载音效
        for (NSString *name in @[@"head.mp3",@"body.mp3",@"empty.mp3"]) {
            [[OALSimpleAudio sharedInstance] preloadEffect:name];
        }
    });
    MatrixSprite *m =  [self spriteWithImageNamed:@"matrix.png"];
    m.unitSize = CGSizeMake(m.boundingBox.size.width * 0.1, m.boundingBox.size.height * 0.1);
    m.allreadyDict = [NSMutableDictionary dictionary];
    m.userInteractionEnabled = YES;
    m.delegate = delegate;
    return m;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    // 触摸点
    CGPoint touchPoint = [touch locationInNode:self];
    // 列
    int col = touchPoint.x / self.unitSize.width;
    // 行
    int row = (self.boundingBox.size.height - touchPoint.y) / self.unitSize.height;
    // 行+列 组合为key
    NSString *key = [NSString stringWithFormat:@"%zd%zd",row,col];
    if (self.allreadyDict[key]) {return;}
    // type ==  3: head , 17: body, 0: empty;
    int type =  [self.mapArray[row][col] intValue] ;
    self.allreadyDict[key] = @(type);
    XCLog(@"type = %zd",type);
    NSString *name = @"empty.png";
    NSString *audioName = @"empty.mp3";
    MatrixItemStyle style = MatrixItemEmpty;
    switch (type) {
        case 3:
            name = @"head.png";
            audioName = @"head.mp3";
            style = MatrixItemHead;
            break;
        case 17:
            name = @"body.png";
            audioName = @"body.mp3";
            style = MatrixItemBody;
    }
    // 播放音效
    [[OALSimpleAudio sharedInstance] playEffect:audioName];
    // 计算显示位置
    CGFloat displayX = self.unitSize.width * (col + 0.5);
    CGFloat displayY = self.boundingBox.size.height - self.unitSize.height * (row + 0.5);
    CCSprite *s = [CCSprite spriteWithImageNamed:name];
    s.position = ccp(displayX, displayY);
    [self addChild:s];
    if ([self.delegate respondsToSelector:@selector(matrixDidSelected:itemStyle:)]) {
        [self.delegate matrixDidSelected:self itemStyle:style];
    }
}


- (NSArray *)mapArray{
    if (_mapArray == nil) {
        NSString *mapData = [[NSBundle mainBundle] pathForResource:@"planeMap.dat" ofType:nil];
        _mapArray = [NSArray arrayWithContentsOfFile:mapData];
    }
    return _mapArray;
}

@end
