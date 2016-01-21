//
//  ControlBezierPlat.h
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/25.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Control_BezierPath.h"

@interface ControlBezierPlat : UIView



@property(nonatomic,assign)CGFloat span;
@property(nonatomic,assign)CGFloat cbp_w;


@property(nonatomic,strong)NSArray *arrTitle;
@property(nonatomic,strong)NSArray *arrImgSYes;
@property(nonatomic,strong)NSArray *arrImgSNo;


@property(nonatomic,strong)NSArray *arrSelected;

@property(nonatomic,strong,readonly)NSMutableArray *arrControl_BP;

@property(nonatomic,strong)void (^CBPBlock)(NSInteger index);


- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles andYS:(NSArray *)arrImgY andNS:(NSArray *)arrImgN;


@end
