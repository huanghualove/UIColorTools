//
//  UIColor+Gradient.h
//  UIColorTools
//
//  Created by 黄华 on 2019/11/18.
//  Copyright © 2019 黄华. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    GradientStyleFromLeftToRight,
    GradientStyleFromTopToBottom,
    GradientStyleFromRadial,//径向的
    GradientStyleFromDiagonal,//对角线
} GradientStyle;


@interface UIColor (Gradient)

+ (UIColor *)colorWithGradientStyle:(GradientStyle)gradientStyle Frame:(CGRect)frame Colors:(NSArray<UIColor *>*)colors;

@end


