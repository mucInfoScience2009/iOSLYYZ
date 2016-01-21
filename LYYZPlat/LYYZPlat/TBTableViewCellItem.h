//
//  TBTableViewCellItem.h
//  Stock
//
//  Created by liwt on 14/12/18.
//  Copyright (c) 2014年 com.tigerbrokers. All rights reserved.
//

#import "TBObject.h"

@class TBTableViewCell;

@interface TBTableViewCellItem : TBObject

//@property (nonatomic, strong) TTURLAction *action;
@property (nonatomic, assign) CGFloat tableCellHeight;
@property (nonatomic, strong) void(^actionBlock)(void);
@property (nonatomic, weak) TBTableViewCell *tableViewCell;

@property (nonatomic, assign) NSInteger tag; // 当在同一个vc使用多个相同的cell item，用于互相区分
@property (nonatomic, strong) NSIndexPath *indexPath; // 记录cell的位置
@property (nonatomic, copy) NSString *statName; // 统计项名称, 用于记录点击统计

- (Class) cellClass;

- (CGFloat) cellHeight;

- (CGFloat) heightForTableView:(UITableView *)inTableView;

//- (id)applyAction:(TTURLAction *)action;

- (id)applyActionBlock:(void(^)(void))actionBlock;

@end
