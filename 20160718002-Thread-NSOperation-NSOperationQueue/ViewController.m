//
//  ViewController.m
//  20160718002-Thread-NSOperation-NSOperationQueue
//
//  Created by Rainer on 16/7/18.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "ViewController.h"
#import "RYOperation.h"

@interface ViewController ()

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    
//    operationQueue.maxConcurrentOperationCount = 3;
    
//    [operationQueue addOperationWithBlock:^{
//        for (int i = 0; i < 5000; i++) {
//            NSLog(@"operationQueue1 run %zd on %@", i, [NSThread currentThread]);
//        }
//    }];
//    
//    [operationQueue addOperationWithBlock:^{
//        for (int i = 0; i < 3000; i++) {
//            NSLog(@"operationQueue2 run %zd on %@", i, [NSThread currentThread]);
//        }
//    }];
//    
//    [operationQueue addOperationWithBlock:^{
//        for (int i = 0; i < 1000; i++) {
//            NSLog(@"operationQueue3 run %zd on %@", i, [NSThread currentThread]);
//        }
//    }];
    
    [operationQueue addOperation:[[RYOperation alloc] init]];
    
    self.operationQueue = operationQueue;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 这个操作可以用来提高用户体验，场景：当app在做相当耗时操作时（如下载）用户拖动视图，此时可以将任务挂起，当拖动完成后放开
    // 这里判断当前队列是否挂起
//    if (self.operationQueue.isSuspended) {
//        // 恢复队列，继续执行
//        self.operationQueue.suspended = NO;
//    } else {
//        // 挂起队列，停止执行
//        self.operationQueue.suspended = YES;
//    }
    
    // 取消所有的队列任务
    [self.operationQueue cancelAllOperations];
}

- (void)operationQueueFunction2 {
    /**
     *  主队列：   [NSOperationQueue mainQueue]; 自动启动
     *  非主队列： [[NSOperationQueue alloc] init]  会自动开线程，自动启动
     */
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    
    // 设置最大并发数
    //    operationQueue.maxConcurrentOperationCount = 3;
    
    // 设置最大并发数:当设置为1时就变成串行队列了;设置成0则不执行任务
    operationQueue.maxConcurrentOperationCount = 0;
    
    // 直接用这种block添加并启动任务
    [operationQueue addOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"OperationWithBlock1 run in %@", [NSThread currentThread]);
    }];
    
    [operationQueue addOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"OperationWithBlock2 run in %@", [NSThread currentThread]);
    }];
    
    [operationQueue addOperationWithBlock:^{
        NSLog(@"OperationWithBlock3 run in %@", [NSThread currentThread]);
    }];
    
    [operationQueue addOperationWithBlock:^{
        NSLog(@"OperationWithBlock4 run in %@", [NSThread currentThread]);
    }];
    
    [operationQueue addOperationWithBlock:^{
        NSLog(@"OperationWithBlock5 run in %@", [NSThread currentThread]);
    }];
}

- (void)operationQueueFunction1 {
    /**
     *  主队列：   [NSOperationQueue mainQueue]; 自动启动
     *  非主队列： [[NSOperationQueue alloc] init]  会自动开线程，自动启动
     */
    
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    
    NSInvocationOperation *invocationOperation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run:) object:@"test"];
    
    NSBlockOperation *blockOperation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOperation1 run in %@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *blockOperation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOperation2 run in %@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *blockOperation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOperation3 run in %@", [NSThread currentThread]);
    }];
    
    [blockOperation1 addExecutionBlock:^{
        NSLog(@"blockOperation4 run in %@", [NSThread currentThread]);
    }];
    [blockOperation1 addExecutionBlock:^{
        NSLog(@"blockOperation5 run in %@", [NSThread currentThread]);
    }];
    [blockOperation1 addExecutionBlock:^{
        NSLog(@"blockOperation6 run in %@", [NSThread currentThread]);
    }];
    
    // 这里是自定义的队列
    RYOperation *operation = [[RYOperation alloc] init];
    
    // 加入队列后会自动启动
    [operationQueue addOperation:invocationOperation1];
    [operationQueue addOperation:blockOperation1];
    [operationQueue addOperation:blockOperation2];
    [operationQueue addOperation:blockOperation3];
    [operationQueue addOperation:operation];
}

- (void)run:(NSString *)param {
    NSLog(@"%@ run in %@", param, [NSThread currentThread]);
}

@end
