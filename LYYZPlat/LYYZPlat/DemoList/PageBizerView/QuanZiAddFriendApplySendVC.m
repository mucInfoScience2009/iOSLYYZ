//
//  QuanZiAddFriendApplySendVC.m
//  
//
//  Created by 龙学武 on 15/8/27.
//
//

#import "QuanZiAddFriendApplySendVC.h"

@interface QuanZiAddFriendApplySendVC ()

@end

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation QuanZiAddFriendApplySendVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.viewInputBack.layer.borderWidth = 1;
    self.viewInputBack.backgroundColor = [UIColor clearColor];
    self.viewInputBack.layer.borderColor = UIColorFromRGB(0xd9d9d9).CGColor;

}





@end
