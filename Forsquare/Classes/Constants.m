//
//  qwe.m
//  EventGridManager
//
//  Created by Anton Kovalchuk on 13.09.14.
//  Copyright (c) 2014 Антон Ковальчук. All rights reserved.
//

#import "Constants.h"

@implementation Constants

static Constants *_instance;

+ (Constants *)instance
{
    if(_instance == nil)
    {
        _instance = [[self alloc] init];
    }
    return _instance;
}

- (instancetype)init
{
    if(self = [super init])
    {
        self.eventLink = @"https://eventgrid.com/Events/%d";
        self.host     = HOST;
        self.base_url = [NSString stringWithFormat: @"https://%@/",HOST];
    }
    return self;
}

- (void) reset
{
    self.host     = HOST;
    self.base_url = [NSString stringWithFormat: @"https://%@/",HOST];
}

@end
