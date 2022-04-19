//
//  UIViewController+DK_Extension.m
//  3332323
//
//  Created by dd on 19/4/22.
//  Copyright © 2022 XJW. All rights reserved.
//

#import "UIViewController+DK_Extension.h"
#import <objc/runtime.h>

@implementation UIViewController (DK_Extension)


+ (void)load {
    
#if DEBUG
        
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
           
        Method oriMethod = class_getInstanceMethod([self class], @selector(viewWillAppear:));
        Method newMethod = class_getInstanceMethod([self class], @selector(JX_viewWillAppear:));
            method_exchangeImplementations(oriMethod, newMethod);
            
            SEL s1 = NSSelectorFromString(@"dealloc");
            Method m1 = class_getInstanceMethod(self, s1);

            SEL s2 = NSSelectorFromString(@"hm_dealloc");
            Method m2 = class_getInstanceMethod(self, s2);
            if (class_addMethod(self, s1, method_getImplementation(m2), method_getTypeEncoding(m2))) {
                class_replaceMethod(self, s2, method_getImplementation(m1), method_getTypeEncoding(m1));
            } else {
                method_exchangeImplementations(m1, m2);
            }
        });
    
    //注册项目启动监听

    __block id observer =
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
    //更改bundlePath
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
        NSLog(@"iOSInjection  iOSInjection ");
    }];

    //给UIViewController 注册injected 方法
    class_addMethod([UIViewController class], NSSelectorFromString(@"injected"), (IMP)injected, "v@:");
#endif

}

-(void)deleteFrontView
{
    if (@available(iOS 13.0, *)) {
        UIView *view = (UIView *)NSClassFromString(@"UITransitionView");
        if (view) {
            [self.view insertSubview:view atIndex:1000];
        }
        
    }
}


- (void)hm_dealloc {
    NSLog(@"当前消失的 %@ dealloc", [self class]);
    [self hm_dealloc];
}

- (void)JX_viewWillAppear:(BOOL)animated {
    [self JX_viewWillAppear:animated];
    NSLog(@"当前展示的 %@",[self class]);
    
}

/**
InjectionIII 热部署会调用的一个方法，
runtime给VC绑定上之后，每次部署完就重新viewDidLoad
*/
void injected (id self, SEL _cmd) {
    //重新加载view
//    [self init];
    [self loadView];
    [self viewDidLoad];
    [self viewWillLayoutSubviews];
    [self viewWillAppear:NO];
}


@end
