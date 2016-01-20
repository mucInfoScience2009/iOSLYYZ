//
//  LoginViewController.m
//  LYYZPlat
//
//  Created by xw.long on 16/1/18.
//  Copyright © 2016年 xw.long. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"
#import "RegisterController.h"


@interface LoginViewController ()

@property(nonatomic,strong)NSMutableSet *localUser;

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

@end

@implementation LoginViewController


- (NSMutableSet *)localUser
{
    if (!_localUser) {
        //暂时可以本地存储用户名和密码
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        _localUser = [NSMutableSet setWithArray:array];
    }
    return _localUser;
}

- (IBAction)loginBntClick:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:@"登陆"]) {
        
        [self judeForLoginButtonClick];
        
    }else{
        //执行注册按钮的代码
        [self registerButtonClick];
        
    }
    
}

#pragma mark - 注册按钮的点击监听

- (void)registerButtonClick
{
//    //跳转到注册页面
    RegisterController *registerCv = [[RegisterController alloc]init];
    
    [self presentViewController:registerCv animated:YES completion:nil];
    
    
    
//    NSString *userName = self.userName.text;
//    
//    NSString *pwd = self.pwd.text;
//    
//    NSDictionary *dict = @{
//                           @"userName":userName,
//                           
//                           @"pwd":pwd
//                           
//                           };
//    
//    [self.localUser addObject:dict];
    
}

#pragma mark - 登陆按钮的点击监听
- (void)judeForLoginButtonClick
{
    NSString *userName = self.userName.text;
    
    NSString *pwd = self.pwd.text;
    
    int right = 0;
    
    int isUserDidIn = 0;
    
    for (NSDictionary *dict in self.localUser) {
        
        NSString *userNamedict = dict[@"userName"];
        
        NSString *pwdDict = dict[@"pwd"];
        
        if ([userName isEqualToString:userNamedict]) {
            
            isUserDidIn = 1;
            
            if ([userName isEqualToString:userNamedict] && [pwd isEqualToString:pwdDict]) {
                
                right = 1;
            }
        }
        
        
    }
    if (right) {
        
        //跳转到登陆完成的相应界面
//        [UIApplication sharedApplication].keyWindow.rootViewController = ;
    }else if (isUserDidIn){
//        密码错误
    }else{
//        提醒注册
    
    }
        

}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self performSelector:@selector(judgeForYourPower) withObject:self afterDelay:5];
    
    
    [self netGetSinaAuthToen];
    

}

-(void)judgeForYourPower{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"还犹豫啥？有一恶煞凶神位，正好缺个替补";
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:4];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"看你小子面相合适，允了~";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:4];
    });
}


-(void)netGetSinaAuthToen{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSString *urlSuffix  = @"https://api.weibo.com/2/common/get_country.json?";
    NSString *urlStr = [NSString stringWithFormat:@"%@source=%@&access_token=%@",urlSuffix,k_SINA_APP_KEY,k_SINA_TEMPTOKEN];
    
    
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];
}

@end
