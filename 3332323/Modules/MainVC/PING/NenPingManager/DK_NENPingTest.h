//
//  DK_NENPingTest.h
//  3332323
//
//  Created by dd on 28/3/22.
//  Copyright © 2022 XJW. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DK_NENPingTest : NSObject

+ (instancetype)shared;

typedef void(^CompletionHandler)(NSString *, NSArray *);

-(void)startHostPingWithTime:(int)spaceTime hostArray:(NSArray *)array completionHandler:(CompletionHandler)completionHandler;


@end

NS_ASSUME_NONNULL_END
