//
//  DK_SGWiFiUploadVC.m
//  3332323
//
//  Created by dd on 14/4/22.
//  Copyright © 2022 XJW. All rights reserved.
//

#import "DK_SGWiFiUploadVC.h"
#import "SGWiFiUploadManager.h"

@interface DK_SGWiFiUploadVC ()

@end

@implementation DK_SGWiFiUploadVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupServer];
}

- (void)setupServer {
    SGWiFiUploadManager *mgr = [SGWiFiUploadManager sharedManager];
    BOOL success = [mgr startHTTPServerAtPort:10086];
    if (success) {
        [mgr setFileUploadStartCallback:^(NSString *fileName, NSString *savePath) {
            NSLog(@"File %@ Upload Start", fileName);
        }];
        [mgr setFileUploadProgressCallback:^(NSString *fileName, NSString *savePath, CGFloat progress) {
            NSLog(@"File %@ on progress %f", fileName, progress);
        }];
        [mgr setFileUploadFinishCallback:^(NSString *fileName, NSString *savePath) {
            NSLog(@"File Upload Finish %@ at %@", fileName, savePath);
        }];
    }
    [mgr showWiFiPageFrontViewController:self dismiss:^{
        [mgr stopHTTPServer];
    }];
}


@end
