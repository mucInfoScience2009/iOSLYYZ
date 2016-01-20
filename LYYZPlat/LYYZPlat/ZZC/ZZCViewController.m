//
//  ZZCViewController.m
//  LYYZPlat
//
//  Created by xw.long on 16/1/15.
//  Copyright © 2016年 xw.long. All rights reserved.
//

#import "ZZCViewController.h"

@interface ZZCViewController ()

@end

@implementation ZZCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *image = [UIImage imageNamed:@"ff"];
    self.view.layer.contents = (id) image.CGImage;
    
}

-(UIAlertController *)setAlertControllerWithMessage:(NSString *)myMessage{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:myMessage message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:okAction];
    return alertController;
}

-(void)viewWillAppear:(BOOL)animated{
    UIAlertController *beginAlertConroller = [self setAlertControllerWithMessage:@"欢迎来到小周的世界"];
    [self presentViewController:beginAlertConroller animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [beginAlertConroller dismissViewControllerAnimated:YES completion:nil];
    });
}

@end
