//
//  PartTwoViewController.m
//  LYYZPlat
//
//  Created by xw.long on 16/1/16.
//  Copyright © 2016年 xw.long. All rights reserved.
//

#import "PartTwoViewController.h"

@interface PartTwoViewController ()

@end

@implementation PartTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    label.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:label];


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
