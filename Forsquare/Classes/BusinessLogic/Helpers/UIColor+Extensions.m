//
//  UIColor+Extensions.m
//  EventGridManager
//
//  Created by Антон Ковальчук on 21.01.14.
//  Copyright (c) 2014 Антон Ковальчук. All rights reserved.
//

#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

+ (UIColor *)headerColor
{
    return [UIColor colorWithRed:3.0f/255.0f green:158.0f/255.0f blue:121.0f/255.0f alpha:1.0f];
}

+ (UIColor *)cellBackgroundColor
{
    return [UIColor colorWithRed:238.0f/255.0f green:243.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
}

+ (UIColor *)viewBackgroundColor
{
    return [UIColor colorWithRed:199.0f/255.0f green:206.0f/255.0f blue:185.0f/255.0f alpha:1.0f];
}

+ (UIColor *)cellTitleColor
{
    return [UIColor colorWithRed:21.0f/255.0f green:25.0f/255.0f blue:30.0f/255.0f alpha:1.0f];
}

+ (UIColor *)cellSubtitleColor
{
    return [UIColor colorWithRed:181.0f/255.0f green:177.0f/255.0f blue:174.0f/255.0f alpha:1.0f];
}

+ (UIColor *)cellCoordColor
{
    return [UIColor colorWithRed:66.0f/255.0f green:180.0f/255.0f blue:154.0f/255.0f alpha:1.0f];
}

+ (UIColor *)cellBottomLineColor
{
    return [UIColor colorWithRed:168.0f/255.0f green:170.0f/255.0f blue:167.0f/255.0f alpha:1.0f];
}


@end