//
//  LAlertView.m
//  yijianbao
//
//  Created by 龙学武 on 15/8/31.
//  Copyright (c) 2015年 offen. All rights reserved.
//

#import "LAlertView.h"

@interface LAlertView ()

@property (nonatomic,strong)UILabel *label_title;
@property(nonatomic,strong)NSString *title;

@end

@implementation LAlertView

+(LAlertView *)shareLAlertView{
    static LAlertView *lAlertview;
    if (!lAlertview) {
        lAlertview = [[self alloc] init];
    }
    return lAlertview;
}


-(id)initWithTitle:(NSString *)title{
    self = [LAlertView shareLAlertView];
    //    if ( self = [super init]) {
    self.frame = CGRectMake(0, 0, 260, 100);

    NSMutableString *muStr = [NSMutableString stringWithString:title];
    for (int i=0; i<muStr.length; i++) {
        NSString *str = [muStr substringWithRange:NSMakeRange(i, 1)];
        if ([@"0123456789!@#$%^&*(),.!" rangeOfString:str].length) {
            [muStr replaceCharactersInRange:NSMakeRange(i, 1) withString:@"字"];
        }
    }
    //    您投递的简历未通过审核！不可以申请职位，本次申请失败！请与我们的客服人员联系!!
    self.title = title;

//    UIFont *font = [UIFont systemFontOfSize:17];

//    CGSize sizecondition = [muStr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];

//    float alert_h = (sizecondition.height*sizecondition.width)/(self.frame.size.width-30);
//    alert_h = alert_h > 40 ? alert_h : 40;

    float alert_h = 40;
    self.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, alert_h+20);
    //        if (iPhone6) {
    //            self.center = CGPointMake(k_Size6.width/2, k_Size6.height/2);
    //        }else if (iPhone6Plus){
    //            self.center = CGPointMake(k_Size6P.width/2, k_Size6P.width/2);
    //        }else{
    ////            self.center = CGPointMake(320/2, [self appRootViewController].view.frame.size.height/2);
    //            UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    //            self.center = CGPointMake(320/2,window.bounds.size.height/2);
    //        }

    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    self.center = CGPointMake(window.bounds.size.width/2,window.bounds.size.height/2);


    self.backgroundColor = [UIColor clearColor];
    self.image = [UIImage imageNamed:@"bar_alert_rect"];


    [self setOtherUIItems];

    //    }
    return self;
}
-(void)setOtherUIItems{

    if (!self.label_title) {
        self.label_title = [[UILabel alloc] initWithFrame:CGRectMake(15,10, self.frame.size.width-30, self.frame.size.height-10)];
        self.label_title.textColor = [UIColor whiteColor];
        self.label_title.numberOfLines = 0;
        self.label_title.textAlignment = NSTextAlignmentCenter;
        self.label_title.font = [UIFont systemFontOfSize:15];
        self.label_title.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addSubview:_label_title];
    }
    self.label_title.text = _title;

    //    self.layer.cornerRadius = 10;

#if 0
    UIViewController *topVC = [self appRootViewController];
    if (!self.backGroundView) {
        self.backGroundView = [[UIImageView alloc] initWithFrame:topVC.view.bounds];
        self.backGroundView.backgroundColor = [UIColor blackColor];
        self.backGroundView.alpha = 0.5f;
        self.backGroundView.userInteractionEnabled = YES;
        self.backGroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

        UITapGestureRecognizer *tapg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureInfoGo)];
        [self.backGroundView addGestureRecognizer:tapg];
    }
    [topVC.view addSubview:self.backGroundView];
#endif

}

-(void)tapGestureInfoGo
{
    lalertBlockCall();

    [self.backGroundView removeFromSuperview];

    [self removeFromSuperview];
}

-(void)alertCallFunc:(void (^)())thisBlock{
    lalertBlockCall = thisBlock;
}


- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    [topVC.view addSubview:self];

    self.backGroundView.alpha = 0;
    [UIView animateWithDuration:0.2f animations:^{
        self.backGroundView.alpha = 0.5;
    }];
}

-(void)showDismissAfter:(NSTimeInterval)timer{
    //    UIViewController *topVC = [self appRootViewController];
    //    [topVC.view addSubview:self];
    //    [topVC.view bringSubviewToFront:self];

    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [window addSubview:self];
    [window bringSubviewToFront:self];

    self.backGroundView.alpha = 0;
    self.alpha = 0;
    [UIView animateWithDuration:0.25f animations:^{
        self.backGroundView.alpha = 0.5;
        self.alpha = 1;
    }];

    float second = 1000000*timer;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        usleep(second);
        dispatch_async(dispatch_get_main_queue(), ^{

            [UIView animateWithDuration:0.25 animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                [self.backGroundView removeFromSuperview];
                [self removeFromSuperview];
            }];
        });
    });
}

- (UIViewController *)appRootViewController
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    return window.rootViewController;

#if 0
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
#endif
    
}




@end
