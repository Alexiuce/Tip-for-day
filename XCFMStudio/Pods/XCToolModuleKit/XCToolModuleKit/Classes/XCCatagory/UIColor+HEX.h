//
//  UIColor+HEX.h
//
//  Created by Joinf on 2016/11/4.
//

#import <UIKit/UIKit.h>

#define XCColor(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define XCNColor(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface UIColor (HEX)
+(UIColor *) colorWithHexCode:(NSString *)hexCode;


@end
