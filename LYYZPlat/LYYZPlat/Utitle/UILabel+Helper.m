//
//  UILabel+Helper.m
//  Stock
//
//  Created by liwt on 14/12/18.
//  Copyright (c) 2014年 com.tigerbrokers. All rights reserved.
//

#import "UILabel+Helper.h"

@implementation UILabel (Helper)

- (id)initWithFrame:(CGRect)frame size:(CGFloat)size
{
    return [self initWithFrame:frame font:FONTO(size) color:nil];
}

- (id)initWithFrame:(CGRect)frame size:(CGFloat)size color:(UIColor *)color
{
    return [self initWithFrame:frame font:FONTO(size) color:color];
}

- (id) initWithFrame:(CGRect)frame font:(UIFont *)font color:(UIColor *)color
{
    return [self initWithFrame:frame font:font color:color text:@""];
}

- (id) initWithFrame:(CGRect)frame font:(UIFont *)font color:(UIColor *)color text:(NSString *)text
{
    
    self = [self initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        if (font) {
            self.font = font;
        }else{
            self.font = FONTO(12.0f);
        }
        if (color) {
            self.textColor = color;
        }else{
            self.textColor = [UIColor whiteColor];
        }
        self.text = text;
        self.adjustsFontSizeToFitWidth = YES;
        self.minimumScaleFactor = 0.75;
    }
    return self;

}



@end
