//
//  FileCollectionViewCell.m
//  USBDriveForChen
//
//  Created by chen on 14/11/6.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "FileCollectionViewCell.h"

@interface FileCollectionViewCell ()
{
    float _nSpaceX;
    float _nSpaceY;
}

@end

@implementation FileCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _nSpaceX = 10;
    _nSpaceY = 10;
    
    _iconImageView = [[UIImageView alloc] init];
    [_iconImageView setBackgroundColor:[UIColor clearColor]];
//    [QHCommonUtil setView:_iconImageView];
    [self.contentView addSubview:_iconImageView];
    
    _iconTitleLabel = [[UILabel alloc] init];
    [_iconTitleLabel setBackgroundColor:[UIColor clearColor]];
    [_iconTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_iconTitleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [_iconTitleLabel setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:_iconTitleLabel];
    
    _deleteView = [[UIImageView alloc] init];
    [_deleteView setImage:[UIImage imageByPath:@"other/deleteTag.png"]];
    _deleteView.tag = APP_DELETE_TAG;
    [self.contentView addSubview:_deleteView];
    [_deleteView setHidden:YES];
    [_deleteView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deletePressGestureRecognizer:)];
    [tapGestureTel setNumberOfTapsRequired:1];
    [tapGestureTel setNumberOfTouchesRequired:1];
    [_deleteView addGestureRecognizer:tapGestureTel];
}

- (void)layoutSubviews
{
    float width = MIN(self.contentView.frame.size.width - _nSpaceX * 2, self.contentView.frame.size.width - _nSpaceY * 2);
    [_iconImageView setFrame:CGRectMake(_nSpaceX, _nSpaceY, width, width)];
    [_iconTitleLabel setFrame:CGRectMake(0, CGRectGetMaxY(_iconImageView.frame), self.contentView.frame.size.width, (self.contentView.frame.size.height - CGRectGetMaxY(_iconImageView.frame)))];
    float nDeleteW = 20;
    [_deleteView setFrame:CGRectMake(0, 0, nDeleteW, nDeleteW)];
}

- (void)showDelete:(BOOL)bSow
{
    [_deleteView setHidden:!bSow];
}

#pragma mark - action

-(void)deletePressGestureRecognizer:(UIGestureRecognizer *)gr
{
    if ([_delegate respondsToSelector:@selector(deleteFileCell:)])
    {
        [_delegate deleteFileCell:self];
    }
}

@end
