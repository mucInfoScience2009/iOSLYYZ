//
//  DataBaseUtils.h
//  LYYZPlat
//
//  Created by xw.long on 16/1/18.
//  Copyright © 2016年 xw.long. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

#define DATABASE_FILE_NAME @"muceduInformation2009.db"

#define TABLE_NAME_SEARCH_HISTORY   @"search_history_fresh"
#define TABLE_NAME_WATCH_LIST       @"watch_list_fresh"
#define TABLE_NAME_MESSAGE_LIST     @"message_list"
#define TABLE_NAME_PUSH_MESSAGE     @"push_message_list"

#define TABLE_NAME_POST_DRAFT       @"post_draft"


#define SQL_CREATE_POST_DRAFT_TABLE @"create table if not exists post_draft (user_symbol text primary key,title text,content text,photo blob)"

#define SQL_INSERT_POST_DRAFT_FORMAT @"insert into post_draft (user_symbol, title, content, photo) values (?, ?, ?,?)"

#define SQL_DELETE_POST_DRAFT_FORMAT @"delete from post_draft where user_symbol = ?"

#define SQL_QUERY_POST_DRAFT_FORMAT  @"select * from post_draft where user_symbol = ?"



#define SQL_CREATE_PUSH_MESSAGE_TABLE @"create table if not exists push_message_list ("\
"messageId text primary key,"\
"actionTime long,"\
"actionType long,"\
"time long,"\
"content text)"


#define SQL_CREATE_SEARCH_HISTORY_TABLE @"create table if not exists search_history_fresh ("\
"symbol text primary key,"\
"nameCN text,"\
"market text,"\
"time long)"


#define SQL_CREATE_WATCH_LIST_TABLE @"create table if not exists watch_list_fresh ("\
"symbol text primary key,"\
"nameCN text,"\
"market text,"\
"time long)"


#define SQL_CREATE_MESSAGE_LIST_TABLE @"create table if not exists message_list ("\
"id long primary key,"\
"content text,"\
"timestamp long,"\
"title text,"\
"type text)"

#define SQL_QUERY_PUSH_MESSAGE_COUNT            @"select count(1) from push_message_list"
#define SQL_QUERY_PUSH_MESSAGE_FORMAT           @"select * from push_message_list order by time ASC LIMIT 50"
#define SQL_DELETE_PUSH_MESSAGE_BY_ID_FORMAT    @"delete from push_message_list where messageId = ?"
#define SQL_CLEAR_PUSH_MESSAGE_FORMAT           @"delete from push_message_list"
#define SQL_INSERT_PUSH_MESSAGE_FORMAT          @"insert into push_message_list (messageId, actionTime, actionType, time, content) values (?, ?, ?, ?, ?)"
//
#define SQL_QUERY_WATCH_LIST_COUNT              @"select count(1) from watch_list_fresh"
#define SQL_QUERY_WATCH_LIST_ALL_FORMAT         @"select * from watch_list_fresh order by time DESC"
#define SQL_QUERY_WATCH_LIST_SINGLE_FORMAT      @"select * from watch_list_fresh where symbol = ?"
#define SQL_DELETE_WATCH_LIST_FORMAT            @"delete from watch_list_fresh where symbol = ?"
#define SQL_INSERT_WATCH_LIST_FORMAT            @"insert into watch_list_fresh (symbol, nameCN, market, time) values (?, ?, ?, ?)"
#define SQL_CLEAR_WATCH_LIST_FORMAT             @"delete from watch_list_fresh"


#define SQL_QUERY_SEARCH_HISTORY_COUNT_FORMAT   @"select count(1) from search_history_fresh"
#define SQL_QUERY_SEARCH_HISTORY_ALL_FORMAT     @"select * from search_history_fresh order by time DESC LIMIT 10"
#define SQL_INSERT_SEARCH_HISTORY_FORMAT        @"insert into search_history_fresh (symbol, nameCN, market, time) values (?, ?, ?, ?)"
#define SQL_CLEAR_SEARCH_HISTORY_FORMAT         @"delete from search_history_fresh"
#define SQL_DELETE_SINGLE_HISTORY_FORMAT        @"delete from search_history_fresh where symbol = ?"
#define SQL_QUERY_HISTORY_SINGLE_FORMAT         @"select * from search_history_fresh where symbol = ?"

#define SQL_QUERY_MESSAGE_LIST_ALL_FORMAT       @"select * from message_list order by timestamp DESC"
#define SQL_INSERT_MESSAGE_LIST_FORMAT          @"insert into message_list (id, title, content, timestamp, type) values (?, ?, ?, ?,?)"
#define SQL_CLEAR_MESSAGE_LIST_FORMAT           @"delete from message_list"


@interface DataBaseUtils : NSObject{
    NSString *userId;
}

@property (nonatomic, readonly) NSString *userID;
@property (nonatomic, strong) FMDatabase *fmdb;

+ (instancetype)sharedInstance;


-(id)init;
-(void)createTable;

- (void)addPushMessage:(NSDictionary *)message;
// 获取push message 条数.
- (long) getPushMessageCount;
// 获取最久的50条
- (NSArray *)getPushMessageLimitBy50;
// 给服务器发送完回执后,从数据库中删除已发送的数据.
- (void)batchDeletePushMessage:(NSArray *)queryArray;
// 获取每条push message 的详情.
- (NSDictionary *)getPushMessageById:(NSString *)messsageId;
// 清除整个push message table.
- (void) clearPushMessageListData;

//
-(long) getWatchListCount;
-(BOOL) existInWatchList:(NSString *)symbol;
-(NSArray *)getWatchListAll;
-(NSDictionary *)getWatchListById:(NSString *)symbol;
-(void)deleteWatchListById:(NSString *)symbol;
-(void)addWatchList:(NSDictionary *)watchListData;
-(void)clearWatchListData;
-(void)batchAddWatchList:(NSArray*)queryArray;


-(long) getSearchHistoryCount;
-(NSArray *)getSearchHistoryAllLimit10;
-(void)addSearchHistory:(NSDictionary *)searchHistoryData;
-(void)clearSearchHistoryData;

//-(BOOL) existInHistoryList:(NSString *)symbol;
//-(void) deleteHistoryById:(NSString *)symbol;



-(NSArray *)getMessageListAll;
-(void) addMessageList:(NSDictionary *)messageListData;
-(void) batchAddMessagehList:(NSArray*)messageArray;
-(void)clearAllMessageData;


- (void) addPostDraft:(NSDictionary *)postInfo;
- (NSDictionary *)getPostDraftByUser_symbol:(NSString *)user_symbol;
- (void) deletePostDraftByUser_symbol:(NSString *)user_symbol;

@end
