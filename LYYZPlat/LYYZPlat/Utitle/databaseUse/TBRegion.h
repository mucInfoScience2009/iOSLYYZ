//
//  Region.h
//  Stock
//
//  Created by xw.long on 15/11/4.
//  Copyright © 2015年 com.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RegionLevel) {
    RegionLevelPro,
    RegionLevelCity,
    RegionLevelDist,
};

@interface TBRegion : NSObject

@property (nonatomic, strong) NSString *supID;
@property (nonatomic, strong) NSString *supName;

@property (nonatomic, strong) NSString *province;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *district;

@property (nonatomic, strong) NSString *ID;

@property (nonatomic, assign) RegionLevel regionlevel;

@property (nonatomic, assign) BOOL showSubRegion;

@property (nonatomic, assign) NSIndexPath *indexPath;


@property (nonatomic, strong, readonly) NSString *showString;


@property (nonatomic,strong) NSMutableArray *arrCity;
@property (nonatomic,strong) NSMutableArray *arrDistrict;


-(id)initProvinceWithDict:(NSDictionary *)Dic;
-(id)initCityWithDict:(NSDictionary *)Dic;
-(id)initDistrictWithDict:(NSDictionary *)Dic;


@end
