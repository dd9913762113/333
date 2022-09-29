//
//  DK_NENPingTest.m
//  3332323
//
//  Created by dd on 28/3/22.
//  Copyright © 2022 XJW. All rights reserved.
//

#import "DK_NENPingTest.h"
#import "NENPingManager.h"

@interface DK_NENPingTest ()

@property (nonatomic, strong) NENPingManager* pingManager;
@property (nonatomic, strong) NSArray *hostNameArray;


@property(nonatomic,strong)dispatch_source_t authTimer;
@property(nonatomic,assign)NSInteger count;

@property (nonatomic,copy, nullable, readonly)CompletionHandler completionHandler;

@end

@implementation DK_NENPingTest


+(instancetype)shared{
    static DK_NENPingTest * fileHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fileHelper = [[DK_NENPingTest alloc] init];
    });
    return fileHelper;
}


-(void)startHostPingWithTime:(int)spaceTime hostArray:(NSArray *)array completionHandler:(CompletionHandler)completionHandler
{
    [self startHostPingTime:spaceTime hostArray:array];
}

- (void)testSome {

    NSArray *hostArray = @[
                               @"www.bilibili.com",
                               @"www.baidu.com",
                               @"www.youku.com",
                               @"www.gg.com",
                               @"www.123.com",
                               @"www.hao123.com"
                               ];
//    self.hostNameArray = [NSArray arrayWithArray:hostArray];
//    self.pingManager = [[NENPingManager alloc] init];
//    [self.pingManager getFatestAddress:hostArray completionHandler:^(NSString *hostName, NSArray *sortedAddress) {
//        NSLog(@"fastest IP: %@",hostName);
//        NSLog(@"sortedAddress = %@",sortedAddress);
//    }];
    
    

    [self startHostPingTime:5 hostArray:hostArray];
}




- (void)startHostPingTime:(int)spaceTime hostArray:(NSArray *)array{
    if ([array count] > 0) {
        self.hostNameArray = [NSArray arrayWithArray:array];
    }else{
        return;
    }
    if (_authTimer) {
        dispatch_cancel(_authTimer);
        _authTimer = nil;
    }
    dispatch_queue_t queue = dispatch_get_main_queue();
    _authTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t start = DISPATCH_TIME_NOW;
    dispatch_time_t interval = spaceTime * NSEC_PER_SEC;
    dispatch_source_set_timer(_authTimer, start, interval, 0);
    
    __weak __typeof(self)weakSelf = self;
    dispatch_source_set_event_handler(_authTimer, ^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;

        strongSelf.count ++;
        if (strongSelf.count == 300 ) {
            strongSelf.count = 0;
        }
        NSLog(@"定时器次数是： %ld",strongSelf.count);
        if (strongSelf.count >= 10){
            dispatch_cancel(_authTimer);
            _authTimer = nil;
        }else {
            [strongSelf startHostPing];

        }
    });
    dispatch_resume(_authTimer);
}

-(void)startHostPing
{
    self.pingManager = [[NENPingManager alloc] init];
    [self.pingManager getFatestAddress:self.hostNameArray completionHandler:^(NSString *hostName, NSArray *sortedAddress) {

        NSLog(@"fastest IP: %@",hostName);
        
        for (NENAddressItem *item in sortedAddress) {
            
            NSLog(@"222 ??? %@ time=%.2f",item.hostName, item.delayMillSeconds);
        }
        
//        self.completionHandler(hostName, sortedAddress);
        
    }];
}



@end
