//
//  Control_BezierPath.h
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/25.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BezierPath) {
    BezierPathSixRect,
    BezierPathPentagram,
    BezierPathArrow,
};

@interface Control_BezierPath : UIControl


-(instancetype)initWithFrame:(CGRect)frame by:(BezierPath)bPath;

@property(nonatomic,strong)UIColor *colorFill;
@property(nonatomic,strong)UIColor *colorStroke;

@property(nonatomic,strong)UIImageView *imgvCenter;

@property(nonatomic,assign)BezierPath bpath;

@property(nonatomic,strong)UILabel *labelTitle;
@property(nonatomic,strong)NSString *title;


@property(nonatomic,assign)NSInteger colorIndex;


@end
