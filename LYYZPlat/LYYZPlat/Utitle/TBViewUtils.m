//
//  TBViewUtils.m
//  Stock
//
//  Created by liwt on 15/2/26.
//  Copyright (c) 2015年 com.tigerbrokers. All rights reserved.
//

#import "TBViewUtils.h"

@implementation TBViewUtils

+ (void)animationShakeView:(UIView *)view {
    
    CGAffineTransform moveRight = CGAffineTransformTranslate(CGAffineTransformIdentity, 20, 0);
    CGAffineTransform moveLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -20, 0);
    CGAffineTransform resetTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
    CGFloat y = view.origin.y;
    //CGFloat yAfter = ([UIScreen mainScreen].bounds.size.height - view.height) * 0.5;
    [view setFrame:CGRectMake(view.origin.x, y, view.width, view.height)];
    
    
    [UIView animateWithDuration:0.1 animations:^{
        view.transform = moveLeft;
        [view setFrame:CGRectMake(view.origin.x, y, view.width, view.height)];
    } completion:^(BOOL finished) {
        [view setFrame:CGRectMake(view.origin.x, y, view.width, view.height)];
        [UIView animateWithDuration:0.1 animations:^{
            view.transform = moveRight;
            [view setFrame:CGRectMake(view.origin.x, y, view.width, view.height)];
        } completion:^(BOOL finished) {
            [view setFrame:CGRectMake(view.origin.x, y, view.width, view.height)];
            [UIView animateWithDuration:0.1 animations:^{
                view.transform = moveLeft;
                [view setFrame:CGRectMake(view.origin.x, y, view.width, view.height)];
            } completion:^(BOOL finished) {
                [view setFrame:CGRectMake(view.origin.x, y, view.width, view.height)];
                [UIView animateWithDuration:0.1 animations:^{
                    view.transform = resetTransform;
                    [view setFrame:CGRectMake(view.origin.x, y, view.width, view.height)];
                }];
            }];
        }];
    }];
}



+(UIImage *)screenCutFrom:(UIView *)viewDest withFrame:(CGRect)frameCut{
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(frameCut.size.width, frameCut.size.height), YES, 0);
    [viewDest.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return viewImage;
}


+ (UIImage *)addlogoImage:(UIImage *)imgLogo toImg:(UIImage *)baseImg withFrame:(CGRect) frame;
{
    UIGraphicsBeginImageContextWithOptions(baseImg.size, YES, 0);
    
    [baseImg drawInRect:CGRectMake(0, 0, baseImg.size.width, baseImg.size.height)];
    
    [imgLogo drawInRect:frame];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    //保存到album
    //    UIImageWriteToSavedPhotosAlbum(resultingImage, nil, nil, nil);
    
    return resultingImage;
}


+(UIImage *)combinImagefromArr:(NSArray *)imageArr withSize:(CGSize )sizeCon{
    CGFloat sizeH = 0;
    CGFloat screenScal = [UIScreen mainScreen].scale;
    for (UIImage *img in imageArr) {
        sizeH += CGImageGetHeight(img.CGImage)/screenScal;
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sizeCon.width, sizeH), YES, 0);
    CGFloat location_y = 0;
    for (int i =0 ; i<imageArr.count; i++) {
        UIImage *image = imageArr[i];
        CGFloat img_w = CGImageGetWidth(image.CGImage)/screenScal;
        CGFloat img_h = CGImageGetHeight(image.CGImage)/screenScal;
        
        [image drawInRect:CGRectMake(0, location_y, img_w, img_h)];
        
        location_y += CGImageGetHeight(image.CGImage)/screenScal;
    }
    
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImg;
}

+ (NSData *)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImagePNGRepresentation(newImage);
}



@end