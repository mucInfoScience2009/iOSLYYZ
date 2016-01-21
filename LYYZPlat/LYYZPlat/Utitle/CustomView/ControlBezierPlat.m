//
//  ControlBezierPlat.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/25.
//  Copyright (c) 2015年 林夕. All rights reserved.
//
//
//           BP
//      AP         CP
//
//           CC
//
//      FP          DP
//            EP
//
//
//
//
//
//

#import "ControlBezierPlat.h"

@interface ControlBezierPlat ()

@end

@implementation ControlBezierPlat{

}

CGPoint basePoint;

CGFloat curt_w;//中心到边的距离；
CGFloat span_P;//两个六边形中心点的距离。
CGFloat offset_x;//斜角相邻的六边形中心点的水平距离。
CGFloat offset_y;//斜角相邻的六边形中心点的垂直距离。

CGPoint arr[20];



- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles andYS:(NSArray *)arrImgY andNS:(NSArray *)arrImgN
{
    self = [super initWithFrame:frame];
    if (self) {
        _arrImgSYes = arrImgY;
        _arrImgSNo = arrImgN;
        _arrTitle = titles;
        
        [self configureUIItems];
    }
    return self;
}

-(void)initArrCenter{
    basePoint = CGPointMake(self.frame.size.width/1.5, self.frame.size.height/2.85);

    if (_cbp_w == 0) {
        _cbp_w = 30;
    }
    if (_span == 0) {
        _span = 5;
    }

    curt_w      = 0.5*sqrt(3)*_cbp_w;
    span_P      = curt_w*2+_span;//两个六边形中心点的距离。
    offset_x    = span_P*0.5*sqrt(3);//中心点的水平距离。
    offset_y    = span_P/2;//中心点的垂直距离。


    arr[0] = basePoint;
    arr[1] = getA_pointFrom(basePoint);
    arr[2] = [self getB_pointFrom:basePoint];
    arr[3] = [self getC_pointFrom:basePoint];
    arr[4] = [self getD_pointFrom:basePoint];
    arr[5] = [self getE_pointFrom:basePoint];
    arr[6] = [self getF_pointFrom:basePoint];

    arr[7] = [self getF_pointFrom:arr[6]];
    arr[8] = [self getE_pointFrom:arr[6]];
    arr[9] = [self getF_pointFrom:arr[8]];

    arr[10] = [self getD_pointFrom:arr[9]];
    arr[11] = [self getE_pointFrom:arr[9]];
    arr[12] = [self getF_pointFrom:arr[9]];

    arr[13] = [self getC_pointFrom:arr[10]];




}

-(void)configureUIItems{

    [self initArrCenter];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }

    CGRect rect = CGRectMake(0, 0, _cbp_w*2, _cbp_w*sqrt(3));

    if (!self.arrControl_BP) {
        _arrControl_BP = [NSMutableArray array];
    }
    [_arrControl_BP removeAllObjects];

    for (int i=0; i<_arrTitle.count; i++) {
        Control_BezierPath *controlBP = [[Control_BezierPath alloc] initWithFrame:rect by:BezierPathSixRect];
        controlBP.tag = i;
        controlBP.backgroundColor = [UIColor clearColor];

        controlBP.title = _arrTitle[i];
        controlBP.layer.shadowColor = [UIColor blackColor].CGColor;
        controlBP.layer.shadowOffset=CGSizeMake(0.8, 0.8);
        controlBP.layer.shadowOpacity=0.1;
        controlBP.colorStroke = [UIColor darkTextColor];
        controlBP.imgvCenter.image = [UIImage imageNamed:_arrImgSNo[i]];

//        [controlBP.layer setShadowRadius:2];

        [controlBP addTarget:self action:@selector(controlBPClick:) forControlEvents:UIControlEventTouchUpInside];

//        controlBP.labelTitle.text = _arrTitle[i];
        controlBP.center = arr[i];

        [_arrControl_BP addObject:controlBP];
        [self addSubview:controlBP];
    }
}


