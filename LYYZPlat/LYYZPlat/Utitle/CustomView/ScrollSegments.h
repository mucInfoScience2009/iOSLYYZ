//
//  ScrollSegments.h
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/24.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, SSegDirection) {
    SSegDirectionRight,
    SSegDirectionLeft,
    SSegDirectionNone,
};

typedef void(^SSegBlock)(NSInteger seletedIndex,SSegDirection direction);


@interface ScrollSegments : UIScrollView


-(id)initWithArray:(NSArray *)titleArray andFrame:(CGRect )frame;

-(void)sSegBlock:(SSegBlock)thisBlock;


@property(nonatomic,assign)NSInteger seletedIndex;

@end
