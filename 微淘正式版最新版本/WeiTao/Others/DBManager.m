//
//  DBManager.m
//  WeiTao
//
//  Created by qianfeng on 15/12/18.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "HomeDetailModel.h"
#import "HomePicModel.h"
@implementation DBManager
{
  FMDatabase * _db;
}
+ (id)defaultDBManager{
    static DBManager  * manager = nil;
    if (manager == nil) {
        manager = [[DBManager alloc]init];
    }
    return manager;
}
- (instancetype)init{
    if (self=[super init]) {
        [self prepareDB];
    }
    return self;
}
-(void)prepareDB
{
    NSString *dbPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/DB"];
    if (_db==nil) {
        _db=[FMDatabase databaseWithPath:dbPath];
    }
    [_db open];
    [self createTableList];
}
-(void)createTableList
{
    NSString *sql=@"create table if not exists WEITAO (ID integer primary key autoincrement,title varchar(100),url varchar(200),pic varchar(200));";
    [_db executeUpdate:sql];
//    if (success==YES) {
//        NSLog(@"app  表单创建成功");
//    }
}
- (void)saveAppDetailModel:(HomeDetailModel *)model{
    NSString *sql=@"insert into WEITAO (title,url,pic) values(?,?,?);";
    HomePicModel *model1=model.pic[0];
    [_db executeUpdate:sql,model.title,model.url,model1.pic];
//    if (success==YES) {
//        NSLog(@"插入成功");
//    }
}
- (void)deleteAppDetailModel:(HomeDetailModel *)model{
    NSString *sql=@"delete from WEITAO where title=?;";
    [_db executeUpdate:sql,model.title];
//    if (success==YES) {
//        NSLog(@"删除成功");
//    }
}
- (NSArray *)allAppDetailModel{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSString *sql=@"select * from WEITAO;";
    FMResultSet *set=[_db executeQuery:sql];
    while (set.next) {
        NSString *title=[set stringForColumn:@"title"];
        NSString *url=[set stringForColumn:@"url"];
        NSString *pic=[set stringForColumn:@"pic"];
        HomeDetailModel *model=[[HomeDetailModel alloc]init];
        model.title=title;
        model.url=url;
        model.category=pic;
        [array addObject:model];
    }
    return array;
}
@end
