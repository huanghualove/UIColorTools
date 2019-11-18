//
//  UIImage+Clip.m
//  UIColorTools
//
//  Created by huah on 2019/11/18.
//  Copyright © 2019 huah. All rights reserved.
//

#import "UIImage+Clip.h"

@implementation UIImage (Clip)


// 切割圆角
- (UIImage *)clipImage{
    
    CGFloat size = MIN(self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size, size), NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size, size)];
    
    CGContextAddPath(context, path.CGPath);
    
    CGContextClip(context);
    
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}



//缩放图片
+ (UIImage *)scaleImgWithData:(NSData *)data
                     withSize:(CGSize)size
                    withScale:(CGFloat)scale
                  orientation:(UIImageOrientation)orientation{
    
    //dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    CGFloat maxPixeSize = MAX(size.width, size.height);
               
    CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)data, nil);
    
    NSDictionary *opentionDic = @{(__bridge id)kCGImageSourceCreateThumbnailFromImageAlways:(__bridge id)kCFBooleanTrue,
                                  (__bridge id)kCGImageSourceThumbnailMaxPixelSize:[NSNumber numberWithFloat:maxPixeSize]};
    
               
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(sourceRef, 0, (__bridge CFDictionaryRef)opentionDic);
            
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef scale:scale orientation:orientation];

    CGImageRelease(imageRef);
               
    CFRelease(sourceRef);
                
    return resultImage;
}

@end
