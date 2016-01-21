//
//  ScrollSegments.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/24.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import "ScrollSegments.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface ScrollSegments ()

@property (nonatomic,retain)NSArray *titleArray;
@property (nonatomic,retain)NSMutableArray *segmentBtnArray;
@property (nonatomic,retain)UIImageView *bottomLine;


@end

@implementation ScrollSegments{
    CGFloat width;
    CGFloat height;

    SSegBlock _SSBlok;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithArray:(NSArray *)titleArray andFrame:(CGRect )frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleArray = titleArray;
        self.segmentBtnArray = [NSMutableArray array];
//        self.backgroundColor = [UIColor yellowColor];
//        self.userInteractionEnabled = YES;

        [self initDefaultItems];
    }
    return self;

}

-(void)initDefaultItems{

    if (_titleArray.count<=5) {
        width = self.frame.size.width/_titleArray.count;
    }else{
        width = self.frame.size.width/5;
    }
    height = self.frame.size.height;


    for (int i=0; i<_titleArray.count; i++) {
        UIButton *segItem = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //        [segItem setFrame:CGRectMake(i*width, 0, width, height)];


        [segItem setFrame:CGRectMake(i*width, 0, width, height)];

        [segItem setTitle:[_titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [segItem addTarget:self action:@selector(segItemClick:) forControlEvents:UIControlEventTouchUpInside];
        segItem.titleLabel.textColor = UIColorFromRGB(0x1a1a1a);
        segItem.backgroundColor = [UIColor whiteColor];
        [segItem setTitleColor:i==0?UIColorFromRGB(0x35a8fc):UIColorFromRGB(0x1a1a1a) forState:UIControlStateNormal];
        [segItem.titleLabel setFont:[UIFont systemFontOfSize:15]];

        segItem.layer.borderWidth = 0.2;
        segItem.layer.borderColor = [UIColor clearColor].CGColor;
        segItem.tag = i;
        [_segmentBtnArray addObject:segItem];


        [self addSubview:segItem];
    }


    self.contentSize = CGSizeMake(width*_titleArray.count,self.bounds.size.height);



    _bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.15, height*0.92, width*0.7, height*0.06)];
    _bottomLine.backgroundColor = UIColorFromRGB(0x35a8fc);
    [self addSubview:_bottomLine];

    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame. size.height-1, width*self.titleArray.count, 0.6)];
    downLine.backgroundColor = UIColorFromRGB(0xd9d9d9);
    [self addSubview:downLine];

}


-(void)setSeletedIndex:(NSInteger)seletedIndex{
    _seletedIndex = seletedIndex;


    CGFloat offset = self.contentOffset.x;
    CGFloat btnFramX = _seletedIndex*width;

    NSLog(@"offset = %f,  btnfram.x = %f",offset,btnFramX);
    if (btnFramX - self.bounds.size.width+width >= offset) {
        if (_seletedIndex == _titleArray.count-1) {
            [self setContentOffset:CGPointMake(offset+width, 0) animated:YES];
        }else
            [self setContentOffset:CGPointMake(offset+width, 0) animated:YES];
    }else if (btnFramX - width <= offset){
        if (_seletedIndex == 0 || offset<=width/2) {

        }else{
            [self setContentOffset:CGPointMake(offset-width, 0) animated:YES];
        }
    }



    for (UIButton *btn  in self.segmentBtnArray) {
        [btn setTitleColor:UIColorFromRGB(0x1a1a1a) forState:UIControlStateNormal];
    }
    UIButton *seletedBtn = self.segmentBtnArray[seletedIndex];
    [seletedBtn setTitleColor:UIColorFromRGB(0x35a8fc) forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2f animations:^{
        [_bottomLine setCenter:CGPointMake(seletedBtn.center.x, _bottomLine.center.y)];
    }];

}


-(void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated{
    [super scrollRectToVisible:rect animated:animated];
    NSLog(@"%@",NSStringFromCGRect(rect));

}

-(void)segItemClick:(UIButton *)segItemBtn{
    CGFloat offset = self.contentOffset.x;
    CGFloat btnFramX = segItemBtn.frame.origin.x;

    int spanC = (offset/width);
    CGFloat  wi =-(offset - spanC*width);
    wi = 0;

    NSLog(@"offset = %f,  btnfram.x = %f",offset,btnFramX);
    if (btnFramX - self.bounds.size.width+width >= offset) {
        if (segItemBtn.tag == _titleArray.count-1) {

        }else{
            [self setContentOffset:CGPointMake(offset+width + wi, 0) animated:YES];
        }
    }else if (btnFramX - width <= offset){
        if (segItemBtn.tag == 0 || offset<=0) {

        }else{
            [self setContentOffset:CGPointMake(offset-width + wi, 0) animated:YES];
        }
    }



    for (UIButton *btn  in self.segmentBtnArray) {
        [btn setTitleColor:UIColorFromRGB(0x1a1a1a) forState:UIControlStateNormal];
    }
    [segItemBtn setTitleColor:UIColorFromRGB(0x35a8fc) forState:UIControlStateNormal];

    [UIView animateWithDuration:0.2f animations:^{
        [_bottomLine setCenter:CGPointMake(segItemBtn.center.x, _bottomLine.center.y)];
    }];
    NSLog(@"%@",segItemBtn.titleLabel.text);
    if (_SSBlok) {
        _SSBlok(segItemBtn.tag,self.seletedIndex>segItemBtn.tag? SSegDirectionRight:SSegDirectionLeft);
    }
    _seletedIndex = segItemBtn.tag;
}


-(void)sSegBlock:(SSegBlock)thisBlock{
    _SSBlok = thisBlock;
}


@end





