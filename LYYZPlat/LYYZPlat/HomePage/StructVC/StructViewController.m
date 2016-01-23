//
//  StructViewController.m
//  LYYZPlat
//
//  Created by xw.long on 16/1/23.
//  Copyright © 2016年 xw.long. All rights reserved.
//

#import "StructViewController.h"
#import "MyTabBarViewController.h"
#import "MyNavigationController.h"


@interface StructViewController ()

@end

@implementation StructViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btnDismiss = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDismiss.layer.borderWidth = 1;
    btnDismiss.layer.borderColor = RGBCOLOR_HEX(0x378e14).CGColor;
    btnDismiss.frame = CGRectMake(10, 10, 50, 50);
    [btnDismiss setTitle:@"<<{[" forState:UIControlStateNormal];
    [btnDismiss addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDismiss];
    
    
    
}

-(void)dismiss:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
