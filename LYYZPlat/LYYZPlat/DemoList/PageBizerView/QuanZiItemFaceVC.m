//
//  QuanZiItemFaceVC.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/26.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import "QuanZiItemFaceVC.h"
#import "ControlBezierPlat.h"
#import "LAlertView.h"

@interface QuanZiItemFaceVC ()

@property(nonatomic,strong)UIImageView *backImgV;
@property(nonatomic,strong)UIButton *btnChooseSure;


@end


#define kQuanZiChooseItemKey @"CGUIKBJKLBHJKHJKVHJKVHJK"


@implementation QuanZiItemFaceVC{
    CGRect screenR;
    UIAlertView *_alertV;
    NSArray *_titleArr;
    NSMutableArray *_arrSelected;
    NSUserDefaults *_UDF;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];

    screenR = [[UIScreen mainScreen] bounds];

    _UDF = [NSUserDefaults standardUserDefaults];
//    [_UDF setObject:@[] forKey:kQuanZiChooseItemKey];
//    [_UDF synchronize];
    NSArray *arr = [_UDF objectForKey:kQuanZiChooseItemKey];
    if (!_arrSelected) {
        _arrSelected = [NSMutableArray array];
    }
    if (arr) {
        [_arrSelected addObjectsFromArray:arr];
    }

    [self setUIConfigure];
}

-(void)setUIConfigure{

//    背景图
    self.backImgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.backImgV setImage:[UIImage imageNamed:@"faceImg"]];
    [self.view addSubview:self.backImgV];

//    底部确定按钮
    UIButton *btnChooseSure = [[UIButton alloc] initWithFrame:CGRectZero];
    [btnChooseSure setFrame: CGRectMake(0, 0, 100*screenR.size.width/320, 30*screenR.size.width/320)];
    [btnChooseSure setCenter: CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height*0.92)];
    [btnChooseSure addTarget:self action:@selector(chooseItemSure:) forControlEvents:UIControlEventTouchUpInside];
    [btnChooseSure setBackgroundImage:[UIImage imageNamed:@"btn_qz_faceS_no"] forState:UIControlStateNormal];
//    [btnChooseSure setBackgroundImage:[UIImage imageNamed:@"btn_qz_faceS_yes"] forState:UIControlStateSelected];
    _btnChooseSure = btnChooseSure;
    [self.view addSubview:btnChooseSure];

//    添加六边形选项按钮控件
    [self getControlBezierPlat];

}


-(void)getControlBezierPlat{

    _titleArr =@[@"汽车",@"旅游",@"经济",@"科技数码",@"健康",@"同乡",@"娱乐",@"女性天地",@"情感",@"家居生活",@"校友",@"其他",@"创业",@"社会万象"];
    NSArray *arrImgN =@[@"QiC_D",@"LvY_D",@"JingJ_D",@"KeJSM_D",@"JianK_D",@"TongX_D",@"YuL_D",@"NvXTD_D",@"QingG_D",@"JiaJSH_D",@"XiaoY_D",@"QiT_D",@"ChuangY_D",@"SheHWX_D"];
    NSArray *arrImgS = @[@"QiC",@"LvY",@"JingJ",@"KeJSM",@"JianK",@"TongX",@"YuL",@"NvXTD",@"QingG",@"JiaJSH",@"XiaoY",@"QiT",@"ChuangY",@"SheHWX"];

    ControlBezierPlat *_CBP = [[ControlBezierPlat alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.9) withTitles:_titleArr andYS:arrImgS andNS:arrImgN];

    CGFloat ratio = screenR.size.width/320;
    _CBP.cbp_w = 32*ratio;
    _CBP.span = 10*ratio;

    
    __block ControlBezierPlat *weekCBP = _CBP;
    _CBP.CBPBlock = ^(NSInteger index){
        NSLog(@"choose %@",_titleArr[index]);
        Control_BezierPath *temp_BP = weekCBP.arrControl_BP[index];

        //先对temp_BP标记做一次清空
        for (int i=0; i<_arrSelected.count; i++) {
            if ([_arrSelected[i] isEqualToString:temp_BP.title]) {
                [_arrSelected removeObjectAtIndex:[_arrSelected indexOfObject:temp_BP.title]];
            }
        }
        [_arrSelected removeAllObjects];

        for (Control_BezierPath *c_BP in weekCBP.arrControl_BP) {
            if (c_BP.selected) {
                [_arrSelected addObject:c_BP.title];
            }
        }

        for (Control_BezierPath *c_BP in weekCBP.arrControl_BP) {
            if (c_BP.selected) {
                self.btnChooseSure.selected = YES;
                [_btnChooseSure setBackgroundImage:[UIImage imageNamed:@"btn_qz_faceS_yes"] forState:UIControlStateNormal];
                break;
            }

            [_btnChooseSure setBackgroundImage:[UIImage imageNamed:@"btn_qz_faceS_no"] forState:UIControlStateNormal];
            self.btnChooseSure.selected = NO;
        }
    };

    [self.view addSubview:_CBP];




    if (_arrSelected.count) {
        _CBP.arrSelected = _arrSelected;
        [_btnChooseSure setBackgroundImage:[UIImage imageNamed:@"btn_qz_faceS_yes"] forState:UIControlStateNormal];
        self.btnChooseSure.selected = YES;
    }
}


-(void)chooseItemSure:(UIButton *)btn{
    if (btn.selected == YES) {
        if (self.IFBlock) {

            [_UDF setObject:_arrSelected forKey:kQuanZiChooseItemKey];
            [_UDF synchronize];

            self.IFBlock(_arrSelected);
        }
    }else{


//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您需至少选择一个哦！" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
//        _alertV = alertView;
//        [alertView show];
//        [self performSelector:@selector(alertHidden) withObject:self afterDelay:2.0];

        LAlertView *_lAlert = [[LAlertView alloc] initWithTitle:@"至少选择一个哦^_^"];
        [_lAlert showDismissAfter:2.0];


    }
}
-(void)alertHidden{
    [_alertV dismissWithClickedButtonIndex:0 animated:YES];
}


@end






