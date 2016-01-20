//
//  DataBaseUtils.m
//  LYYZPlat
//
//  Created by xw.long on 16/1/18.
//  Copyright © 2016年 xw.long. All rights reserved.
//

#import "DataBaseUtils.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"


@implementation DataBaseUtils
@synthesize fmdb;

+ (instancetype)sharedInstance
{
    static DataBaseUtils *manager = nil;
    NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defauts valueForKey:USER_DEFAULT_KEY_UUID];
    if (!userId) {
        manager = nil;
    }
    
    if (manager && ![manager.userID isEqualToString:userId]){
        manager = nil;
    }
    
    if (! manager){
        manager = [[[self class] alloc] init];
    }
    return manager;
}


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        userId = [defaults valueForKey:USER_DEFAULT_KEY_UUID];
        //	创建数据库
        
        // set user id.
        if(!userId){
            userId = @"tmpUser";
        }
        //
        [self mkdirOfTigerBrokersDB];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/TigerDB/%@_%@", userId,DATABASE_FILE_NAME]];
        //TBLog(@"database path : %@", dbPath);
        
        fmdb = [FMDatabase databaseWithPath:dbPath];
        
        // create tables.
        if ([fmdb open]) {
            if (![fmdb tableExists:TABLE_NAME_SEARCH_HISTORY]){
                [fmdb executeUpdate:SQL_CREATE_SEARCH_HISTORY_TABLE];
                //TBLog(@"create table search history");
            }
            
            if (![fmdb tableExists:TABLE_NAME_WATCH_LIST]){
                [fmdb executeUpdate:SQL_CREATE_WATCH_LIST_TABLE];
                //TBLog(@"create table watch list");
            }
            
            if (![fmdb tableExists:TABLE_NAME_MESSAGE_LIST]){
                [fmdb executeUpdate:SQL_CREATE_MESSAGE_LIST_TABLE];
                //NSLog(@"create table watch list");
            }
            
            if (![fmdb tableExists:TABLE_NAME_PUSH_MESSAGE]) {
                [fmdb executeUpdate:SQL_CREATE_PUSH_MESSAGE_TABLE];
            }
            
            if (![fmdb tableExists:TABLE_NAME_POST_DRAFT]) {
                [fmdb executeUpdate:SQL_CREATE_POST_DRAFT_TABLE];
            }
            
            [fmdb close];
        }
        
    }
    return self;
    
}

- (NSString *)userID
{
    return userId;
}


-(void)mkdirOfTigerBrokersDB{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/TigerDB"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
}

-(void)createTable{
    if (self) {
        if ([fmdb open]) {
            if (![fmdb tableExists:TABLE_NAME_SEARCH_HISTORY]){
                [fmdb executeUpdate:SQL_CREATE_SEARCH_HISTORY_TABLE];
                //TBLog(@"create table search history");
            }
            
            if (![fmdb tableExists:TABLE_NAME_WATCH_LIST]){
                [fmdb executeUpdate:SQL_CREATE_WATCH_LIST_TABLE];
                //TBLog(@"create table watch list");
            }
            
            if (![fmdb tableExists:TABLE_NAME_MESSAGE_LIST]){
                [fmdb executeUpdate:SQL_CREATE_MESSAGE_LIST_TABLE];
                //NSLog(@"create table watch list");
            }
            
            if (![fmdb tableExists:TABLE_NAME_POST_DRAFT]) {
                BOOL suc = [fmdb executeUpdate:SQL_CREATE_POST_DRAFT_TABLE];
            }
            
            [fmdb close];
        }
    }
}

-(long)getWatchListCount
{
    FMResultSet *rs;
    long count = 0;
    if ([fmdb open]) {
        
        rs = [fmdb executeQuery:SQL_QUERY_WATCH_LIST_COUNT];
        if ([rs next]){
            count = [rs longForColumnIndex:0];
        }
        [fmdb close];
    }
    
    return count;
    
}


- (NSArray *)getWatchListAll
{
    FMResultSet *rs;
    NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:1];
    if ([fmdb open]) {
        rs = [fmdb executeQuery:SQL_QUERY_WATCH_LIST_ALL_FORMAT];
        while ([rs next]) {
            [resultArr addObject:[rs resultDictionary]];
        }
        [fmdb close];
    }
    return resultArr;
}

- (BOOL)existInWatchList:(NSString *)symbol
{
    FMResultSet *rs;
    NSDictionary *dict;
    if ([fmdb open]) {
        
        rs = [fmdb executeQuery:SQL_QUERY_WATCH_LIST_SINGLE_FORMAT, symbol];
        if ([rs next]){
            dict = [rs resultDictionary];
        }
        [fmdb close];
    }
    return dict != nil;
}

