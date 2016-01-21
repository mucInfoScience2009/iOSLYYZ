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
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:53.0/155 green:168.0/255 blue:252.0/255 alpha:1];
    
    
    //    设置导航条上文案的颜色
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:18], NSFontAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//
- (void)showHint:(NSString *)hint hide:(CGFloat)delay
{
    if (!hint || !hint.length) {
        return;
    }
    __block NSString *hintBlock = hint;
    dispatch_async(dispatch_get_main_queue(), ^{
        //TBLog(@"show hint loading");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setDetailsLabelFont:FONTO(14.0f)];
        [hud setRemoveFromSuperViewOnHide:YES];
        [hud setMode:MBProgressHUDModeText];
        [hud setDetailsLabelText:hintBlock];
        [hud hide:YES afterDelay:delay];
    });
}


-(void)showAlertControllerWithTitle:(NSString *)title andSubTitle:(NSString *)subTitle{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:subTitle preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"Yes I do" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];
    [alertController addAction:actionOne];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
