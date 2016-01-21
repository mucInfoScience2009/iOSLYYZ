//
//  CellQZ.h
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/28.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D_QZList.h"

typedef NS_ENUM(NSUInteger, QZType) {
    QZTypeClocked,
    QZTypeCanAdd,
    QZTypeAdded,
};

typedef void(^CellQZClock)(D_QZList *dQZList);

@interface CellQZ : UITableViewCell

@property(nonatomic,strong)UIImageView *imgvIcon;
@property(nonatomic,strong)UILabel *labelZQName;

@property(nonatomic,strong)UIButton *btnRightUP;

@property(nonatomic,strong)UIImageView *imgvMarkMember;
@property(nonatomic,strong)UILabel *labelMemberNo;

@property(nonatomic,strong)UIImageView *imgvMarkPost;
@property(nonatomic,strong)UILabel *labelPostNo;

@property(nonatomic,strong)UILabel *labelSubLeft;
@property(nonatomic,strong)UILabel *labelSubRight;

@property(nonatomic,strong)D_QZList *dQZList;

-(void)cellQZClock:(CellQZClock)thisClock;


+(CGFloat )cellH;


@end