- (NSDictionary *)getWatchListById:(NSString *)symbol
{
    FMResultSet *rs;
    NSDictionary *dict = [[NSDictionary alloc] init];
    if ([fmdb open]) {
        
        rs = [fmdb executeQuery:SQL_QUERY_WATCH_LIST_SINGLE_FORMAT, symbol];
        if ([rs next]){
            dict = [rs resultDictionary];
        }
        [fmdb close];
    }
    return dict;
}


-(void)deleteWatchListById:(NSString *)symbol
{
    if ([fmdb open]) {
        
        BOOL success = [fmdb executeUpdate:SQL_DELETE_WATCH_LIST_FORMAT, symbol];
        if (success) {
            //TBLog(@"delete symbolID : %@ from watch list db success.", symbol);
        }else{
            //TBLog(@"delete symbolID : %@ from watch list db failed.", symbol);
        }
        [fmdb close];
    }
}


- (void) addWatchList:(NSDictionary *)watchListData
{
    if ([fmdb open]) {
        
        [fmdb executeUpdate:SQL_DELETE_WATCH_LIST_FORMAT, [watchListData objectForKey:@"symbol"]];
        //
        BOOL success = [fmdb executeUpdate:SQL_INSERT_WATCH_LIST_FORMAT, [watchListData objectForKey:@"symbol"], [watchListData objectForKey:@"nameCN"], [watchListData objectForKey:@"market"], [watchListData objectForKey:@"time"]];
        if (success) {
            //TBLog(@" success add watch list to db : %@", watchListData);
        }else{
            //TBLog(@" failed add watch list to db : %@", watchListData);
        }
        [fmdb close];
    }
}

-(void)batchAddWatchList:(NSArray*)queryArray
{
    if (!queryArray || !queryArray.count) {
        return;
    }
    if ([fmdb open]) {
        [fmdb beginTransaction];
        @try {
            for (NSInteger i=0; i<queryArray.count; i++) {
                NSDictionary *watchListData = [queryArray objectAtIndex:i];
                //
                BOOL success = [fmdb executeUpdate:SQL_INSERT_WATCH_LIST_FORMAT, [watchListData objectForKey:@"symbol"], [watchListData objectForKey:@"nameCN"], [watchListData objectForKey:@"market"], [watchListData objectForKey:@"time"]];
                if (success) {
                    //TBLog(@" success add watch list to db : %@", watchListData);
                }else{
                    //TBLog(@" failed add watch list to db : %@", watchListData);
                }
            }
        }
        @catch (NSException *exception) {
            MUCLog(@"batch add watch list exception: %@", [exception reason]);
            [fmdb rollback];
        }
        @finally {
            [fmdb commit];
            [fmdb close];
        }
    }
    
}

- (void)clearWatchListData
{
    if ([fmdb open]) {
        BOOL success = [fmdb executeUpdate:SQL_CLEAR_WATCH_LIST_FORMAT];
        if (success) {
            //TBLog(@"delete * from watch list successful.");
        }else{
            //TBLog(@"failed clear watch list.");
        }
        [fmdb close];
    }
}



- (long) getSearchHistoryCount
{
    FMResultSet *rs;
    long count =0;
    if ([fmdb open]) {
        
        rs = [fmdb executeQuery:SQL_QUERY_SEARCH_HISTORY_COUNT_FORMAT];
        if ([rs next]){
            count = [rs longForColumnIndex:0];
        }
        [fmdb close];
    }
    
    return count;
    
}

- (NSArray *)getSearchHistoryAllLimit10
{
    FMResultSet *rs;
    NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:1];
    if ([fmdb open]) {
        rs = [fmdb executeQuery:SQL_QUERY_SEARCH_HISTORY_ALL_FORMAT];
        while ([rs next]) {
            [resultArr addObject:[rs resultDictionary]];
        }
        [fmdb close];
    }
    return resultArr;
}

- (void) addSearchHistory:(NSDictionary *)searchHistoryData
{
    NSString *symbol = [searchHistoryData objectForKey:@"symbol"];
    if (!symbol) {
        return;
    }
    if ([self existInHistoryList:symbol]) {
        [self deleteHistoryById:symbol];
    }
    
    if ([fmdb open]) {
        
        BOOL success = [fmdb executeUpdate:SQL_INSERT_SEARCH_HISTORY_FORMAT, symbol, [searchHistoryData objectForKey:@"nameCN"], [searchHistoryData objectForKey:@"market"], [searchHistoryData objectForKey:@"time"]];
        if (success) {
            MUCLog(@"successful add search history to db : %@", searchHistoryData);
        }else{
            MUCLog(@"failed add search history to db. %@", searchHistoryData);
        }
        [fmdb close];
    }
}

