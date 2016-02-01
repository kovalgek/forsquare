//
//  VenueCell.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 31.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "VenueCell.h"
#import "Venue.h"
#import "Location.h"
#import "UIView+AutoLayout.h"
#import "UIColor+Extensions.h"

@implementation VenueCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        self.bottomLine = [[UIView alloc] init];
        self.bottomLine.backgroundColor = [UIColor cellBottomLineColor];
        [self addSubview:self.bottomLine];
        self.bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
        [self.bottomLine autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
        [self.bottomLine autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
        [self.bottomLine autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
        [self.bottomLine autoSetDimension:ALDimensionHeight toSize:1.0f];
    }
    return self;
}

- (void)fillWithEntity:(Venue *)venue
{
    self.titleLabel.text = venue.nameAttribute;
    self.subtitleLabel.text = venue.location.addressAttribute;
    self.coordinateLabel.text = [NSString stringWithFormat:@"%.2f %.2f", venue.location.latAttribute.floatValue,venue.location.lngAttribute.floatValue];
}

@end
