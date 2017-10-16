//
//  ViewController.m
//  MacPopDemo
//
//  Created by alexiuce  on 2017/9/13.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import "ViewController.h"

#import <POP.h>

@interface ViewController ()
@property (weak) IBOutlet NSBox *boxView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}
- (IBAction)startAnimation:(NSButton *)sender {
    
    POPBasicAnimation *baseAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    baseAnimation.duration = 3.0f;
    baseAnimation.toValue = @(_boxView.frame.origin.x + 200);
    
    [_boxView.layer pop_addAnimation:baseAnimation forKey:@"demox"];
    
}


@end
