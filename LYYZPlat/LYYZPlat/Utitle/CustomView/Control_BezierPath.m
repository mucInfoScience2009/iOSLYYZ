//
//  Control_BezierPath.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/25.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import "Control_BezierPath.h"

@implementation Control_BezierPath{
    NSArray *_arrColor;
}


-(instancetype)initWithFrame:(CGRect)frame by:(BezierPath)bPath{
    if (self = [super initWithFrame:frame]) {
        _bpath = bPath;
        if (!_colorFill) {
            _colorFill = [UIColor clearColor];
        }
        if (!_colorStroke) {
            _colorStroke = [UIColor whiteColor];
        }
        self.labelTitle = [[UILabel alloc] initWithFrame:self.bounds];
        self.labelTitle.textAlignment = NSTextAlignmentCenter;
        self.labelTitle.numberOfLines = 0;
        [self addSubview:_labelTitle];


        self.imgvCenter = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height/2)];
        self.imgvCenter.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addSubview:_imgvCenter];


        _arrColor = @[[UIColor redColor],[UIColor blueColor],[UIColor purpleColor],[UIColor greenColor],[UIColor brownColor],[UIColor cyanColor],[UIColor darkGrayColor],[UIColor blackColor],[UIColor orangeColor]];

    }

    return self;
}


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];

    if (self.bpath == BezierPathPentagram) {
        [self bezierPentagram];
    }else if (self.bpath == BezierPathArrow){
        [self bezierArrow];
    }else if (self.bpath == BezierPathSixRect){
        [self bezierSixRect];
    }
}



-(void)setBPath:(BezierPath)bPath{
    _bpath = bPath;
    [self setNeedsDisplay];
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        printf("selected\n");
    }else{
        printf("noSelected\n");
    }
}
-(void)setColorFill:(UIColor *)colorFill{
    _colorFill = colorFill;
    [self setNeedsDisplay];
}
-(void)setColorStroke:(UIColor *)colorStroke{
    _colorStroke = colorStroke;
    [self setNeedsDisplay];
}
-(void)setColorIndex:(NSInteger)colorIndex{

    _colorIndex = colorIndex;

    if (_colorIndex<_arrColor.count) {
        self.colorFill = _arrColor[colorIndex];
    }

}




//绘制六边形
-(void)bezierSixRect{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGRect rect = self.frame;

    CGFloat part_w = rect.size.width/4;
//    找到留个定点
    CGPoint ld = CGPointMake(part_w, rect.size.height);
    CGPoint rd = CGPointMake(3*part_w, rect.size.height);
    CGPoint rm = CGPointMake(4*part_w, rect.size.height/2);
    CGPoint ru = CGPointMake(3*part_w, 0);
    CGPoint lu = CGPointMake(part_w, 0);
    CGPoint lm = CGPointMake(0, rect.size.height/2);


    [path moveToPoint:ld];
    [path addLineToPoint:rd];
    [path addLineToPoint:rm];
    [path addLineToPoint:ru];
    [path addLineToPoint:lu];
    [path addLineToPoint:lm];
    [path addLineToPoint:ld];

    [path closePath];

    [_colorStroke setStroke];
    [_colorFill setFill];

    [path stroke];
    [path fill];

    self.labelTitle.frame = CGRectMake(part_w, 0, 2*part_w, rect.size.height);
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.font = [UIFont boldSystemFontOfSize:part_w*0.8];

}


//绘制五角星
-(void)bezierPentagram{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGRect rect = self.frame;

    CGFloat p_one = M_PI/180;

    CGFloat  r = rect.size.width/2;
    CGFloat fix_w = tan(18*p_one)*2*r;
    CGFloat ang_w = fix_w/cos(36.0*p_one);

    CGPoint pa = CGPointMake(r, 0);
    CGPoint pab = CGPointMake(2*r-ang_w, 2*r-(r+tan(18*p_one)*2*r)*tan(36*p_one));
    CGPoint pb = CGPointMake(2*r, 2*r-(r+tan(18.0*p_one)*2*r)*tan(36*p_one));
    CGPoint pbc = CGPointMake(2*r-cos(36*p_one)*ang_w,2*r-(r+tan(18*p_one)*2*r)*tan(36*p_one)+sin(36*p_one)*ang_w);
    CGPoint pc = CGPointMake(r+tan(18.0*p_one)*2*r, 2*r);
    CGPoint pcd = CGPointMake(r, 2*r-sin(36*p_one)*ang_w);
    CGPoint pd = CGPointMake(r-fix_w, 2*r);
    CGPoint pde = CGPointMake(cos(36*p_one)*ang_w, 2*r-(r+tan(18*p_one)*2*r)*tan(36*p_one)+sin(36*p_one)*ang_w);
    CGPoint pe = CGPointMake(0,  2*r-(r+tan(18.0*p_one)*2*r)*tan(36*p_one));
    CGPoint pea = CGPointMake(ang_w,2*r-(r+tan(18.0*p_one)*2*r)*tan(36*p_one));

    

    [path moveToPoint:pa];
    [path addLineToPoint:pab];
    [path addLineToPoint:pb];
    [path addLineToPoint:pbc];
    [path addLineToPoint:pc];
    [path addLineToPoint:pcd];
    [path addLineToPoint:pd];
    [path addLineToPoint:pde];
    [path addLineToPoint:pe];
    [path addLineToPoint:pea];


    [path closePath];

    [_colorStroke setStroke];
    [_colorFill setFill];

    [path stroke];
    [path fill];
}

//绘制箭头
-(void)bezierArrow{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGRect rect = self.frame;

    [path moveToPoint:CGPointMake(rect.size.width/2, rect.size.height*0.1)];

    [path addLineToPoint:CGPointMake(rect.size.width*1.1, rect.size.height)];


    [path addLineToPoint:CGPointMake(-rect.size.width*0.1, rect.size.height)];

    //    [path addCurveToPoint:CGPointMake(0, rect.size.height) controlPoint1:CGPointMake(rect.size.width/2, rect.size.height) controlPoint2:CGPointMake(rect.size.width/2, rect.size.height)];

    [path closePath];

    [_colorStroke setStroke];
    [_colorFill setFill];

    [path stroke];
    [path fill];
}


@end
