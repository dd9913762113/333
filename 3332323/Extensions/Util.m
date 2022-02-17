//
//  Util.m
//  venom
//
//  Created by steve on 2022/1/21.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

UIViewController* getVisibleViewControllerFrom(UIViewController *vc){
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UIViewController *visibleVC = ((UINavigationController *)vc).visibleViewController;
        UIViewController *topVC = ((UINavigationController *)vc).topViewController;
        if (visibleVC) {
            return getVisibleViewControllerFrom(visibleVC);
        } else {
            return getVisibleViewControllerFrom(topVC);
        }
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return getVisibleViewControllerFrom(((UITabBarController *)vc).selectedViewController);
    } else {
        if (vc.presentedViewController) {
            return getVisibleViewControllerFrom(vc.presentedViewController);
        } else {
            return vc;
        }
    }
}

UIViewController* currViewController(){
    UIViewController *rootViewController = [[UIApplication sharedApplication] delegate].window.rootViewController;
    if (rootViewController.presentedViewController) {
        return getVisibleViewControllerFrom(rootViewController.presentedViewController);
    }
    return getVisibleViewControllerFrom(rootViewController);
}

UINavigationController* currNavigationController(){
    return currViewController().navigationController;
}

