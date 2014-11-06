//
//  UtilBottomControl.m
//  USBDriveForChen
//
//  Created by chen on 14/10/19.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "UtilBottomControl.h"

@implementation UtilBottomControl

- (instancetype)initWtihFrame:(CGRect)rect data:(NSArray *)arData
{
    self = [super init];
    if (self)
    {
        self.frame = rect;
        [self initViewWithData:arData];
    }
    return self;
}

- (void)initViewWithData:(NSArray *)arData
{
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 1)];
    lineV.backgroundColor = [UIColor orangeColor];
    [self addSubview:lineV];
    
    NSUInteger btnWidth = self.width/arData.count;
    NSUInteger btnHeight = self.height - lineV.height;
    for (NSUInteger i = 0; i < arData.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(i*btnWidth, self.height - btnHeight, btnWidth, btnHeight)];
        [btn setTitle:[arData objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i + 1;
        btn.backgroundColor = [UIColor clearColor];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - action

- (void)click:(UIButton *)btn
{
    [self.delegate selectIndex:btn.tag];
}

@end
