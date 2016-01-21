//
//  TBTableViewCellItem.m
//  Stock
//
//  Created by liwt on 14/12/18.
//  Copyright (c) 2014年 com.tigerbrokers. All rights reserved.
//

#import "TBTableViewCellItem.h"
#import "TBTableViewCell.h"

@implementation TBTableViewCellItem

- (Class) cellClass
{
    return [TBTableViewCell class];
}

- (CGFloat) cellHeight
{
    return 44;
}

- (CGFloat) heightForTableView:(UITableView *)inTableView
{
    return [[self cellClass] heightForObject:self tableView:inTableView];
}

//- (id)applyAction:(TTURLAction *)action
//{
//    self.action = action;
//    return self;
//}

- (id) applyActionBlock:(void (^)(void))actionBlock
{
    self.actionBlock = actionBlock;
    return self;
}

@end
