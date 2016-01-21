//
//  LDropDown.h
//  EHealthy
//
//  Created by 龙学武 on 15-4-23.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownDelegate.h"

#define SECTION_BTN_TAG_BEGIN   1000
#define SECTION_IV_TAG_BEGIN    3000

@interface LDropDown : UIView<UITableViewDelegate,UITableViewDataSource>{
    NSInteger currentExtendSection;     //当前展开的section ，默认－1时，表示都没有展开
}
@property (nonatomic, assign) id<DropDownDelegate> dropDownDelegate;
@property (nonatomic, assign) id<DropDownChooseDataSource> dropDownDataSource;

@property (nonatomic, strong) UIView *mSuperView;
@property (nonatomic, strong) UIView *mTableBaseView;
@property (nonatomic, strong) UITableView *mTableView;

- (id)initWithFrame:(CGRect)frame dataSource:(id)datasource delegate:(id) delegate;
- (void)setTitle:(NSString *)title inSection:(NSInteger) section;

- (BOOL)isShow;

- (void)hideExtendedChooseView;



@end
