//
//  YFSaveTool.h
//  MonkeyKing
//
//  Created by 亚飞 on 2018/5/12.
//  Copyright © 2018年 paimwin123. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    HistoryStorageStyle_product,
    HistoryStorageStyle_company
}StorageStyle;

@interface YFSaveTool : NSObject

/**
 Singlton
 */
+ (instancetype)sharedTool;

/**
 写筛选条件到本地

 */
- (BOOL)writeFilterConditionToLocalWithObject:(NSDictionary *)dictObj StorageStyle:(StorageStyle)style;



/**
 本地读取筛选条件

 */
- (NSDictionary *)readFilterConditionStorageWithStorageStyle:(StorageStyle)style;

/**
 历史记录存储

 */
- (BOOL)writeToLocalWithString:(NSString *)string StorageStyle:(StorageStyle)style;

/**
 历史记录读取

 */
- (NSArray *)readMemoryStorageWithStorageStyle:(StorageStyle)style;


/**
 历史记录删除
 
 */
- (void)deleteMemoryWithStorageStyle:(StorageStyle)style;




@end
