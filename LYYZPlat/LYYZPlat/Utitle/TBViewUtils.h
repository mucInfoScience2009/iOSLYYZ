//
//  TBViewUtils.h
//  Stock
//
//  Created by liwt on 15/2/26.
//  Copyright (c) 2015年 com.tigerbrokers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBViewUtils : NSObject

+ (void) animationShakeView:(UIView *)view;


+ (UIImage *)screenCutFrom:(UIView *)viewDest withFrame:(CGRect)frameCut;

+ (UIImage *)addlogoImage:(UIImage *)imgLogo toImg:(UIImage *)baseImg withFrame:(CGRect) frame;

+ (UIImage *)combinImagefromArr:(NSArray *)imageArr withSize:(CGSize )sizeCon;

+ (NSData *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;


@end
