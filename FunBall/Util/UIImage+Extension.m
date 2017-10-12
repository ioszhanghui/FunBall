//
//  UIImage+Extension.m
//  河科院微博
//
//  Created by 👄 on 15/6/4.
//  Copyright (c) 2015年 sczy. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+(UIImage *)resizableImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH * 0.5, imageW * 0.5, imageH * 0.5, imageW * 0.5) resizingMode:UIImageResizingModeStretch];
}

- (instancetype)circleImage
{
    
    // 开启图形上下文(目的:产生一个新的UIImage, 参数size就是新产生UIImage的size)
    UIGraphicsBeginImageContext(self.size);
    
    // 获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, rect);
    
    // 裁剪(根据添加到上下文中的路径进行裁剪)
    // 以后超出裁剪后形状的内容都看不见
    CGContextClip(context);
    
    // 绘制图片到上下文中
    [self drawInRect:rect];
    
    // 从上下文中获得最终的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
    
//    CGFloat width = self.size.width;
//    CGFloat height = self.size.height;
//    CGFloat redius = ((width <= height) ? width : height)/2;
//    CGRect  rect = CGRectMake(width/2-redius, height/2-redius, redius*2, redius*2);
//    
//    CGImageRef sourceImageRef = [self CGImage];
//    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
//    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
//    
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newImage.size.width, newImage.size.height), NO, 0);
//    
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(newImage.size.width/2, newImage.size.height/2) radius:redius startAngle:0 endAngle:M_PI*2 clockwise:0];
//    [path addClip];
//    [newImage drawAtPoint:CGPointZero];
//    UIImage *imageCut = UIGraphicsGetImageFromCurrentImageContext();
//    
//    return imageCut;
    
//    // 开启上下文
//    UIGraphicsBeginImageContext(self.size);
//    
//    // 添加一个圆
//    CGFloat centerX = self.size.width * 0.5;
//    CGFloat centerY = self.size.height * 0.5;
//    CGFloat radius = MIN(centerX, centerY);
//    
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
//    [path fill];
//    
//    path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
//    // 裁剪
//    [path addClip];
//    
//     //绘制图片到上下文中
//    [self drawInRect:CGRectMake(centerX - radius, centerY - radius, radius * 2, radius * 2)];
//    
//    // 从上下文中获得最终的图片
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    
//    // 关闭上下文
//    UIGraphicsEndImageContext();
//    
//    // 返回裁剪好的图片
//    return image;
//
}

+ (instancetype)circleImageNamed:(NSString *)name
{
    return [[self imageNamed:name] circleImage];
}
+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

- (UIImage *)imageRotatedByRadians:(CGFloat)radians {
    
    return [self imageRotatedByDegrees:radians * 180/M_PI];
}
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees {
    
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(degrees * M_PI / 180);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, degrees * M_PI / 180);
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
