//
//  PhotoItemCell.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 31.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "PhotoItemCell.h"
#import "UIView+AutoLayout.h"

@implementation PhotoItemCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        self.activityView = [[UIActivityIndicatorView alloc] init];
        self.activityView.color = [UIColor lightGrayColor];
        [self addSubview:self.activityView];
        self.activityView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.activityView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
        [self.activityView autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
        [self.activityView autoSetDimension:ALDimensionWidth toSize:44.0f];
        [self.activityView autoSetDimension:ALDimensionHeight toSize:44.0f];
        
        self.picture = [[UIImageView alloc] init];
        self.picture.backgroundColor = [UIColor clearColor];
        self.picture.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.picture];
        [self.picture autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
        [self.picture autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
    }
    return self;
}

- (void)fillWithEntity:(PhotoItem *)photoItem
{
    
}

@end
