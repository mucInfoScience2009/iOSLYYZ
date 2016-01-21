//
//  DropDownDelegate.h
//  EHealthy
//
//  Created by 龙学武 on 15-4-23.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DropDownDelegate <NSObject>

@optional

-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index;
@end

@protocol DropDownChooseDataSource <NSObject>

-(NSInteger)numberOfSections;
-(NSInteger)numberOfRowsInSection:(NSInteger)section;
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index;
-(NSInteger)defaultShowSection:(NSInteger)section;


@end
