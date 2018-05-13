//
//  YFSaveTool.m
//  MonkeyKing
//
//  Created by 亚飞 on 2018/5/12.
//  Copyright © 2018年 paimwin123. All rights reserved.
//

#import "YFSaveTool.h"

#define MaxMemoryHistory 8

@implementation YFSaveTool

#pragma mark --- 筛选条件操作

- (BOOL)writeFilterConditionToLocalWithObject:(NSDictionary *)dictObj StorageStyle:(StorageStyle)style{

    NSString *memoryPath = [self getMemoryPathWithStorageStyle:style];

    return [dictObj writeToFile:memoryPath atomically:YES];

}

- (NSDictionary *)readFilterConditionStorageWithStorageStyle:(StorageStyle)style{

    NSString *memoryPath = [self getMemoryPathWithStorageStyle:style];

    NSDictionary *dictObj = [[NSDictionary alloc] initWithContentsOfFile:memoryPath];

    return dictObj;
}

#pragma mark --- 历史记录操作
//写
- (BOOL)writeToLocalWithString:(NSString *)string StorageStyle:(StorageStyle)style{

    NSString *memoryPath = [self getMemoryPathWithStorageStyle:style];

    NSArray *memoryArray = [NSArray arrayWithContentsOfFile:memoryPath];

    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:memoryArray];
    if (memoryArray && memoryArray.count == MaxMemoryHistory) {
        //存在
        //超出限制
        [temp removeObjectAtIndex:memoryArray.count-1];
    }

    if ([temp containsObject:string]) {

        [temp removeObject:string];
    }

    [temp insertObject:string atIndex:0];

    return [temp writeToFile:memoryPath atomically:YES];
}

//读
- (NSArray *)readMemoryStorageWithStorageStyle:(StorageStyle)style{

    NSString *memoryPath = [self getMemoryPathWithStorageStyle:style];

    return [NSArray arrayWithContentsOfFile:memoryPath];
}


//删除
- (void)deleteMemoryWithStorageStyle:(StorageStyle)style{

    NSString *memoryPath = [self getMemoryPathWithStorageStyle:style];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:memoryPath]){

        NSError *error;
        [fileManager removeItemAtPath:memoryPath error:&error];
        if (error) {

            NSLog(@"删除失败 原因:%@",error);
            return;
        }
        NSLog(@"删除成功");
        return;
    }
    NSLog(@"不存在文件");
}

//获取路径
- (NSString *)getMemoryPathWithStorageStyle:(StorageStyle)style{

    NSString *memory ;
    switch (style) {

        case HistoryStorageStyle_product:
            memory = @"HistoryStorageStyle_product";
            break;
        case HistoryStorageStyle_company:
            memory = @"HistoryStorageStyle_company";
            break;
        default:
            break;
    }

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    return [paths.firstObject stringByAppendingPathComponent:memory];
}






#pragma mark --- Singleton

+ (instancetype)sharedTool{

    return [[self alloc] init];
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone{

    static dispatch_once_t onceToken;
    static YFSaveTool *tool;

    dispatch_once(&onceToken, ^{

        tool = [super allocWithZone:zone];

    });

    return tool;
}

@end
