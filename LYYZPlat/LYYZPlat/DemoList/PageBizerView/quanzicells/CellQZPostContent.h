//
//  CellQZPostContent.h
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/26.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^QZPostContentClock)(id thisObj);

@interface CellQZPostContent : UITableViewCell

@property(nonatomic,strong)UIImageView *imgvIcon;
@property(nonatomic,strong)UILabel *labelName;
@property(nonatomic,strong)UIView *viewMark;
@property(nonatomic,strong)UILabel *label_mark_rUp;
@property(nonatomic,strong)UILabel *label_mark_rDown;
@property(nonatomic,strong)UILabel *labelContent;

@property(nonatomic,strong)NSString *testStr;

+ (CGFloat) heightForCellWithDescription:(NSString *)description;

-(void)cellQZPostContent:(QZPostContentClock)thisBlock;




@end
