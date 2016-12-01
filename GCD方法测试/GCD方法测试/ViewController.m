//
//  ViewController.m
//  GCD方法测试
//
//  Created by 陈胜华 on 16/8/5.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


-(void)asyncCONCURRENT{
    NSLog(@"star");
    //一个队列 为 每个任务开辟一个线程
    dispatch_queue_t queue=dispatch_queue_create("com.GCD_demo.www", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"CONCURRENT_work_1\n");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"CONCURRENT_work_2 \n");
    });
    dispatch_async(queue, ^{
        NSLog(@"CONCURRENT_work_3 \n");
    });
    NSLog(@"end");
}

-(void)asyncGroupNotify {
    NSLog(@"star");
    dispatch_group_t group=dispatch_group_create();
    dispatch_queue_t queue=dispatch_queue_create("com.GCD_demo.www", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"group_work_1");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:6];
        NSLog(@"group_work_2");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"group_work_3");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"dispatch_group_Notify 结束");
    });
}

-(void)asyncGroupWait {
    
    NSLog(@"star");
    dispatch_group_t group=dispatch_group_create();
    dispatch_queue_t queue=dispatch_queue_create("com.GCD_demo.www", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"group_work_1");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:6];
        NSLog(@"group_work_2");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"group_work_3");
    });
    
    //在此设置了一个12秒的等待时间，如果group的执行结束没有到12秒那么就返回0
    //如果执行group的执行时间超过了12秒，那么返回非0 数值，
    //在使用dispatch_group_wait函数的时候，会阻塞当前线程，阻塞的时间 在wait函数时间值和当前group执行时间值取最小的。
    long kk=dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, 12 * NSEC_PER_SEC));
    if(kk==0)
    {
        NSLog(@"dispatch_group_wait 结果1");
    }
    else
    {
        NSLog(@"dispatch_group_wait 结果2");
    }
    
}


-(void)asyncGroupEnter {
    
    // 群组－统一监控一组任务
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    // 1> 入组 -> 之后的 block 会被 group 监听
    // dispatch_group_enter 一定和 dispatch_group_leave 要配对出现
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"dispatch_async_work1");
        
        // block 的末尾，所有任务执行完毕后，添加一个出组
        dispatch_group_leave(group);
    });
    
    //  再次入组
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:6];
        
        NSLog(@"dispatch_async_work1");
        
        // block 的末尾，所有任务执行完毕后，添加一个出组
        dispatch_group_leave(group);
    });
    
    // 群组结束
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"OVER");
    });  
    NSLog(@"come here");
}

-(void)dispatchBlock {
    
    dispatch_queue_t queue = dispatch_queue_create("com.GCD_demo.www", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t block=dispatch_block_create(0, ^{
        NSLog(@"dispatchBlock_work");
    });
    
    dispatch_sync(queue, block);
}

-(void)dispatchBlockWait {
    
    dispatch_queue_t queue = dispatch_queue_create("com.GCD_demo.www", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t block = dispatch_block_create(0, ^{
        NSLog(@"before sleep");
        [NSThread sleepForTimeInterval:6];
        NSLog(@"after sleep");
    });
    dispatch_async(queue, block);
    //等待前面的任务执行完毕
    long kk=dispatch_block_wait(block, dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC));
    if(kk==0)
    {
        NSLog(@"coutinue");
    }
    else
    {
        NSLog(@"timeOut！！！");
    }
}

-(void)dispatchBlockNotify {
    
    dispatch_queue_t queue = dispatch_queue_create("com.GCD_demo.www", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t previousBlock = dispatch_block_create(0, ^{
        NSLog(@"previousBlock begin");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"previousBlock done");
    });
    dispatch_async(queue, previousBlock);
    dispatch_block_t notifyBlock = dispatch_block_create(0, ^{
        NSLog(@"notifyBlock");
    });
    //当previousBlock执行完毕后，提交notifyBlock到global queue中执行
    dispatch_block_notify(previousBlock, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), notifyBlock);
}

-(void)dispatchBlockCancel {
    
    dispatch_queue_t queue = dispatch_queue_create("com.GCD_demo.www", DISPATCH_QUEUE_CONCURRENT);
    dispatch_block_t block1 = dispatch_block_create(0, ^{
        NSLog(@"block1 begin");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"block1 done");
    });
    dispatch_block_t block2 = dispatch_block_create(0, ^{
        NSLog(@"block2 ");
    });
    dispatch_async(queue, block1);
    dispatch_async(queue, block2);
    dispatch_block_cancel(block2);
}

-(void)dispatchApply {
    
    dispatch_queue_t queue = dispatch_queue_create("com.GCD_demo.www", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_apply(6, queue, ^(size_t i) {
        NSLog(@"do a job %zu times",i);
        
    });
    NSLog(@"go on");
}

-(void)dispatchAfter {
    
    NSLog(@"dispatchAfter_star");
    int64_t time=2*NSEC_PER_SEC;
    
    dispatch_queue_t mainQueue=dispatch_get_main_queue();
    
    for (int i=0; i<5; i++) {
        dispatch_time_t disTime=dispatch_time(DISPATCH_TIME_NOW, time*i);
        
        dispatch_after(disTime, mainQueue, ^{
            NSLog(@"dispatchAfter_work");
        });
    }
    
}

-(void)diapatchBarrier {
    
    dispatch_queue_t queue = dispatch_queue_create("com.GCD_demo.www", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:6];
        NSLog(@"dispatch_async_work1");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"dispatch_async_work2");
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"dispatch_async_work3");
        [NSThread sleepForTimeInterval:1];
        
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"dispatch_async_work4");
    });
}

-(void)DispatchSet {
    
    dispatch_queue_t serialDiapatchQueue=dispatch_queue_create("com.GCD_demo.www", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t dispatchgetglobalqueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_set_target_queue(serialDiapatchQueue, dispatchgetglobalqueue);
    dispatch_async(serialDiapatchQueue, ^{
        NSLog(@"我优先级低，先让让");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"我优先级高,我先block");
    });
}

-(void)dispatchSet2 {
    
    dispatch_queue_t targetQueue = dispatch_queue_create("target_queue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_set_target_queue(queue1, targetQueue);
    dispatch_set_target_queue(queue2, targetQueue);
    
    dispatch_async(queue1, ^{
        [NSThread sleepForTimeInterval:3.f];
        NSLog(@"do job1");
        
    });
    dispatch_async(queue2, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"do job2");
        
    });
    dispatch_async(queue2, ^{
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"do job3");
        
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self asyncCONCURRENT];
//    [self asyncGroupNotify];
//    [self asyncGroupWait];
//    [self asyncGroupEnter];

//    [self dispatchBlockWait];
//    [self dispatchBlockNotify];
    [self dispatchBlockCancel];
//    [self dispatchAfter];
//    [self dispatchApply];
//    [self diapatchBarrier];
//    [self DispatchSet];
//    [self dispatchSet2];
}




@end
