//
//  Constant.h
//  LYYZPlat
//
//  Created by 龙学武 on 16/1/16.
//  Copyright © 2016年 xw.long. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

// Color helpers
#define RGBCOLOR(r,g,b)                                     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a)                                  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


#define RGBCOLOR_HEX(h)                                     RGBCOLOR((((h)>>16)&0xFF), (((h)>>8)&0xFF), ((h)&0xFF))
#define RGBACOLOR_HEX(h,a)                                  RGBACOLOR((((h)>>16)&0xFF), (((h)>>8)&0xFF), ((h)&0xFF), (a))
#define RGBPureColor(h)                                     RGBCOLOR(h, h, h)
#define HSVCOLOR(h,s,v)                                     [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:1]
#define HSVACOLOR(h,s,v,a)                                  [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:(a)]
#define RGBA(r,g,b,a)                                       (r)/255.0f, (g)/255.0f, (b)/255.0f, (a)





//标尺
#define k_SizeScreen [UIScreen mainScreen].bounds.size


//字体
#define FONTO(value)                                        [UIFont systemFontOfSize:value]
#define BOLDFONTO(value)                                    [UIFont boldSystemFontOfSize:value]





//
#ifdef DEBUG
#define MUCLog(fmt, ...)                                     NSLog((@"%s [MainThread=%i] [Line %d] " fmt), __PRETTY_FUNCTION__, [NSThread isMainThread], __LINE__, ##__VA_ARGS__);
#define MUCLog1(fmt, ...)

#else
#if BUILD_MODE == 0                                     //测试环境
#define MUCLog(fmt, ...)                             NSLog((@"%s [MainThread=%i] [Line %d] " fmt), __PRETTY_FUNCTION__, [NSThread isMainThread], __LINE__, ##__VA_ARGS__);
#define MUCLog1(fmt, ...)
#else                                                   //  online
#define MUCLog(fmt, ...)
#define MUCLog1(fmt, ...)
#endif
#endif


#endif /* Constant_h */
