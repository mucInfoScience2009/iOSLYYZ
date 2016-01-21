//
//  TBRegionCell.m
//  Stock
//
//  Created by xw.long on 15/11/4.
//  Copyright © 2015年 com.tigerbrokers. All rights reserved.
//

#import "TBRegionCell.h"

@interface TBRegionCell ()

@property (nonatomic, strong) TBRegionShowView *regionShowView;

@end

@implementation TBRegionCell{
    RegionShowBlock _RSBlock;
}
-(void)regionCell:(RegionCellBlock )thisBlock;
{
    _RSBlock = thisBlock;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        [self.contentView addSubview:self.regionShowView];
   
    }
    return self;
}

-(TBRegionShowView *)regionShowView{
    if (!_regionShowView) {
        _regionShowView = [[TBRegionShowView alloc] initWithFrame:CGRectMake(0, 0, k_RectScreen.size.width, 44)];
        [_regionShowView regionShowBlock:^(TBRegion *region) {
            if (_RSBlock) {
                _RSBlock(region);
            }
        }];
        
    }
    return _regionShowView;
}



-(void)setTableViewCellItem:(TBRegion *)tableViewCellItem{
    _region = tableViewCellItem;
    
    self.regionShowView.region = tableViewCellItem;
    
}


@end
