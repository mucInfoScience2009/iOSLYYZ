//
//  TBRegionDBManager.m
//  Stock
//
//  Created by xw.long on 15/11/4.
//  Copyright © 2015年 com.tiger. All rights reserved.
//

#import "TBRegionDBManager.h"
#import "NSString+Utilities.h"


static BOOL _overRegionInit;
@implementation TBRegionDBManager

+(TBRegionDBManager *)shareRegionDBManager{
    static TBRegionDBManager *shareRegionManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareRegionManager = [[TBRegionDBManager alloc] init];
    });
    return shareRegionManager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"sqlite3path = %@",[TBRegionDBManager pathCacheFile]);
    }
    return self;
}




//-(NSArray *)getCitiesFromPro:(NSString *)proName{
////    NSMutableArray *
//    
//}
//-(NSArray *)getDistrictFromCity:(NSString *)cityName{
//    
//}












+(NSString *)pathCacheFile{
    NSArray *pathArray =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[pathArray lastObject] stringByAppendingPathComponent:k_databaseName];
    
    return filePath;
}

+(BOOL)regionOverInit{
    return _overRegionInit;
}

+(BOOL)haveOldData{
    NSFileManager *fManager = [NSFileManager defaultManager];
    MUCLog(@"filePath = %@",[TBRegionDBManager pathCacheFile]);
    if ([fManager fileExistsAtPath:[TBRegionDBManager pathCacheFile]]) {
        MUCLog(@"judge have dabafile");
        // do SOme  for more safe and security
        return YES;
    }
    return NO;
}



+(NSArray *)sortOrderCityArr:(NSArray *)array{
    NSMutableArray *lastArray = [NSMutableArray array];
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (TBRegion *region in array) {
        if (region.regionlevel == RegionLevelCity) {
            [tmpArray addObject:[region.city getAllString]];
        }else if(region.regionlevel == RegionLevelDist){
            [tmpArray addObject:[region.district getAllString]];
        }else{
            [tmpArray addObject:[region.province getAllString]];
        }
    }
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *resultArray = [tmpArray sortedArrayUsingDescriptors:descriptors];
    for (NSString *str in resultArray) {
        [lastArray addObject:[array objectAtIndex: getIndexOfCity(str ,tmpArray)]];
    }
    return lastArray;
}

NSInteger getIndexOfCity(NSString *str, NSArray *array){
    return [array indexOfObject:str];
}

+(NSArray *)getCityArrCapitalWith:(NSString *)alpha fromCityArray:(NSArray *)arrCity{
    NSMutableArray *alphaCapitalArr = [NSMutableArray array];
    for (TBRegion *region in arrCity) {
        NSString *capital = [[region.city getCapitalString] substringToIndex:1];
        if ([capital isEqualToString:alpha] ) {
            [alphaCapitalArr addObject:region];
        }
    }
    return alphaCapitalArr;
}







+(void)saveCityArray:(NSArray *)cityArr;{
    [self saveArr:cityArr inTable:k_tableCity];
}
+(void)saveDistrictArray:(NSArray *)countryArr{
    [self saveArr:countryArr inTable:k_tableDistrict];
}
+(void)saveProvinceArray:(NSArray *)proArr{
    [self saveArr:proArr inTable:k_tableProvince];
}




+(BOOL)execSql:(NSString *)sql withDB:(sqlite3 *)_db{
    char *err;
    BOOL isSuccess = sqlite3_exec(_db, [sql UTF8String], NULL,NULL, &err)==SQLITE_OK;
    free(err);
    return isSuccess;
}





