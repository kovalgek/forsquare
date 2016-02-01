//
//  Helper.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 01.02.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 1.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
