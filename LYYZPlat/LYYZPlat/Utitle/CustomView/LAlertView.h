//
//  LAlertView.h
//  yijianbao
//
//  Created by 龙学武 on 15/8/31.
//  Copyright (c) 2015年 offen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEFAULT_DISPLAY_DURATION 1.5f

@interface LAlertView : UIImageView{
    void(^lalertBlockCall)();
}

-(void)alertCallFunc:(void(^)())thisBlock;

@property(nonatomic,copy)dispatch_block_t overBlock;

@property(nonatomic,strong)UIImageView *backGroundView;

-(void)show;

-(void)showDismissAfter:(NSTimeInterval )timer;

-(id)initWithTitle:(NSString *)title;


@end
