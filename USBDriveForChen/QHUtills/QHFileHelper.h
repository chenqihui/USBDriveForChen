//
//  QHFileHelper.h
//  USBDriveForChen
//
//  Created by chen on 14/10/27.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHFileHelper : NSObject

//移动文件
+ (int)moveFileToDocument:(NSString *)fileName type:(NSString *)fileType;

//判断文件是否存在
+ (int)isEixtFile:(NSString *)path;

+ (void)writeFile:(NSString *)name content:(id)content;

+ (void)readFiles:(NSArray * __strong *)arFiles;

+ (NSString *)filePath:(NSString *)file;

@end
