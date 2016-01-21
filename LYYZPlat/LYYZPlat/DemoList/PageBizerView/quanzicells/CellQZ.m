//
//  CellQZ.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/28.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import "CellQZ.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation CellQZ{
    CGRect screenR;
    CGFloat ratio;

    CellQZClock _CLock;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        screenR = [[UIScreen mainScreen] bounds];
        ratio = screenR.size.width/320;

        [self configureUIItems];
    }
    return self;
}

-(void)configureUIItems{
    CGFloat span_w = 10*ratio;
    CGFloat span_up = 15*ratio;
    CGFloat icon_w = k_SizeIconBig_60;
    CGFloat span_in = 2*ratio;
    CGFloat iconSmall_w = k_SizeIconSmall_14;

    _imgvIcon = [[UIImageView alloc] initWithFrame:CGRectMake(span_w, span_up, icon_w, icon_w)];
    _imgvIcon.image = [UIImage imageNamed:@"faceImg22"];
    [self.contentView addSubview:_imgvIcon];


    _labelZQName = [[UILabel alloc] initWithFrame:CGRectMake(_imgvIcon.frame.origin.x+_imgvIcon.frame.size.width+span_w, span_up, screenR.size.width*0.6, k_CellFontBig_15)];
    _labelZQName.font = [UIFont systemFontOfSize:k_CellFontBig_15];
    _labelZQName.text = @"北大社交圈子";
    _labelZQName.textColor = [UIColor darkTextColor];
    [self.contentView addSubview:_labelZQName];


    _btnRightUP = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnRightUP.frame = CGRectMake(screenR.size.width-k_SizeIconSmall_27-10, _labelZQName.frame.origin.y, k_SizeIconSmall_27, k_SizeIconSmall_27);
    [_btnRightUP addTarget:self action:@selector(rightUpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if (arc4random()%2==0) {
        [_btnRightUP setBackgroundImage:[UIImage imageNamed:@"icon_quanzi_add"] forState:UIControlStateNormal];
    }else{
        [_btnRightUP setBackgroundImage:[UIImage imageNamed:@"icon_quanzi_lock"] forState:UIControlStateNormal];
    }
    [self.contentView addSubview:_btnRightUP];


    _imgvMarkMember = [[UIImageView alloc] initWithFrame:CGRectMake(_labelZQName.frame.origin.x, _labelZQName.frame.origin.y+_labelZQName.frame.size.height+span_in, iconSmall_w, iconSmall_w)];
    _imgvMarkMember.center = CGPointMake(_imgvMarkMember.center.x, _imgvIcon.center.y);
    _imgvMarkMember.image = [UIImage imageNamed:@"icon_quanzi_member"];
    [self.contentView addSubview:_imgvMarkMember];

    _labelMemberNo = [[UILabel alloc] initWithFrame:CGRectMake(_imgvMarkMember.frame.size.width+_imgvMarkMember.frame.origin.x+span_in, _imgvMarkMember.frame.origin.y, 80, iconSmall_w)];
    _labelMemberNo.textColor = UIColorFromRGB(0x666666);
    _labelMemberNo.font = [UIFont systemFontOfSize:k_CellFontSmall_13];
    _labelMemberNo.text = @"25个朋友";
    [self.contentView addSubview:_labelMemberNo];


    _imgvMarkPost = [[UIImageView alloc] initWithFrame:CGRectMake(screenR.size.width/2,  _imgvMarkMember.frame.origin.y, iconSmall_w, iconSmall_w)];
    _imgvMarkPost.center =  CGPointMake(_imgvMarkPost.center.x, _imgvIcon.center.y);
    _imgvMarkPost.image = [UIImage imageNamed:@"icon_quanzi_post"];
    [self.contentView addSubview:_imgvMarkPost];

    _labelPostNo = [[UILabel alloc] initWithFrame:CGRectMake(_imgvMarkPost.frame.size.width+_imgvMarkPost.frame.origin.x+span_in, _imgvMarkPost.frame.origin.y, 80*ratio, iconSmall_w)];
    _labelPostNo.textColor = UIColorFromRGB(0x666666);
    _labelPostNo.font = [UIFont systemFontOfSize:k_CellFontSmall_13];
    _labelPostNo.text = @"13";
    [self.contentView addSubview:_labelPostNo];


    _labelSubLeft = [[UILabel alloc] initWithFrame:CGRectMake(_labelZQName.frame.origin.x, _imgvIcon.frame.size.height+_imgvIcon.frame.origin.y-15, 70*ratio, k_CellFontSmall_12)];
    _labelSubLeft.text = @"[有奖问答]";
    _labelSubLeft.textColor = UIColorFromRGB(0x666666);
    _labelSubLeft.font = [UIFont systemFontOfSize:k_CellFontSmall_13];
    [self.contentView addSubview:_labelSubLeft];


    _labelSubRight = [[UILabel alloc] initWithFrame:CGRectMake(_labelSubLeft.frame.origin.x+_labelSubLeft.frame.size.width, _labelSubLeft.frame.origin.y, screenR.size.width-26-_labelSubLeft.frame.origin.x-_labelSubLeft.frame.size.width, k_CellFontSmall_12)];
    _labelSubRight.text = @"头疼发烧一直不好，中原厉鬼前来骚扰，怎能治疗";
    _labelSubRight.textColor = UIColorFromRGB(0x1a1a1a);
    _labelSubRight.font = [UIFont systemFontOfSize:13*ratio];
    [self.contentView addSubview:_labelSubRight];

}

-(void)rightUpBtnClick:(UIButton *)btn{
    NSLog(@"rightUpClicked ");
    if (_CLock) {
        _CLock(self.dQZList);
    }
}
-(void)cellQZClock:(CellQZClock)thisClock{
    _CLock = thisClock;
}

+(CGFloat )cellH{
    return k_SizeIconBig_60+2*15*[UIScreen mainScreen].bounds.size.width/320;
}


-(void)setDQZList:(D_QZList *)dQZList{
    _dQZList = dQZList;

    _labelZQName.text = _dQZList.name;
    _labelPostNo.text = _dQZList.con_num;
    _labelMemberNo.text = [NSString stringWithFormat:@"%@ 人",_dQZList.user_num];
    _labelSubRight.text = _dQZList.content;

    if ([_dQZList.is_pwd integerValue]) {
        [_btnRightUP setBackgroundImage:[UIImage imageNamed:@"icon_quanzi_lock"] forState:UIControlStateNormal];
    }else if([_dQZList.is_circle integerValue]==0){
        [_btnRightUP setBackgroundImage:[UIImage imageNamed:@"icon_quanzi_add"] forState:UIControlStateNormal];
    }else{
        [_btnRightUP setHidden:YES];
    }

}



@end
