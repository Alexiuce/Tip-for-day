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
    
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    NSString *widthKey = [NSString stringWithFormat:@"%zd",(int)winSize.width];
    
    NSDictionary <NSString *,NSString *>*deviceImage = @{@"375":@"matrix.png",@"320":@"matrix-568.png",@"414":@"matrix_puls.png"};
    
 
    MatrixSprite *m =  [self spriteWithImageNamed:deviceImage[widthKey]];
    m.unitSize = CGSizeMake(m.contentSize.width * 0.1, m.contentSize.height * 0.1);
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
    int row = (self.contentSize.height - touchPoint.y ) / self.unitSize.height;
    // 行+列 组合为key
    NSString *key = [NSString stringWithFormat:@"%zd%zd",row,col];
    if (self.allreadyDict[key]) {return;}
    // type ==  3: head , 17: body, 0: empty;
    int type =  [self.mapArray[row][col] intValue] ;
    self.allreadyDict[key] = @(type);

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
    CGFloat displayY = self.contentSize.height - self.unitSize.height * (row + 0.5);
    CCSprite *s = [CCSprite spriteWithImageNamed:name];
    s.position = ccp(displayX, displayY);
    [self addChild:s];
    if ([self.delegate respondsToSelector:@selector(matrixDidSelected:itemStyle:)]) {
        [self.delegate matrixDidSelected:self itemStyle:style];
    }
}

- (void)refresh{
    [self.allreadyDict removeAllObjects];
    [self removeAllChildren];
}
- (void)reloadMapDataAndRefresh{
    
    
    [self refresh];
}


#pragma mark lazy method
- (NSArray *)mapArray{
    if (_mapArray == nil) {
        NSString *mapData = [[NSBundle mainBundle] pathForResource:@"planeMap.dat" ofType:nil];
        _mapArray = [NSArray arrayWithContentsOfFile:mapData];
    }
    return _mapArray;
}

@end
