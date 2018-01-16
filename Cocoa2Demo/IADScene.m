//
//  IADScene.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/15.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "IADScene.h"
#import "ViewController.h"
#import "RectSprite.h"

@implementation IADScene

- (id)init{
    if (self = [super init]) {
        CCNodeColor *bg = [CCNodeColor nodeWithColor:CCColor.grayColor];
        [self addChild:bg];
        
       
        
        RectSprite *r1 = [RectSprite spriteWithColor:CCColor.yellowColor size:CGSizeMake(50, 50)];
        r1.position = ccp(100, 100);
        [self addChild:r1];
        
    }
    return self;
}



//- (void)onEnter{
//    [super onEnter];
//    ViewController *vc = [[ViewController alloc]init];
//    [[CCDirector sharedDirector] presentViewController:vc animated:YES completion:nil];
//
//}

@end
