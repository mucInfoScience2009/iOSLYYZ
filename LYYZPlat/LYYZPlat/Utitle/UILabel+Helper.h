//
//  UILabel+Helper.h
//  Stock
//
//  Created by liwt on 14/12/18.
//  Copyright (c) 2014年 com.tigerbrokers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Helper)

- (id) initWithFrame:(CGRect)frame size:(CGFloat)size;
- (id) initWithFrame:(CGRect)frame size:(CGFloat)size color:(UIColor *)color;
- (id) initWithFrame:(CGRect)frame font:(UIFont *)font color:(UIColor *)color;
- (id) initWithFrame:(CGRect)frame font:(UIFont *)font color:(UIColor *)color text:(NSString *)text;


@end
