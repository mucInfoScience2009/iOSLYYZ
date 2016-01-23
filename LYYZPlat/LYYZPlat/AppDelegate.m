//
//  AppDelegate.m
//  LYYZPlat
//
//  Created by xw.long on 16/1/15.
//  Copyright © 2016年 xw.long. All rights reserved.
//

#import "AppDelegate.h"
#import "ZZCViewController.h"
#import "YQViewController.h"
#import "YTFViewController.h"
#import "HomeViewController.h"
#import "RKSwipeBetweenViewControllers.h"
#import "PartOneViewController.h"
#import "PartTwoViewController.h"
#import "PartThreeViewController.h"

#import "LoginViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UITabBarController *tabVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UITabBarController *tabC = [[UITabBarController alloc] init];
    
    UINavigationController *navHomeVC   = [[UINavigationController alloc] initWithRootViewController:[HomeViewController new]];
    UINavigationController *navZZCVC    = [[UINavigationController alloc] initWithRootViewController:[ZZCViewController new]];
    UINavigationController *navYTFVC    = [[UINavigationController alloc] initWithRootViewController:[YTFViewController new]];
    UINavigationController *navYQVC     = [[UINavigationController alloc] initWithRootViewController:[YQViewController new]];
    
    UIPageViewController *pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    RKSwipeBetweenViewControllers *navDemo = [[RKSwipeBetweenViewControllers alloc] initWithRootViewController:pageController];
    
    //%%% DEMO CONTROLLERS
    PartOneViewController *demo = [[PartOneViewController alloc] init];
    PartTwoViewController *demo2 = [PartTwoViewController new];
    PartThreeViewController *demo3 = [PartThreeViewController new];
    [navDemo.viewControllerArray addObjectsFromArray:@[demo,demo2,demo3]];
    tabC.viewControllers = @[navHomeVC,navZZCVC,navYTFVC,navYQVC,navDemo];
    tabC.selectedIndex = 0;
    
    for (UINavigationController *nav in tabC.viewControllers) {
        NSString *vcName = [NSString stringWithFormat:@"%@",NSStringFromClass([[nav.viewControllers lastObject] class])];
        nav.title = [vcName substringToIndex:[vcName rangeOfString:@"ViewController"].location];
        [nav.viewControllers lastObject].title = nav.title;
        
        
        UITabBarItem *itemOne = [[UITabBarItem alloc] initWithTitle:nav.title image:[UIImage imageNamed:@"icon_quanzi_add"] selectedImage:[UIImage imageNamed:@"icon_quanzi_lock"]];
        nav.tabBarItem = itemOne;
    }
    
    
    
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
    
    self.tabVC = tabC;
    
    
    
//    self.window.rootViewController = loginVC;
    self.window.rootViewController = tabC;
    
    
    
    NSString *charSpace = @" ";
    char space = [charSpace characterAtIndex:0];
    int codeIndex = space;
    printf("codeIndex = %d", codeIndex);
    
    [charSpace stringByAddingPercentEscapesOnce];
    
    
    
    NSString *hello = @"VBN我 代码 djj 是ll43 90";
    NSString *newHello = [self spac32FromString:hello];
    

    
    
    [self registerNitifications];
    
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

-(NSString *)spac32FromString:(NSString *)string{
    NSMutableString *newStr = [NSMutableString string];
    for (int i=0; i<string.length; i++) {
        NSString *charStr = [string substringWithRange:NSMakeRange(i, 1)];
        char space = [string characterAtIndex:i];
        int codeIndex = space;
        if (codeIndex == 160) {
            [newStr appendString:@" "];
        }else{
            [newStr appendString:charStr];
        }
    }
    return newStr;
}


-(void)registerNitifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rootViewControllerWithTabVC) name:k_noti_Login_Approval object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rootViewControllerWithTabVC) name:k_noti_Exit_Application object:nil];
}
-(void)rootViewControllerWithTabVC{
    self.window.rootViewController = self.tabVC;
}
-(void)exitYourApplicaiton{
        exit(0);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
