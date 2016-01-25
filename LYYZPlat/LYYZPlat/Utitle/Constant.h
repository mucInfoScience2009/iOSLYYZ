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

#define COLOR_SEPERATE_LINE                                 RGBCOLOR_HEX(0x494756)
#define COMMOM_TABLE_CELL_SELECTED                          RGBCOLOR_HEX(0x6E6B61)
#define k_FontColor_66      RGBCOLOR_HEX(0x666666)
#define k_FontColor_1a      RGBCOLOR_HEX(0x1a1a1a)
#define k_FontColor_35a8fc  RGBCOLOR_HEX(0x35a8fc)
#define k_colorGray_F5      RGBCOLOR_HEX(0xf5f5f5)
#define k_colorGray_D9      RGBCOLOR_HEX(0xd9d9d9)



#define APPVERSION                                          ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"])
#define KEYFROM                                             [NSString stringWithFormat:@"TigerBrokers.%@.iPhone", APPVERSION]
#define DEVICE_OS_VERSION                                   [[[UIDevice currentDevice] systemVersion] floatValue]\
#define TBAvalibleOS(os_version)                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= os_version)

// 本地开户版本号, 和服务器的 open_version 字段比较. 如果 open_version > OPEN_ACCOUNT_VERSION, web 开户; 反之使用客户端的开户方式, 之前是 native, 有了 SDK 后用 SDK
// 开户 SDK 修改后, 由 SDK 维护一个开户版本号, 在 SDK 内部进行判断, OPEN_ACCOUNT_VERSION 不在使用
#define OPEN_ACCOUNT_VERSION                                (1)
//
#define IS_IPAD                                             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE                                           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA                                           ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH                                        ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT                                       ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH                                   (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH                                   (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS                                 (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5                                         (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6                                         (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P                                        (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)




//block refrence
#define weakSelf()                                          __weak __typeof(self) weakSelf = self
#define strongSelf()                                        __strong __typeof(weakSelf) strongSelf = weakSelf
#define blockSelf()                                         __block __typeof(self) blockSelf = self



//标尺
#define k_SizeScreen        [UIScreen mainScreen].bounds.size
#define k_RectScreen        ([[UIScreen mainScreen] bounds])
#define k_SpanIn            (k_RectScreen.size.width/80)
#define k_SpanLeft          (k_SpanIn * 2)
#define k_SpanVertical      (k_SpanIn)
#define k_SpanHorizontal    (k_SpanIn)

#define k_CellFontBig_15 (15+0)*[UIScreen mainScreen].bounds.size.width/320
#define k_CellFontSmall_13 (13+0)*[UIScreen mainScreen].bounds.size.width/320
#define k_CellFontSmall_12 (12+0)*[UIScreen mainScreen].bounds.size.width/320
#define k_SizeIconSmall_14 (14+0)*[UIScreen mainScreen].bounds.size.width/320
#define k_SizeIconSmall_27 (27+0)*[UIScreen mainScreen].bounds.size.width/320
#define k_SizeIconBig_60 (60+0)*[UIScreen mainScreen].bounds.size.width/320
#define k_ratio [UIScreen mainScreen].bounds.size.width/320



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
