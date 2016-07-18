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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
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
