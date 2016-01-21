//
//  TBTableViewCell.h
//  Stock
//
//  Created by liwt on 14/12/18.
//  Copyright (c) 2014年 com.tigerbrokers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBTableViewDelegate.h"


@class TBTableViewCellItem;

@interface UITableViewCell (reuse)

+ (id)dequeueCellForTableView:(UITableView *)inTableView;

+ (CGFloat)heightForObject:(TBTableViewCellItem *)inItem tableView:(UITableView *) inTableView;

@end



@interface TBTableViewCell : UITableViewCell
{
    TBTableViewCellItem *_tableViewCellItem;
}
@property (nonatomic, strong) TBTableViewCellItem *tableViewCellItem;

@property (nonatomic, weak) id<TBTableViewDelegate> delegate;

@property (nonatomic, weak) UIColor *cellBackgroundColor;
@property (nonatomic, weak) UITableView *tableView;

- (void)configWithItem;

@end
