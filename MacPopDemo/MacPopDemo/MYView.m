//
//  MYView.m
//  MacPopDemo
//
//  Created by caijinzhu on 2018/2/5.
//  Copyright © 2018年 alexiuce . All rights reserved.
//

#import "MYView.h"


@interface MYView()

@property (nonatomic, strong) NSColor *selectColor;

@end


@implementation MYView



- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    NSRect r = NSMakeRect(10, 10, 10, 10);
    [NSColor.greenColor set];
    NSRectFill(r);
    // Drawing code here.
    if (self.selectColor != nil){
        NSRect r = NSMakeRect(30, 10, 10, 10);
        [self.selectColor set];
        NSRectFill(r);
    }
}

- (void)mouseDown:(NSEvent *)event{
   
    

    NSPoint where;
    NSColor *pixelColor;
    CGFloat  red, green, blue;
    where = [self convertPoint:[event locationInWindow] fromView:nil];
    // NSReadPixel pulls data out of the current focused graphics context,
    // so you must first call lockFocus.
    [self lockFocus];
    pixelColor = NSReadPixel(where);
    // Always balance lockFocus with unlockFocus.
     [self unlockFocus];
    red = [pixelColor redComponent];
    green = [pixelColor greenComponent];
    blue = [pixelColor blueComponent];

    CGPoint pointInWindow = [event locationInWindow];
    CGPoint p = [self convertPoint:pointInWindow toView:self];
    [self lockFocus];
    self.selectColor = NSReadPixel(p);
    
  
    [self setNeedsDisplay:YES];
    
}

@end