+(void)saveArr:(NSArray *)array inTable:(NSString *)table{
    //打开数据库
    sqlite3 *_db;
    if (sqlite3_open([[TBRegionDBManager pathCacheFile] UTF8String], &_db)!=SQLITE_OK) {
        sqlite3_close(_db);
        return;
    }
    char *error;
    
    //销毁原来的表
#if 1
    if(sqlite3_exec(_db, [[NSString stringWithFormat:@"drop table %@",table] UTF8String], NULL, NULL, &error)==SQLITE_OK){
        NSLog(@"drop table success");
    }
#endif
    
    NSString *sqlStr;
    if ([table isEqualToString:k_tableCity]) {
        sqlStr = [[NSString alloc] initWithFormat:@"create table if not exists %@ (order_id integer primary key autoincrement, ID text,city text,supid text,supname text)",table];
    }else if ([table isEqualToString:k_tableDistrict]){
        sqlStr = [[NSString alloc] initWithFormat:@"create table if not exists %@ (order_id integer primary key autoincrement, ID text,district text,supid text,supname text)",table];
    }else if ([table isEqualToString:k_tableProvince]){
        sqlStr = [[NSString alloc] initWithFormat:@"create table if not exists %@ (order_id integer primary key autoincrement, ID text,province text)",table];
    }
    
    if (sqlite3_exec(_db, [sqlStr UTF8String], NULL, NULL, &error)==SQLITE_OK) {
        NSLog(@"create table success。");
    }else{
        NSLog(@"create table fail");
        free(error);
        sqlite3_close(_db);
        return;
    }
    //插入数据之前，清空表中的所有数据。
    NSString *delTableDataStr = [NSString stringWithFormat:@"delete from %@",table];
    sqlite3_exec(_db, [delTableDataStr UTF8String], NULL, NULL, &error);
    
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//    });
    
    _overRegionInit = NO;

    
    TBRegion *regionTemp = [array firstObject];
    NSString *insertSql;
    if (regionTemp.regionlevel == RegionLevelCity)
    {
        for (TBRegion *region in array) {
            insertSql = [NSString stringWithFormat:@"insert into '%@' ('ID','city','supid','supname') values ('%@','%@','%@','%@')",table,region.ID,region.city,region.supID,region.supName];
            [TBRegionDBManager execSql:insertSql withDB:_db];
        }
    }
    else if (regionTemp.regionlevel == RegionLevelDist)
    {
        for (TBRegion *region in array) {
            insertSql = [NSString stringWithFormat:@"insert into '%@' ('ID','district','supid','supname') values ('%@','%@','%@','%@')",table,region.ID,region.district,region.supID,region.supName];
            [TBRegionDBManager execSql:insertSql withDB:_db];
        }
    }
    else if(regionTemp.regionlevel == RegionLevelPro)
    {
        for (TBRegion *region in array) {
            insertSql = [NSString stringWithFormat:@"insert into '%@' ('ID','province') values ('%@','%@')",table,region.ID,region.province];
            [TBRegionDBManager execSql:insertSql withDB:_db];
        }
    }
    
    //开始插入数据
    
    _overRegionInit = YES;
    
    sqlite3_close(_db);
}


+(NSArray *)getProvinceArr;
{
    NSMutableArray *provinceArr;
    //打开数据库
    sqlite3 *_db;
    if (sqlite3_open([[TBRegionDBManager pathCacheFile] UTF8String], &_db)!=SQLITE_OK) {
        sqlite3_close(_db);
        return provinceArr;
    }
    
    NSString *sqlQuery = [NSString stringWithFormat:@"select %@.ID,%@.province from %@",k_tableProvince,k_tableProvince,k_tableProvince];
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(_db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        provinceArr = [NSMutableArray array];
        while (sqlite3_step(statement)==SQLITE_ROW) {
            char *ctID = (char *)sqlite3_column_text(statement, 0);
            char *ctname = (char *)sqlite3_column_text(statement, 1);
            
            NSString *proID= [NSString stringWithUTF8String:ctID];
            NSString *proName = [NSString stringWithUTF8String:ctname];
            
            TBRegion *region = [TBRegion new];
            region.ID = proID;
            region.province = proName;
            region.regionlevel = RegionLevelPro;
            [provinceArr addObject:region];
        }
    }
    
    sqlite3_close(_db);
    return provinceArr;
}


+(NSArray *)getCityArrFromProvince:(NSString *)proName;
{
    NSMutableArray *cityArr;
    //打开数据库
    sqlite3 *_db;
    if (sqlite3_open([[TBRegionDBManager pathCacheFile] UTF8String], &_db)!=SQLITE_OK) {
        sqlite3_close(_db);
        return cityArr;
    }
    
    NSString *sqlQuery = [NSString stringWithFormat:@"select %@.ID,%@.city,%@.supid,%@.supname from %@,%@ where %@.ID=%@.supid and %@.province='%@'",k_tableCity,k_tableCity,k_tableCity,k_tableCity,k_tableCity,k_tableProvince,k_tableProvince,k_tableCity,k_tableProvince,proName];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        cityArr = [NSMutableArray array];
        while (sqlite3_step(statement)==SQLITE_ROW) {
            char *ctID = (char *)sqlite3_column_text(statement, 0);
            char *ctname = (char *)sqlite3_column_text(statement, 1);
            char *ctsupid = (char *)sqlite3_column_text(statement, 2);
            char *ctsupname = (char *)sqlite3_column_text(statement, 3);
            
            NSString *cname = [NSString stringWithUTF8String:ctname];
            NSString *cID= [NSString stringWithUTF8String:ctID];
            NSString *csupID = [NSString stringWithUTF8String:ctsupid];
            NSString *csupName = [NSString stringWithUTF8String:ctsupname];
            
            TBRegion *region = [TBRegion new];
            region.ID = cID;
            region.city = cname;
            region.supID = csupID;
            region.supName = csupName;
            region.province = csupName;
            region.regionlevel = RegionLevelCity;
            
            [cityArr addObject:region];
        }
    }
    
    sqlite3_close(_db);

    return [TBRegionDBManager sortOrderCityArr:cityArr];
    return cityArr;
}

