//
//  Util.h
//  venom
//
//  Created by steve on 2022/1/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if defined(__cplusplus)
#define RU_FOUNDATION_EXTERN extern "C" __attribute__((visibility ("default")))
#else
#define RU_FOUNDATION_EXTERN extern __attribute__((visibility ("default")))
#endif

RU_FOUNDATION_EXTERN UIViewController* currViewController(void);
RU_FOUNDATION_EXTERN UINavigationController* currNavigationController(void);
