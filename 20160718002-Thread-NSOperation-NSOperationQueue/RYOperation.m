//
//  RYOperation.m
//  20160718002-Thread-NSOperation-NSOperationQueue
//
//  Created by Rainer on 16/7/18.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "RYOperation.h"

@implementation RYOperation

/**
 *  自定义Operation需要实现此方法
 *  这里官方建议如果自定义Operation的话则执行完一段耗时操作以后就判断下是否被暂停了任务
 */
- (void)main {
    NSLog(@"在这里做任务");
    
    for (int i = 0; i < 5000; i++) {
        NSLog(@"operationQueue1 run %zd on %@", i, [NSThread currentThread]);
    }
    // 这里判断下是否被暂停了任务
    if (self.isCancelled) return;
    
    for (int i = 0; i < 3000; i++) {
        NSLog(@"operationQueue2 run %zd on %@", i, [NSThread currentThread]);
    }
    
    if (self.isCancelled) return;
    
    for (int i = 0; i < 1000; i++) {
        NSLog(@"operationQueue3 run %zd on %@", i, [NSThread currentThread]);
    }
}

@end
