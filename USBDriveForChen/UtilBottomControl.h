//
//  UtilBottomControl.h
//  USBDriveForChen
//
//  Created by chen on 14/10/19.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UtilBottomControlDelegate <NSObject>

- (void)selectIndex:(NSUInteger)index;

@end

@interface UtilBottomControl : UIView

@property (nonatomic, assign) id<UtilBottomControlDelegate> delegate;

- (instancetype)initWtihFrame:(CGRect)rect data:(NSArray *)arData;

@end
