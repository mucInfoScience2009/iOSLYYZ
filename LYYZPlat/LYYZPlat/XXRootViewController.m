//
//  XXRootViewController.m
//  LYYZPlat
//
//  Created by xw.long on 16/1/15.
//  Copyright © 2016年 xw.long. All rights reserved.
//

#import "XXRootViewController.h"

@interface XXRootViewController ()

@end

@implementation XXRootViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //去透明属性导航
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
