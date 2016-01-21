//
//  TBRegionListViewController.h
//  Stock
//
//  Created by xw.long on 15/11/4.
//  Copyright © 2015年 com.tigerbrokers. All rights reserved.
//

#import "XXRootViewController.h"
#import "TBRegionCell.h"

typedef void(^RegionListBlock)(TBRegion *region);

@interface TBRegionListViewController : XXRootViewController

-(void)region:(RegionListBlock)thisBlock;



@end
