//
//  TBRegionShowView.m
//  Stock
//
//  Created by xw.long on 15/11/4.
//  Copyright © 2015年 com.tigerbrokers. All rights reserved.
//

#import "TBRegionShowView.h"

@interface TBRegionShowView ()

@property (nonatomic, strong) UILabel *labelRegion;

@property (nonatomic, strong) UIButton *btnShow;

@end

@implementation TBRegionShowView{
    RegionShowBlock _RSBlock;
}

-(void)regionShowBlock:(RegionShowBlock )thisBlock;
{
    _RSBlock = thisBlock;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor darkTextColor];
        
        [self addSubview:self.labelRegion];
        [self addSubview:self.btnShow];
    }
    return self;
}

-(UILabel *)labelRegion{
    if (!_labelRegion) {
        _labelRegion = [[UILabel alloc] initWithFrame:CGRectMake(k_SpanLeft, 0, 200, 44)];
        _labelRegion.textColor  = RGBCOLOR_HEX(0xffffff);
        _labelRegion.font = [UIFont systemFontOfSize:16];
    }
    return _labelRegion;
    

}

-(UIButton *)btnShow{
    if (!_btnShow) {
        _btnShow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
        [_btnShow setTitleColor:RGBCOLOR_HEX(0xFFDC00) forState:UIControlStateNormal];
        _btnShow.titleLabel.font = [UIFont systemFontOfSize:15];
//        _btnShow.layer.borderColor = RGBCOLOR_HEX(0xFFDC00).CGColor;
//        _btnShow.layer.borderWidth = 1;
//        _btnShow.layer.cornerRadius = 5;
        if (_region.showSubRegion) {
            [_btnShow setTitle:@"收起" forState:UIControlStateNormal];
        }else{
            [_btnShow setTitle:@"展开" forState:UIControlStateNormal];
        }
        [_btnShow addTarget:self action:@selector(btnShowClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnShow;
}

-(void)btnShowClick:(UIButton *)btn{
    _region.showSubRegion = !_region.showSubRegion;
    if (_region.showSubRegion) {
        [_btnShow setTitle:@"展开" forState:UIControlStateNormal];
    }else{
        [_btnShow setTitle:@"收起" forState:UIControlStateNormal];
    }
    if (_RSBlock) {
        _RSBlock(_region);
    }
}

-(void)setRegion:(TBRegion *)region{
    _region = region;
    [self freshUIItems];
}

-(void)freshUIItems{
    [self.btnShow setHidden:NO];
    self.btnShow.centerX = self.width - 40;
    self.btnShow.centerY = self.height*0.5;

    if (_region.regionlevel == RegionLevelPro)
    {
        self.labelRegion.centerX = k_SpanLeft*2 + _labelRegion.width*0.5;
        self.labelRegion.text = _region.province;
    }
    else if (_region.regionlevel == RegionLevelCity)
    {
        self.labelRegion.centerX = k_SpanLeft*4 + _labelRegion.width*0.5;
        self.labelRegion.text = _region.city;
    }
    else if (_region.regionlevel == RegionLevelDist)
    {
        self.labelRegion.centerX = k_SpanLeft*6 + _labelRegion.width*0.5;
        self.labelRegion.text = _region.district;
        [self.btnShow setHidden:YES];
    }
    
    
    if (_region.showSubRegion) {
        [_btnShow setTitle:@"收起" forState:UIControlStateNormal];
    }else{
        [_btnShow setTitle:@"展开" forState:UIControlStateNormal];
    }

}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
