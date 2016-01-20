//
//  Region.m
//  Stock
//
//  Created by xw.long on 15/11/4.
//  Copyright © 2015年 com.tiger. All rights reserved.
//

#import "TBRegion.h"

@implementation TBRegion


-(id)initProvinceWithDict:(NSDictionary *)Dic{
    if (self = [super init]) {
        _province = [Dic objectForKey:@"province"];
        _ID = [Dic objectForKey:@"id"];
        _regionlevel = RegionLevelPro;
        
        _arrCity = [NSMutableArray array];
    }
    return self;
}
-(id)initCityWithDict:(NSDictionary *)Dic{
    if (self = [super init]) {
        _city = [Dic objectForKey:@"city"];
        _ID = [Dic objectForKey:@"id"];
        _regionlevel = RegionLevelCity;
        
        _arrDistrict = [NSMutableArray array];
    }
    return self;
}
-(id)initDistrictWithDict:(NSDictionary *)Dic{
    if (self = [super init]) {
        _district = [Dic objectForKey:@"district"];
        _ID = [Dic objectForKey:@"id"];
        _regionlevel = RegionLevelDist;
    }
    return self;
}


-(void)setSupID:(NSString *)supID{
    if (supID) {
        _supID = [[NSString alloc] initWithString:supID];
    }
}
-(void)setSupName:(NSString *)supName{
    if (supName) {
        _supName = [[NSString alloc] initWithString:supName];
    }
}

-(NSString *)description{
    return [NSString stringWithFormat:@"supId %@, supName %@, id %@,pro %@, city %@, dist%@",_supID,_supName,_ID,_province,_city,_district];
}

-(NSString *)showString{
    if (_regionlevel == RegionLevelDist) {
        return [NSString stringWithFormat:@"%@%@%@",_province,_city,_district];
    }else if (_regionlevel == RegionLevelCity){
        return [NSString stringWithFormat:@"%@%@",_province,_city];
    }else if (_regionlevel == RegionLevelPro){
        return [NSString stringWithFormat:@"%@",_province];
    }
    return _ID;
}


@end
