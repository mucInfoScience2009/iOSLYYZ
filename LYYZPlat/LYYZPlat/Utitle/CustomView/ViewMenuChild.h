//
//  ViewMenuChild.h
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/27.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ViewMenuChild : UIView


@property(nonatomic,strong)UIImageView *imgvBack;

@property(nonatomic,strong)NSArray *arrItems;

@property(nonatomic,strong)void (^VMenuCClock)(NSInteger index);



@end