- (void)clearSearchHistoryData
{
    if ([fmdb open]) {
        BOOL success = [fmdb executeUpdate:SQL_CLEAR_SEARCH_HISTORY_FORMAT];
        if (success) {
            MUCLog(@"successful delete * from search history");
        }else{
            MUCLog(@"failed to clear search history.");
        }
        [fmdb close];
    }
}

-(BOOL) existInHistoryList:(NSString *)symbol
{
    FMResultSet *rs;
    NSDictionary *dict;
    if ([fmdb open]) {
        
        rs = [fmdb executeQuery:SQL_QUERY_HISTORY_SINGLE_FORMAT, symbol];
        if ([rs next]){
            dict = [rs resultDictionary];
        }
        [fmdb close];
    }
    return dict != nil;
}

-(void) deleteHistoryById:(NSString *)symbol
{
    if ([fmdb open]) {
        
        BOOL success = [fmdb executeUpdate:SQL_DELETE_SINGLE_HISTORY_FORMAT, symbol];
        if (success) {
            //TBLog(@"delete symbolID : %@ from watch list db success.", symbol);
        }else{
            //TBLog(@"delete symbolID : %@ from watch list db failed.", symbol);
        }
        [fmdb close];
    }
}

-(NSArray *)getMessageListAll
{
    FMResultSet *rs;
    NSMutableArray *resultArr = [NSMutableArray array];
    if ([fmdb open]) {
        rs = [fmdb executeQuery:SQL_QUERY_MESSAGE_LIST_ALL_FORMAT];
        while ([rs next]) {
            [resultArr addObject:[rs resultDictionary]];
        }
        [fmdb close];
    }
    return resultArr;
}

-(void)addMessageList:(NSDictionary *)messageListData
{
    if ([fmdb open]) {
        //
        BOOL success = [fmdb executeUpdate:SQL_INSERT_MESSAGE_LIST_FORMAT, [messageListData objectForKey:@"id"], [messageListData objectForKey:@"title"], [messageListData objectForKey:@"content"], [messageListData objectForKey:@"timestamp"], [messageListData objectForKey:@"type"]];
        if (success) {
            //NSLog(@" success add watch list to db : %@", watchListData);
        }else{
            //NSLog(@" failed add watch list to db : %@", watchListData);
        }
        [fmdb close];
    }
}

-(void)batchAddMessagehList:(NSArray*)messageArray
{
    if (!messageArray || !messageArray.count) {
        return;
    }
    if ([fmdb open]) {
        [fmdb beginTransaction];
        @try {
            for (NSInteger i=0; i<messageArray.count; i++) {
                NSDictionary *messageData = [messageArray objectAtIndex:i];
                //
                BOOL success = [fmdb executeUpdate:SQL_INSERT_MESSAGE_LIST_FORMAT, [messageData objectForKey:@"id"], [messageData objectForKey:@"title"], [messageData objectForKey:@"content"], [messageData objectForKey:@"timestamp"], [messageData objectForKey:@"type"]];
                if (success) {
                    //TBLog(@" success batch add message list to db : %@", messageData);
                }else{
                    //TBLog(@" failed batch add message list to db : %@", messageData);
                }
            }
        }
        @catch (NSException *exception) {
            MUCLog(@"batch add message list exception: %@", [exception reason]);
            [fmdb rollback];
        }
        @finally {
            [fmdb commit];
            [fmdb close];
        }
    }
    
}

-(void)clearAllMessageData
{
    if ([fmdb open]) {
        BOOL success = [fmdb executeUpdate:SQL_CLEAR_MESSAGE_LIST_FORMAT];
        if (success) {
            MUCLog(@"successful delete * from message list");
        }else{
            MUCLog(@"failed to clear all message list.");
        }
        [fmdb close];
    }
}



