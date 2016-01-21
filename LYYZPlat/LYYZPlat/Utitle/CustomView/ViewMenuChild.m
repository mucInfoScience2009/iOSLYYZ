//
//  ViewMenuChild.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/27.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import "ViewMenuChild.h"

@interface ViewMenuChild ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ViewMenuChild


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self configureUIItems];
    }
    return self;
}

-(void)configureUIItems{

    _imgvBack = [[UIImageView alloc] initWithFrame:self.bounds];
    _imgvBack.backgroundColor = [UIColor blackColor];
    _imgvBack.alpha = 0.85;
    [self addSubview:_imgvBack];

    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    _tableView.scrollEnabled = NO;
    [self addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrItems.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"JOBJKOBJK";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [UIImage imageNamed:@"hello"];
    cell.textLabel.text = _arrItems[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];

    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.VMenuCClock) {
        self.VMenuCClock(indexPath.row);
    }
}

-(void)setArrItems:(NSArray *)arrItems{
    _arrItems = arrItems;
    [_tableView reloadData];
}

@end









