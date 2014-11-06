//
//  QHCommonUtil.m
//  NewsFourApp
//
//  Created by chen on 14/8/9.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "QHCommonUtil.h"

@implementation QHCommonUtil

+ (UIImage *)getImageFromView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIColor *)getRandomColor
{
    return [UIColor colorWithRed:(float)(1+arc4random()%99)/100 green:(float)(1+arc4random()%99)/100 blue:(float)(1+arc4random()%99)/100 alpha:1];
}

/*0--1 : lerp( float percent, float x, float y ){ return x + ( percent * ( y - x ) ); };*/
+ (float)lerp:(float)percent min:(float)nMin max:(float)nMax
{
    float result = nMin;
    
    result = nMin + percent * (nMax - nMin);
    
    return result;
}

+ (void)setView:(UIView *)view
{
    [QHCommonUtil setView:view cornerRadius:12 borderWidth:1 borderColor:[UIColor whiteColor]];
}

+ (void)setView:(UIView *)view cornerRadius:(float)nCornerRadius borderWidth:(float)nBorderWidth borderColor:(UIColor *)borderColor
{
    //设置圆角度数
    view.layer.cornerRadius = nCornerRadius;
    //设置边框的宽度
    view.layer.borderWidth = nBorderWidth;
    //设置边框颜色
    view.layer.borderColor = [borderColor CGColor];
}

#pragma mark -

+ (void)BeginWobble:(UIView *)mainView
{
    @autoreleasepool
    {
        for (UIView *view in mainView.subviews)
        {
            srand([[NSDate date] timeIntervalSince1970]);
            float rand=(float)random();
            CFTimeInterval t=rand*0.0000000001;
            [UIView animateWithDuration:0.1 delay:t options:0  animations:^
             {
                 view.transform=CGAffineTransformMakeRotation(-0.05);
             } completion:^(BOOL finished)
             {
                 [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction  animations:^
                  {
                      view.transform=CGAffineTransformMakeRotation(0.05);
                  } completion:^(BOOL finished) {}];
             }];
        }
    }
}

+ (void)EndWobble:(UIView *)mainView
{
    @autoreleasepool
    {
        for (UIView *view in mainView.subviews)
        {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^
             {
                 view.transform=CGAffineTransformIdentity;
             } completion:^(BOOL finished) {}];
        }
    }
}

+ (UIColor *) stringTOColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""])
    {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

+ (CGSize)getSizeWithFont:(UIFont *)font
{
    CGSize s;
    if (isIos7 >= 7)
        s = [@"陈" sizeWithAttributes:@{NSFontAttributeName:font}];
    else
        s = [@"陈" sizeWithFont:font];
    
    return s;
}

+ (CGSize)getSizeWithString:(NSString *)str withFont:(UIFont *)font
{
    CGSize s;
    if (isIos7 >= 7)
        s = [str sizeWithAttributes:@{NSFontAttributeName:font}];
    else
        s = [str sizeWithFont:font];
    
    return s;
}

@end