-(void)controlBPClick:(Control_BezierPath*)cBP{
    cBP.selected = !cBP.selected;

    NSArray *colorArr = @[[UIColor redColor],[UIColor blueColor],[UIColor purpleColor],[UIColor greenColor],[UIColor brownColor],[UIColor cyanColor],[UIColor darkGrayColor],[UIColor blackColor],[UIColor orangeColor]];

    if (cBP.selected) {
        cBP.colorFill = colorArr[cBP.tag%colorArr.count];
        cBP.colorStroke = [UIColor clearColor];
        cBP.imgvCenter.image = [UIImage imageNamed:_arrImgSYes[cBP.tag]];
        cBP.layer.shadowOpacity=1;


    }else{
        cBP.colorFill = [UIColor clearColor];
        cBP.colorStroke = [UIColor blackColor];
        cBP.layer.shadowOpacity=0.1;
        cBP.imgvCenter.image = [UIImage imageNamed:_arrImgSNo[cBP.tag]];

    }


    if (self.CBPBlock) {
        self.CBPBlock(cBP.tag);
    }
}


CGPoint getA_pointFrom(CGPoint point){
    CGPoint AP;

    CGFloat A_x = point.x - offset_x;
    CGFloat A_y = point.y - offset_y;

    AP = CGPointMake(A_x, A_y);
    return AP;
}


-(CGPoint)getB_pointFrom:(CGPoint)point{
    CGPoint BP;
    CGFloat B_y = point.y - _span - 2*curt_w;

    BP = CGPointMake(point.x, B_y);

    return BP;
}

-(CGPoint)getC_pointFrom:(CGPoint)point{
    CGPoint CP;

    CGFloat C_x = point.x + offset_x;
    CGFloat C_y = point.y - offset_y;

    CP = CGPointMake(C_x, C_y);

    return CP;
}

-(CGPoint)getD_pointFrom:(CGPoint)point{
    CGPoint DP;

    CGFloat D_x = point.x + offset_x;
    CGFloat D_y = point.y + offset_y;

    DP = CGPointMake(D_x, D_y);

    return DP;
}
-(CGPoint)getE_pointFrom:(CGPoint)point{
    CGPoint EP;

    CGFloat E_y = point.y + _span + 2*curt_w;

    EP = CGPointMake(point.x, E_y);

    return EP;
}

-(CGPoint)getF_pointFrom:(CGPoint)point{
    CGPoint FP;

    CGFloat F_x = point.x - offset_x;
    CGFloat F_y = point.y + offset_y;

    FP = CGPointMake(F_x, F_y);

    return FP;
}




-(void)setArrTitle:(NSArray *)arrTitle{
    _arrTitle = arrTitle;
    [self configureUIItems];
}
-(void)setSpan:(CGFloat)span{
    _span = span;
    [self configureUIItems];
}
-(void)setCbp_w:(CGFloat)cbp_w{
    _cbp_w = cbp_w;
    [self configureUIItems];
}

-(void)setArrSelected:(NSArray *)arrSelected{
    _arrSelected = arrSelected;
    NSArray *colorArr = @[[UIColor redColor],[UIColor blueColor],[UIColor purpleColor],[UIColor greenColor],[UIColor brownColor],[UIColor cyanColor],[UIColor darkGrayColor],[UIColor blackColor],[UIColor orangeColor]];

    for (int i=0; i<_arrControl_BP.count; i++) {
        Control_BezierPath *_CBP = _arrControl_BP[i];
        for (NSString *selectStr in arrSelected) {
            if ([selectStr isEqualToString:_arrTitle[i]]) {
                _CBP.selected = YES;

                if (_CBP.selected) {
                    _CBP.colorFill = colorArr[_CBP.tag%colorArr.count];
                    _CBP.colorStroke = [UIColor clearColor];
                    _CBP.imgvCenter.image = [UIImage imageNamed:_arrImgSYes[_CBP.tag]];
                    _CBP.layer.shadowOpacity=0.9;
                }
//                else{
//                    _CBP.colorFill = [UIColor clearColor];
//                    _CBP.colorStroke = [UIColor blackColor];
//                    _CBP.layer.shadowOpacity=0.1;
//                    _CBP.imgvCenter.image = [UIImage imageNamed:_arrTitleSelected[_CBP.tag]];
//                }
            }
        }
    }
}

@end





