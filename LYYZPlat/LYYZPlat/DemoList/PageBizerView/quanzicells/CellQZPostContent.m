//
//  CellQZPostContent.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/26.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import "CellQZPostContent.h"

@implementation CellQZPostContent{
    QZPostContentClock _QZPCClock;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configureUIItems];
    }
    return self;
}

-(void)configureUIItems{

    CGRect screenR = [UIScreen mainScreen].bounds;
    CGFloat ratio = screenR.size.width/320;
    CGFloat fontValue = 14*ratio;


    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, screenR.size.width-100, 70)];
    [btnBack addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btnBack];

    _imgvIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    _imgvIcon.backgroundColor = [UIColor greenColor];
    _imgvIcon.image = [UIImage imageNamed:@"faceImg22"];
    [btnBack addSubview:_imgvIcon];

    _labelName = [[UILabel alloc] initWithFrame:CGRectMake(_imgvIcon.frame.size.width+_imgvIcon.frame.origin.x+10, _imgvIcon.center.y-12, 123, 24)];
    _labelName.text = @"花千骨";
//    [self.contentView addSubview:_labelName];
    [btnBack addSubview:_labelName];

    _labelContent = [[UILabel alloc] initWithFrame:CGRectMake(10, _imgvIcon.frame.size.height+_imgvIcon.frame.origin.y, screenR.size.width-20, 50)];
    _labelContent.text= @"北大青鸟岛上的软件技术，北大青鸟岛上的软件技术，北大青鸟岛上的软件技术，北大青鸟岛上的软件技术，北大青鸟岛上的软件技术，";
    _labelContent.numberOfLines = 0;
    _labelContent.font = [UIFont systemFontOfSize:fontValue];
    _labelContent.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:_labelContent];

    _label_mark_rUp = [[UILabel alloc] initWithFrame:CGRectMake(screenR.size.width-10-40, 5, 40, 15)];
    _label_mark_rUp.textAlignment = NSTextAlignmentRight;
    _label_mark_rUp.text = @"12楼";
    _label_mark_rUp.textColor = [UIColor lightGrayColor];
    _label_mark_rUp.font = [UIFont systemFontOfSize:fontValue];
    [self.contentView addSubview:_label_mark_rUp];

    _label_mark_rDown = [[UILabel alloc] initWithFrame:CGRectMake(screenR.size.width-10-100, _labelContent.frame.size.height+_labelContent.frame.origin.y, 100, 15)];
    _label_mark_rDown.textAlignment = NSTextAlignmentRight;
    _label_mark_rDown.textColor = [UIColor lightGrayColor];
    _label_mark_rDown.font = [UIFont systemFontOfSize:fontValue];
    _label_mark_rDown.text = @"2015-8-27";
    [self.contentView addSubview:_label_mark_rDown];



}

-(void)backBtnClick:(UIButton *)btn{
    NSLog(@"选中这个啦");
    if (_QZPCClock) {
        _QZPCClock(@"hello");
    }
}

-(void)cellQZPostContent:(QZPostContentClock)thisBlock{
    _QZPCClock = thisBlock;
}

#pragma mark - Public
+ (CGFloat) heightForCellWithDescription:(NSString *)description {
    CGFloat topMargin =5;// 8.0;
    CGFloat bottomMargin =0;// 8.0;
    CGFloat leftMargin = 10;
    CGFloat rightMargin = 10;


    static UILabel *label;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        label = [[UILabel alloc] init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor blackColor];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.font = [UIFont systemFontOfSize:13];
    });
    label.text = description;
    CGSize size = [label sizeThatFits:CGSizeMake(([UIScreen mainScreen].bounds.size.width-leftMargin-rightMargin), CGFLOAT_MAX)];
    NSLog(@"height = %f",size.height);
    return topMargin+bottomMargin+size.height+70+20;
}


-(void)setTestStr:(NSString *)testStr{
    _testStr = testStr;
    _labelContent.text = testStr;

    _labelContent.frame = CGRectMake(_labelContent.frame.origin.x, _labelContent.frame.origin.y, _labelContent.frame.size.width, [CellQZPostContent heightForCellWithDescription:testStr]-70-20);

    _label_mark_rDown.frame = CGRectMake(_label_mark_rDown.frame.origin.x, _labelContent.frame.size.height+_labelContent.frame.origin.y, _label_mark_rDown.frame.size.width, _label_mark_rDown.frame.size.height);
}


@end







