//
//  D_QZList.m
//  yijianbao
//
//  Created by 龙学武 on 15/8/31.
//  Copyright (c) 2015年 offen. All rights reserved.
//

#import "D_QZList.h"

@implementation D_QZList



-(void)setValue:(id)value forKey:(NSString *)key{
    if([key isEqualToString:@"id"])
        self.ID = value;
    else
        [super setValue:value forKey:key];
}

//因为pl 对象中没有test，系统崩溃,可在PlayList设置forUndefinedKey方法解决这个问题
//如果设置里面不存在key，就会触发这个方法
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"file %s function %@ is calling",__FILE__, NSStringFromSelector(_cmd));
}



@end
