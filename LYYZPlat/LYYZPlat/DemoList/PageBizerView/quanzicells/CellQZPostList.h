//
//  CellQZPostList.h
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/26.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "D_QZPostList.h"

typedef NS_ENUM(NSUInteger, QZPostListType) {
    QZPostListTypeNormal,
    QZPostListTypeNew,
    QZPostListTypeTop,
    QZPostListTypeNewTop
};

@interface CellQZPostList : UITableViewCell

@property(nonatomic,strong)UILabel *labelContent;
@property(nonatomic,strong)UILabel *labelTime;
@property(nonatomic,strong)UILabel *labelName;
@property(nonatomic,strong)UIImageView *imgvRD;//右下图标
@property(nonatomic,strong)UILabel *labelNumber;

@property(nonatomic,assign)QZPostListType qzPLType;

@property(nonatomic,assign)D_QZPostList *dqzPost;


+(CGFloat)cellQZPostHeigh;



@end
