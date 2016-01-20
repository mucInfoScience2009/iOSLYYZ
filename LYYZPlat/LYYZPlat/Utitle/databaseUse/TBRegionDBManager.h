//
//  TBRegionDBManager.h
//  Stock
//
//  Created by xw.long on 15/11/4.
//  Copyright © 2015年 com.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBRegion.h"
#import <sqlite3.h>

#define k_databaseName @"sql_Region.sqlite"

#define k_tableProvince @"table_province"
#define k_tableCity @"table_city"
#define k_tableDistrict @"table_district"

@interface TBRegionDBManager : NSObject

@property (nonatomic, strong) NSArray *arrPro;
@property (nonatomic, strong) NSArray *arrCity;
@property (nonatomic, strong) NSArray *arrDict;



+(TBRegionDBManager *)shareRegionDBManager;


-(NSArray *)getCitiesFromPro:(NSString *)proName;
-(NSArray *)getDistrictFromCity:(NSString *)cityName;




+(BOOL)regionOverInit;




+(BOOL)haveOldData;


+(void)saveCityArray:(NSArray *)cityArr;
+(void)saveDistrictArray:(NSArray *)countryArr;
+(void)saveProvinceArray:(NSArray *)proArr;


+(NSArray *)getProvinceArr;
+(NSArray *)getCityArrFromProvince:(NSString *)proName;
+(NSArray *)getDistrictArrFromCity:(NSString *)cityName;
+(TBRegion *)getProvinceFromCity:(NSString *)ctName;
+(TBRegion *)getCityFromDistrict:(NSString *)ctryName;


//获取指定首字母相同的所有城市数组
+(NSArray *)getCityArrCapitalWith:(NSString *)alpha fromCityArray:(NSArray *)arrCity;








@end
