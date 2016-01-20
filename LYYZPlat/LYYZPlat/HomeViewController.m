//
//  HomeViewController.m
//  LYYZPlat
//
//  Created by xw.long on 16/1/15.
//  Copyright © 2016年 xw.long. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) UIAlertController *alertController;

@end


@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    

    
}

-(void)viewWillAppear:(BOOL)animated{
    [self presentViewController:self.alertController animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.alertController dismissViewControllerAnimated:YES completion:nil];
    });
}

-(UIAlertController *)alertController{
    if (!_alertController) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"起航的时候，你从最简单的页面，一夜一页翻阅，愿后浪破风沉，留得宁静在林夕" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:okAction];
        _alertController = alertController;
    }
    
    return _alertController;
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
