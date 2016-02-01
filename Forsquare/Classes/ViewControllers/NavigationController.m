//
//  NavigationController.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 01.02.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "NavigationController.h"
#import "UIColor+Extensions.h"

@implementation NavigationController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys: [UIColor cellBackgroundColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"HelveticaNeue" size:22.0], NSFontAttributeName, nil];
        self.navigationBar.tintColor = [UIColor headerColor];
        self.navigationBar.barTintColor = [UIColor headerColor];
    }
    return self;
}

@end
