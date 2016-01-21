//
//  CellQZPostList.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/26.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import "CellQZPostList.h"

@interface CellQZPostList ()
@property(nonatomic,strong)UIImageView *imgvTop;
@property(nonatomic,strong)UIImageView *imgvNew;
@end



@implementation CellQZPostList

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureUIItems];
    }
    return self;
}

-(void)configureUIItems{

    CGRect screenR = [UIScreen mainScreen].bounds;



    _labelContent = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, screenR.size.width-20, 40)];
    _labelContent.text = @"我知道并不是耕耘就有收获，当眼泪流干后，蚂蚱蚂蚱吗是耕耘就有收获，当眼泪流干后，蚂蚱蚂蚱吗是耕耘就有收获，当眼泪流干后，蚂蚱蚂蚱吗";
    _labelContent.textColor = k_FontColor_1a;
    _labelContent.font = [UIFont systemFontOfSize:k_CellFontSmall_13];
    _labelContent.numberOfLines = 0;


    _imgvNew = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, k_SizeIconSmall_14, k_SizeIconSmall_14)];
//    _imgvNew.backgroundColor = [UIColor redColor];
    _imgvNew.image = [UIImage imageNamed:@"icon_quanzi_postNew"];
    _imgvTop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, k_SizeIconSmall_14, k_SizeIconSmall_14)];
//    _imgvTop.backgroundColor = [UIColor greenColor];
    _imgvTop.image = [UIImage imageNamed:@"icon_quanzi_postTop"];
    [_labelContent addSubview:_imgvNew];
    [_labelContent addSubview:_imgvTop];
    [_imgvTop setHidden:YES];
    [_imgvNew setHidden:YES];


    CGFloat down_y = _labelContent.frame.origin.y+_labelContent.frame.size.height+2;
    _labelTime = [[UILabel alloc] initWithFrame:CGRectMake(10, down_y, 60, 17)];
    _labelTime.textColor = k_FontColor_66;
    _labelTime.font = [UIFont systemFontOfSize:k_CellFontSmall_13];
    _labelTime.text = @"43分钟前";

    _labelName = [[UILabel alloc] initWithFrame:CGRectMake(70, down_y, 80, 17)];
    _labelName.font = [UIFont systemFontOfSize:k_CellFontSmall_13];
    _labelName.textColor = k_FontColor_66;
    _labelName.text = @"XueWu.long";

    _imgvRD = [[UIImageView alloc] initWithFrame:CGRectMake(screenR.size.width-70, down_y+2, k_SizeIconSmall_14, k_SizeIconSmall_14)];
    _imgvRD.image = [UIImage imageNamed:@"icon_quanzi_call"];
//    _imgvRD.backgroundColor = [UIColor grayColor];

    _labelNumber = [[UILabel alloc] initWithFrame:CGRectMake(_imgvRD.frame.size.width+_imgvRD.frame.origin.x+5, down_y,50, 17)];
    _labelNumber.textColor = k_FontColor_66;
    _labelNumber.font = [UIFont systemFontOfSize:k_CellFontSmall_13];
    _labelNumber.text = @"432";


    [self.contentView addSubview:_labelContent];
    [self.contentView addSubview:_labelTime];
    [self.contentView addSubview:_labelName];
    [self.contentView addSubview:_imgvRD];
    [self.contentView addSubview:_labelNumber];

}

-(void)setQzPLType:(QZPostListType)qzPLType{
    _qzPLType = qzPLType;
    if (qzPLType == QZPostListTypeNew) {
        [_imgvNew setHidden:NO];
        [_imgvTop setHidden:YES];
        _imgvNew.center = CGPointMake(_imgvNew.frame.size.width/2, _imgvNew.frame.size.height/2);
        _labelContent.text = [NSString stringWithFormat:@"    %@",_dqzPost.content];

    }else if (qzPLType == QZPostListTypeTop){
        [_imgvNew setHidden:YES];
        [_imgvTop setHidden:NO];
        _imgvTop.center = CGPointMake(_imgvTop.frame.size.width/2, _imgvTop.frame.size.height/2);
        _labelContent.text = [NSString stringWithFormat:@"    %@",_dqzPost.content];

    }else if (qzPLType == QZPostListTypeNewTop){
        [_imgvNew setHidden:NO];
        [_imgvTop setHidden:NO];
        _imgvTop.center = CGPointMake(_imgvTop.frame.size.width/2, _imgvTop.frame.size.height/2);
        _imgvNew.center = CGPointMake(_imgvNew.frame.size.width*2, _imgvNew.frame.size.height/2);
        _labelContent.text = [NSString stringWithFormat:@"          %@",_dqzPost.content];
    }else{
        [_imgvNew setHidden:YES];
        [_imgvTop setHidden:YES];
    }
}

+(CGFloat)cellQZPostHeigh{
    return 78;
}


-(void)setDqzPost:(D_QZPostList *)dqzPost{
    _dqzPost = dqzPost;
    _labelContent.text = dqzPost.content;
    _labelTime.text = dqzPost.create_time;
    _labelName.text = dqzPost.username;
    _labelNumber.text = dqzPost.reply_num;
//    _labelContent.backgroundColor = [UIColor yellowColor];

    CGFloat h_content = [CellQZPostList heightForCellWithDescription:_labelContent.text];

    _labelContent.frame = CGRectMake(_labelContent.frame.origin.x, _labelContent.frame.origin.y, _labelContent.frame.size.width, h_content);

    dqzPost.type = [NSString stringWithFormat:@"%u",arc4random()%4];
    if ([dqzPost.type intValue]==0) {
        self.qzPLType = QZPostListTypeNew;
    }else if ([dqzPost.type intValue]==1){
        self.qzPLType = QZPostListTypeTop;
    }else if ([dqzPost.type intValue]==2){
        self.qzPLType = QZPostListTypeNewTop;
    }else{
        self.qzPLType = QZPostListTypeNormal;
    }
}

#pragma mark - Public
+ (CGFloat) heightForCellWithDescription:(NSString *)description {
    CGFloat topMargin =0;// 8.0;
    CGFloat bottomMargin =0;// 8.0;
    CGFloat leftMargin = 10;
    CGFloat rightMargin = 10;


    static UILabel *label;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        label = [[UILabel alloc] init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = k_FontColor_1a;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.font = [UIFont systemFontOfSize:k_CellFontSmall_13];
    });
    label.text = description;
    CGSize size = [label sizeThatFits:CGSizeMake(([UIScreen mainScreen].bounds.size.width-leftMargin-rightMargin), CGFLOAT_MAX)];
    NSLog(@"height = %f",size.height);
    return topMargin+bottomMargin+size.height;
}


@end
