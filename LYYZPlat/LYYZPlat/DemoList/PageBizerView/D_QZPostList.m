//
//  D_QZPostList.m
//  yijianbao
//
//  Created by 龙学武 on 15/9/1.
//  Copyright (c) 2015年 offen. All rights reserved.
//

#import "D_QZPostList.h"

@implementation D_QZPostList


-(void)setValue:(id)value forKey:(NSString *)key{
    if([key isEqualToString:@"id"])
        self.ID = value;
    else
        [super setValue:value forKey:key];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"file %s function %@ is calling",__FILE__, NSStringFromSelector(_cmd));
}


@end
