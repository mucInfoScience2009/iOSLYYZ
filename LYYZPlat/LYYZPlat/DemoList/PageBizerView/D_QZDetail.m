//
//  D_QZDetail.m
//  yijianbao
//
//  Created by 龙学武 on 15/8/31.
//  Copyright (c) 2015年 offen. All rights reserved.
//

#import "D_QZDetail.h"

@implementation D_QZDetail


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
