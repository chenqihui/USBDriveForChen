//
//  QHDialogView.h
//  AppManage
//
//  Created by chen on 14/8/24.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QHDialogView : UIView

@property (nonatomic, copy) void(^exitBlock)(BOOL bExit);

@property (nonatomic, copy) void(^sureBlock)(BOOL bSure);

+ (QHDialogView *)initDialogWithTitle:(NSString *)title content:(NSString *)content;

- (void)createDialog;

- (void)createDialogWithTitle:(NSString *)title content:(NSString *)content;

@end
