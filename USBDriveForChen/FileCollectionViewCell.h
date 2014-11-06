//
//  FileCollectionViewCell.h
//  USBDriveForChen
//
//  Created by chen on 14/11/6.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COLLECTIONVIEWCELL  @"collectionviewcell"
#define APP_DELETE_TAG 946

@class FileCollectionViewCell;

@protocol FileCollectionViewCellDelegate <NSObject>

- (void)deleteFileCell:(FileCollectionViewCell *)collectionViewCell;

@end

@interface FileCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *iconTitleLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *deleteView;

@property (nonatomic, weak) id<FileCollectionViewCellDelegate> delegate;

- (void)showDelete:(BOOL)bSow;

@end