+(NSArray *)getDistrictArrFromCity:(NSString *)cityName;
{
    NSMutableArray *districtArr;
    //打开数据库
    sqlite3 *_db;
    if (sqlite3_open([[TBRegionDBManager pathCacheFile] UTF8String], &_db)!=SQLITE_OK) {
        sqlite3_close(_db);
        return districtArr;
    }
    NSString *sqlQuery = [NSString stringWithFormat:@"select %@.ID,%@.district,%@.supid,%@.supname from %@,%@ where %@.supid=%@.ID and %@.city='%@'",k_tableDistrict,k_tableDistrict,k_tableDistrict,k_tableDistrict,k_tableDistrict,k_tableCity,k_tableDistrict,k_tableCity,k_tableCity,cityName];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        districtArr = [NSMutableArray array];
        while (sqlite3_step(statement)==SQLITE_ROW) {
            char *ctryID = (char *)sqlite3_column_text(statement, 0);
            char *ctryname = (char *)sqlite3_column_text(statement, 1);
            char *ctrysupID = (char *)sqlite3_column_text(statement, 2);
            char *ctrysupname = (char *)sqlite3_column_text(statement, 3);

            NSString *distID= [NSString stringWithUTF8String:ctryID];
            NSString *distname = [NSString stringWithUTF8String:ctryname];
            NSString *distsupid = [NSString stringWithUTF8String:ctrysupID];
            NSString *distsupname = [NSString stringWithUTF8String:ctrysupname];
            
            TBRegion *region = [[TBRegion alloc] init];
            region.ID = distID;
            region.district = distname;
            region.supID = distsupid;
            region.supName = distsupname;
            region.city = distsupname;
            
            
            TBRegion *proR = [TBRegionDBManager getProvinceFromCity:distsupname];
            region.province = proR.province;
            
            
            
            region.regionlevel = RegionLevelDist;
            
            [districtArr addObject:region];
        }
    }
    
    sqlite3_close(_db);
    
    return [TBRegionDBManager sortOrderCityArr:districtArr];
    return districtArr;
}

+(TBRegion *)getProvinceFromCity:(NSString *)ctName;
{
    NSMutableArray *rArr;
    //打开数据库
    sqlite3 *_db;
    if (sqlite3_open([[TBRegionDBManager pathCacheFile] UTF8String], &_db)!=SQLITE_OK) {
        sqlite3_close(_db);
        return nil;
    }
    NSString *sqlQuery = [NSString stringWithFormat:@"select %@.ID,%@.province from %@,%@ where %@.city='%@' and %@.ID=%@.supid",k_tableProvince,k_tableProvince,k_tableProvince,k_tableCity,k_tableCity,ctName,k_tableProvince,k_tableCity];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        rArr = [NSMutableArray array];
        while (sqlite3_step(statement)==SQLITE_ROW) {
            char *ctID = (char *)sqlite3_column_text(statement, 0);
            char *ctname = (char *)sqlite3_column_text(statement, 1);

            NSString *cname = [NSString stringWithUTF8String:ctname];
            NSString *cID= [NSString stringWithUTF8String:ctID];
            
            TBRegion *proR = [[TBRegion alloc] init];
            proR.ID = cID;
            proR.province = cname;
            proR.regionlevel = RegionLevelPro;
            
            [rArr addObject:proR];
        }
    }
    
    sqlite3_close(_db);

    return [rArr lastObject];
}
+(TBRegion *)getCityFromDistrict:(NSString *)ctryName;
{
    NSMutableArray *rArr;
    //打开数据库
    sqlite3 *_db;
    if (sqlite3_open([[TBRegionDBManager pathCacheFile] UTF8String], &_db)!=SQLITE_OK) {
        sqlite3_close(_db);
        return nil;
    }
    NSString *sqlQuery = [NSString stringWithFormat:@"select %@.ID,%@.city from %@,%@ where %@.district='%@' and %@.ID=%@.supid",k_tableCity,k_tableCity,k_tableCity,k_tableDistrict,k_tableDistrict,ctryName,k_tableCity,k_tableDistrict];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        rArr = [NSMutableArray array];
        while (sqlite3_step(statement)==SQLITE_ROW) {
            char *ctID = (char *)sqlite3_column_text(statement, 0);
            char *ctname = (char *)sqlite3_column_text(statement, 1);
            NSString *cID= [NSString stringWithUTF8String:ctID];
            NSString *cname = [NSString stringWithUTF8String:ctname];

            TBRegion *cityR = [[TBRegion alloc] init];
            cityR.ID = cID;
            cityR.city = cname;
            cityR.regionlevel = RegionLevelCity;
            
            TBRegion *proR = [TBRegionDBManager getProvinceFromCity:cname];
            cityR.supName = proR.province;
            cityR.supID = proR.ID;
            
            [rArr addObject:cityR];
        }
    }
    
    return [rArr lastObject];
}







@end
