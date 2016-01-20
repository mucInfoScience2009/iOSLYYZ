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
    tabC.selectedIndex = 4;
    
    for (UINavigationController *nav in tabC.viewControllers) {
        NSString *vcName = [NSString stringWithFormat:@"%@",NSStringFromClass([[nav.viewControllers lastObject] class])];
        nav.title = [vcName substringToIndex:[vcName rangeOfString:@"ViewController"].location];
        [nav.viewControllers lastObject].title = nav.title;
    }
    
    
    
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    self.window.rootViewController = loginVC;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.window.rootViewController = tabC;
    });
    
    
    
    [self.window makeKeyAndVisible];
    return YES;
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
