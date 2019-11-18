//
//  UIColor+Gradient.m
//  UIColorTools
//
//  Created by 黄华 on 2019/11/18.
//  Copyright © 2019 黄华. All rights reserved.
//

#import "UIColor+Gradient.h"


@implementation UIColor (Gradient)

+ (UIColor *)colorWithGradientStyle:(GradientStyle)gradientStyle Frame:(CGRect)frame Colors:(NSArray<UIColor *>*)colors{
    
    CAGradientLayer *backgroundGradientLayer = [CAGradientLayer layer];
    backgroundGradientLayer.frame = frame;
    
    NSMutableArray *cgColors = [[NSMutableArray alloc] init];
    for (UIColor *color in colors) {
        [cgColors addObject:(id)[color CGColor]];
    }
    
    switch (gradientStyle) {
            
        case GradientStyleFromLeftToRight: {
            
            backgroundGradientLayer.colors = cgColors;
            [backgroundGradientLayer setStartPoint:CGPointMake(0.0, 0.5)];
            [backgroundGradientLayer setEndPoint:CGPointMake(1.0, 0.5)];
            
            UIGraphicsBeginImageContextWithOptions(backgroundGradientLayer.bounds.size,NO, [UIScreen mainScreen].scale);
            [backgroundGradientLayer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return [UIColor colorWithPatternImage:backgroundColorImage];
        }
            
        case GradientStyleFromRadial: {
            
            UIGraphicsBeginImageContextWithOptions(frame.size,NO, [UIScreen mainScreen].scale);
            CGFloat locations[2] = {0.0, 1.0};
            CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
            CFArrayRef arrayRef = (__bridge CFArrayRef)cgColors;
            
            CGGradientRef myGradient = CGGradientCreateWithColors(myColorspace, arrayRef, locations);
            CGPoint myCentrePoint = CGPointMake(0.5 * frame.size.width, 0.5 * frame.size.height);
            float myRadius = MIN(frame.size.width, frame.size.height) * 0.5;
            
            CGContextDrawRadialGradient (UIGraphicsGetCurrentContext(), myGradient, myCentrePoint,
                                         0, myCentrePoint, myRadius,
                                         kCGGradientDrawsAfterEndLocation);
            UIImage *backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext();
            
            CGColorSpaceRelease(myColorspace);
            CGGradientRelease(myGradient);
            UIGraphicsEndImageContext();
            
            return [UIColor colorWithPatternImage:backgroundColorImage];
        }
            
        case GradientStyleFromDiagonal: {
            
            backgroundGradientLayer.colors = cgColors;
            [backgroundGradientLayer setStartPoint:CGPointMake(0.0, 1.0)];
            [backgroundGradientLayer setEndPoint:CGPointMake(1.0, 0.0)];
            
            UIGraphicsBeginImageContextWithOptions(backgroundGradientLayer.bounds.size,NO, [UIScreen mainScreen].scale);
            [backgroundGradientLayer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            return [UIColor colorWithPatternImage:backgroundColorImage];
        }
            
        case GradientStyleFromTopToBottom:
            
        default: {
            
            backgroundGradientLayer.colors = cgColors;
            
            UIGraphicsBeginImageContextWithOptions(backgroundGradientLayer.bounds.size,NO, [UIScreen mainScreen].scale);
            [backgroundGradientLayer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            return [UIColor colorWithPatternImage:backgroundColorImage];
        }
            
    }
}

@end
