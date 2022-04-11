//
//  DK_TracerouteVC.h
//  Traceroute
//
//  Created by Bryan Yuan on 1/5/17.
//  Copyright © 2017 Bryan Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DK_TracerouteVC : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic , strong) UITextField      *hostTextField;
@property (nonatomic , strong) UIButton         *tracertButton;
@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) UITextView       *textView;


@end

