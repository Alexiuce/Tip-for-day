//
//  XCTileMap.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/22.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "XCTileMap.h"
#import <CCTiledMapLayer.h>


@implementation XCTileMap

- (id)initWithFile:(NSString *)tmxFile{
    if (self = [super initWithFile:tmxFile]) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint tp = [touch locationInNode:self];
     XCLog(@"tp = %@",NSStringFromCGPoint(tp));
    CCTiledMapLayer *mapLayer = self.children.firstObject;
    CGPoint p2 = [mapLayer tileCoordinateAt:tp];
    XCLog(@"p2 = %@",NSStringFromCGPoint(p2));
    CGPoint p1 = [mapLayer positionAt:p2];
    XCLog(@"p1 = %@",NSStringFromCGPoint(p1));
}

@end
