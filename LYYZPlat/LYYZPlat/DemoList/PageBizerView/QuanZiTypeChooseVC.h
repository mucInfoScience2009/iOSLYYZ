//
//  QuanZiTypeChooseVC.h
//  yijianbao
//
//  Created by 龙学武 on 15/9/1.
//  Copyright (c) 2015年 offen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^qzTypeClock)(NSDictionary *typeDict);

@interface QuanZiTypeChooseVC : UIViewController


-(void)qzTypeChoose:(qzTypeClock)thisClock;



@end
