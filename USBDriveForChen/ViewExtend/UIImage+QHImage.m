//
//  UIImage+QHImage.m
//  USBDriveForChen
//
//  Created by chen on 14/11/9.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "UIImage+QHImage.h"

@implementation UIImage (QHImage)

+ (UIImage *)imageByPath:(NSString *)name
{
    NSString *path = [@"Images" stringByAppendingPathComponent:name];
    UIImage *img = [UIImage imageNamed:path];
    return img;
}

@end
