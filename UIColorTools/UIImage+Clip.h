//
//  UIImage+Clip.h
//  UIColorTools
//
//  Created by huah on 2019/11/18.
//  Copyright © 2019 huah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Clip)

// 切割圆角
- (UIImage *)clipImage;

//缩放图片
+ (UIImage *)scaleImgWithData:(NSData *)data
                     withSize:(CGSize)size
                    withScale:(CGFloat)scale
                  orientation:(UIImageOrientation)orientation;

@end

