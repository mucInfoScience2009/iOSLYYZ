//
//  MyTabBarViewController.m
//  LYYZPlat
//
//  Created by xw.long on 16/1/23.
//  Copyright © 2016年 xw.long. All rights reserved.
//

#import "MyTabBarViewController.h"

@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController


//-(void)viewWillAppear:(BOOL)animated{
//    [self.tabBarController.tabBar setHidden:YES];
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [self.tabBarController.tabBar setHidden:NO];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.top = 0;
    self.view.backgroundColor = [UIColor redColor];
    
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