- (void)addPushMessage:(NSDictionary *)message
{
    NSString *messageId = [message objectForKey:@"messageId"];
    NSNumber *actionTime = [message objectForKey:@"actionTime"];
    NSNumber *actionType = [message objectForKey:@"actionType"];
    NSNumber *time = [message objectForKey:@"time"];
    NSNumber *content = [message objectForKey:@"content"];
    
    if (!messageId || !actionTime || !actionType || !time || !content) {
        return ;
    }
    
    if ([fmdb open]) {
        //
        BOOL success = [fmdb executeUpdate:SQL_INSERT_PUSH_MESSAGE_FORMAT, messageId, actionTime, actionType, time, content];
        if (success) {
            //NSLog(@" success add push message to db : %@", message);
        }else{
            //NSLog(@" failed add push message to db : %@", message);
        }
        [fmdb close];
    }
}

- (long) getPushMessageCount
{
    FMResultSet *rs;
    long count =0;
    if ([fmdb open]) {
        
        rs = [fmdb executeQuery:SQL_QUERY_PUSH_MESSAGE_COUNT];
        if ([rs next]){
            count = [rs longForColumnIndex:0];
        }
        [fmdb close];
    }
    
    return count;
}


- (NSArray *)getPushMessageLimitBy50
{
    FMResultSet *rs;
    NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:1];
    if ([fmdb open]) {
        rs = [fmdb executeQuery:SQL_QUERY_PUSH_MESSAGE_FORMAT];
        while ([rs next]) {
            [resultArr addObject:[rs resultDictionary]];
        }
        [fmdb close];
    }
    return resultArr;
}


- (void)batchDeletePushMessage:(NSArray *)queryArray
{
    if (!queryArray || !queryArray.count) {
        return;
    }
    if ([fmdb open]) {
        [fmdb beginTransaction];
        @try {
            for (NSInteger i=0; i<queryArray.count; i++) {
                NSString *messageId = [queryArray objectAtIndex:i];
                //
                BOOL success = [fmdb executeUpdate:SQL_DELETE_PUSH_MESSAGE_BY_ID_FORMAT, messageId];
                
                if (success) {
                    //TBLog(@" success batch delete push message from db : %@", messageId);
                }else{
                    //TBLog(@" failed batch delete push message from db : %@", messageId);
                }
            }
        }
        @catch (NSException *exception) {
            MUCLog(@"batch add message list exception: %@", [exception reason]);
            [fmdb rollback];
        }
        @finally {
            [fmdb commit];
            [fmdb close];
        }
    }
}

- (NSDictionary *)getPushMessageById:(NSString *)messsageId
{
    FMResultSet *rs;
    NSDictionary *dict = [[NSDictionary alloc] init];
    if ([fmdb open]) {
        rs = [fmdb executeQuery:SQL_DELETE_PUSH_MESSAGE_BY_ID_FORMAT, messsageId];
        if ([rs next]){
            dict = [rs resultDictionary];
        }
        [fmdb close];
    }
    return dict;
}

- (void) clearPushMessageListData
{
    if ([fmdb open]) {
        BOOL success = [fmdb executeUpdate:SQL_CLEAR_PUSH_MESSAGE_FORMAT];
        if (success) {
            MUCLog(@"successful delete * from push message list");
        }else{
            MUCLog(@"failed to clear all push message list.");
        }
        [fmdb close];
    }
}


- (void) addPostDraft:(NSDictionary *)postInfo{
    if ([fmdb open]) {
        
        NSString    *user_symbol    = postInfo[@"user_symbol"];
        NSString    *title          = postInfo[@"title"];
        NSString    *content        = postInfo[@"content"];
        NSData      *photo          = postInfo[@"photo"];
        
        [fmdb executeUpdate:SQL_DELETE_POST_DRAFT_FORMAT, user_symbol];
        //
        BOOL success = [fmdb executeUpdate:SQL_INSERT_POST_DRAFT_FORMAT,user_symbol,title,content,photo];
        
        if (success) {
            MUCLog(@" success add postdraft list to db : %@", postInfo);
        }else{
            MUCLog(@" failed add postdraft list to db : %@", postInfo);
        }
        [fmdb close];
    }
}

- (NSDictionary *) getPostDraftByUser_symbol:(NSString *)user_symbol{
    FMResultSet *rs;
    NSDictionary *dict = [[NSDictionary alloc] init];
    if ([fmdb open]) {
        
        rs = [fmdb executeQuery:SQL_QUERY_POST_DRAFT_FORMAT, user_symbol];
        if ([rs next]){
            dict = [rs resultDictionary];
        }
        [fmdb close];
    }
    return dict;
}

- (void) deletePostDraftByUser_symbol:(NSString *)user_symbol{
    if ([fmdb open]) {
        [fmdb executeUpdate:SQL_DELETE_POST_DRAFT_FORMAT, user_symbol];
        [fmdb close];
    }
}




@end
