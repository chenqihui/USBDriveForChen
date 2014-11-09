//
//  QHDialogView.m
//  AppManage
//
//  Created by chen on 14/8/24.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "QHDialogView.h"

@interface QHDialogView ()
{
    UIView *_dialogView;
    UIView *_bgBaffle;
}

@end

@implementation QHDialogView

+ (QHDialogView *)initDialogWithTitle:(NSString *)title content:(NSString *)content
{
    QHDialogView *this = [[QHDialogView alloc] init];
    [this createDialogWithTitle:title content:content];
    
    return this;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        _bgBaffle = [[UIView alloc] init];
        [_bgBaffle setFrame:self.frame];
        [_bgBaffle setBackgroundColor:[UIColor blackColor]];
        [_bgBaffle setAlpha:0.3];
        [self addSubview:_bgBaffle];
    }
    return self;
}

//- (void)layoutSubviews
//{
//    [self setFrame:[[UIScreen mainScreen] bounds]];
//}

- (void)createDialog
{
    [self createDialogWithTitle:@"提示" content:@"是否确定"];
}

- (void)createDialogWithTitle:(NSString *)title content:(NSString *)content
{
    CGSize width = CGSizeMake(280, 200);
    
    int heightCount = 20;
    NSRange firstRange = NSMakeRange(0, 6);
    NSRange secondRange = NSMakeRange(6, 9);
    NSRange thirdRange = NSMakeRange(15, 5);
    
    _dialogView = [[UIView alloc] initWithFrame:CGRectMake((self.width - width.width) / 2, (self.height - width.height) / 2, width.width, width.height)];
    [_dialogView setBackgroundColor:[UIColor whiteColor]];
    [_dialogView setClipsToBounds:YES];
    _dialogView.layer.cornerRadius = 3;
    _dialogView.layer.borderColor = [[QHCommonUtil stringTOColor:@"#e6e6e6"] CGColor];
    
    float mH = _dialogView.height/heightCount;
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, mH*firstRange.location, _dialogView.width, mH*firstRange.length)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [_dialogView addSubview:topView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelDialog:)];
    [topView addGestureRecognizer:tap];
    
    [_bgBaffle addGestureRecognizer:tap];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _dialogView.width, 3)];
    [headerView setBackgroundColor:[QHCommonUtil stringTOColor:@"#c40001"]];
    [topView addSubview:headerView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, headerView.bottom, topView.width - 20, topView.height)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setText:title];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [titleLabel setTextColor:[QHCommonUtil stringTOColor:@"#333333"]];
    [topView addSubview:titleLabel];
    
    UIButton *cancelBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageByPath:@"other/dll_dialog_cancel_normal.png"];
    [cancelBtn2 setFrame:CGRectMake(_dialogView.width - mH*3 - 10, 0, mH*3, mH*3)];
    cancelBtn2.centerY = topView.centerY;
    [cancelBtn2 setBackgroundImage:image forState:UIControlStateNormal];
    image = [UIImage imageByPath:@"other/dll_dialog_cancel_highlight.png"];
    [cancelBtn2 setBackgroundImage:image forState:UIControlStateHighlighted];
    [topView addSubview:cancelBtn2];
    [cancelBtn2 addTarget:self action:@selector(cancelDialog:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *separatorImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, mH*secondRange.location, _dialogView.width, 0.5)];
    [_dialogView addSubview:separatorImageView2];
    [separatorImageView2 setBackgroundColor:[UIColor grayColor]];
    
    UIFont *font = [UIFont systemFontOfSize:16];
    CGSize s = [QHCommonUtil getSizeWithFont:font];
    
    UILabel *contentL = [[UILabel alloc] initWithFrame:CGRectMake(12, separatorImageView2.bottom + 20, _dialogView.width - 24, s.height*2)];
    [contentL setFont:font];
    [contentL setText:content];
    //自动折行设置
    contentL.lineBreakMode = NSLineBreakByWordWrapping;
    contentL.numberOfLines = 0;
    [_dialogView addSubview:contentL];
    
    UIImageView *separatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, mH*thirdRange.location, _dialogView.width, 0.5)];
    [_dialogView addSubview:separatorImageView];
    [separatorImageView setBackgroundColor:[UIColor grayColor]];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setFrame:CGRectMake(0, mH*thirdRange.location + 0.5, _dialogView.width/2, mH*thirdRange.length - 0.5)];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[QHCommonUtil stringTOColor:@"#c40001"] forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [sureBtn setBackgroundColor:RGBA(247, 247, 247, 1)];
    image = [UIImage imageByPath:@"other/dll_dialog_know_highlight.png"];
    [sureBtn setBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2, image.size.width/2, image.size.height/2, image.size.width/2)] forState:UIControlStateHighlighted];
    [_dialogView addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(sureDone:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(sureBtn.right, mH*thirdRange.location + 0.5, _dialogView.width/2, mH*thirdRange.length - 0.5)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[QHCommonUtil stringTOColor:@"#c40001"] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [cancelBtn setBackgroundColor:RGBA(247, 247, 247, 1)];
    [cancelBtn setBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2, image.size.width/2, image.size.height/2, image.size.width/2)] forState:UIControlStateHighlighted];
    [_dialogView addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(cancelDialog:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *separatorImageView3 = [[UIView alloc] initWithFrame:CGRectMake(sureBtn.right, sureBtn.top, 0.5, sureBtn.height)];
    [separatorImageView3 setBackgroundColor:[UIColor grayColor]];
    [_dialogView addSubview:separatorImageView3];
    
    [self show];
}

- (void)show
{
    [self addSubview:_dialogView];
}

#pragma mark - action

- (void)cancelDialog
{
    [self removeFromSuperview];
}

- (void)sureDone:(UIButton *)btn
{
    if(self.sureBlock != nil)
    {
        self.sureBlock(YES);
    }
    [self cancelDialog];
}

- (void)cancelDialog:(UIButton *)btn
{
    if(self.exitBlock != nil)
    {
        self.exitBlock(YES);
    }
    [self cancelDialog];
}

@end
