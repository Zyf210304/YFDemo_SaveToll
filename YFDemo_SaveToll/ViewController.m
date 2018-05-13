//
//  ViewController.m
//  YFDemo_SaveToll
//
//  Created by 亚飞 on 2018/5/13.
//  Copyright © 2018年 yafei. All rights reserved.
//

#import "ViewController.h"
#import "YFSaveTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [[YFSaveTool sharedTool] writeToLocalWithString:@"上衣" StorageStyle:HistoryStorageStyle_product];
    [[YFSaveTool sharedTool] writeToLocalWithString:@"iPhone" StorageStyle:HistoryStorageStyle_product];
    [[YFSaveTool sharedTool] writeToLocalWithString:@"辣条" StorageStyle:HistoryStorageStyle_product];
    [[YFSaveTool sharedTool] writeToLocalWithString:@"火车" StorageStyle:HistoryStorageStyle_product];

    NSArray *productArr = [[YFSaveTool sharedTool] readMemoryStorageWithStorageStyle:HistoryStorageStyle_product];
    NSLog(@"%@", productArr);
    [[YFSaveTool sharedTool] deleteMemoryWithStorageStyle:HistoryStorageStyle_product];

    NSArray *prouductArr_delete = [[YFSaveTool sharedTool] readMemoryStorageWithStorageStyle:HistoryStorageStyle_product];
    NSLog(@"%@", prouductArr_delete);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
