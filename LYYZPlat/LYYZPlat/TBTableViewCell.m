//
//  TBTableViewCell.m
//  Stock
//
//  Created by liwt on 14/12/18.
//  Copyright (c) 2014年 com.tigerbrokers. All rights reserved.
//

#import "TBTableViewCell.h"
#import "TBTableViewCellItem.h"

@implementation UITableViewCell (reuse)

+ (id)dequeueCellForTableView:(UITableView *)inTableView
{
    TBTableViewCell *cell = [inTableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (! cell) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    return cell;
}

+ (CGFloat)heightForObject:(id)inItem tableView:(UITableView *)inTableView
{
    return 60;
}

@end



@implementation TBTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setCellBackgroundColor:[UIColor clearColor]];
        //[self setSelectionStyle:UITableViewCellSelectionStyleNone];
        //[self setSelectedBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageWithColor:TABLE_VIEW_CELL_SELECTED_COLOR]]];
        //[self setSelectedBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableViewCellSelectedBackground"]]];
//        [self setSelectedBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageWithColor:COMMOM_TABLE_CELL_SELECTED]]];
        
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
}

- (void)setCellBackgroundColor:(UIColor *)cellBackgroundColor
{
    [super setBackgroundColor:cellBackgroundColor];
}

- (UIColor *)cellBackgroundColor
{
    return self.backgroundColor;
}

- (void)setTableViewCellItem:(TBTableViewCellItem *)tableViewCellItem
{
    _tableViewCellItem = tableViewCellItem;
}

- (TBTableViewCellItem *)tableViewCellItem
{
    return _tableViewCellItem;
}

- (void) prepareForReuse
{
    [super prepareForReuse];
    self.tableViewCellItem.tableViewCell = nil;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configWithItem {
    // need Override
    MUCLog(@"need Override: set cell content.");
}

@end
