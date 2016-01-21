//
//  TBRegionShowView.h
//  Stock
//
//  Created by xw.long on 15/11/4.
//  Copyright © 2015年 com.tigerbrokers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBRegion.h"

typedef void(^RegionShowBlock)(TBRegion *region);

@interface TBRegionShowView : UIView


@property (nonatomic, strong) TBRegion *region;

-(void)regionShowBlock:(RegionShowBlock )thisBlock;




@end
