//
//  TBRegionCell.h
//  Stock
//
//  Created by xw.long on 15/11/4.
//  Copyright © 2015年 com.tigerbrokers. All rights reserved.
//

#import "TBTableViewCell.h"
#import "TBRegionShowView.h"


typedef void(^RegionCellBlock)(TBRegion *region);

@interface TBRegionCell : TBTableViewCell


@property (nonatomic, strong) TBRegion *region;

-(void)regionCell:(RegionCellBlock )thisBlock;



@end
