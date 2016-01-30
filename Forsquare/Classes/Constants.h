//
//  Constants.h
//  Gate
//
//  Created by Антон Ковальчук on 28.10.13.
//  Copyright (c) 2013 Антон Ковальчук. All rights reserved.
//

#import <UIKit/UIKit.h>

static BOOL TEST_MODE = YES;

static NSString *GATE_DB_VERSION        = @"GateDatabaseVersion";
static NSString *CURRENT_DABASE_VERSION = @"0.1";

static NSString *HOST                   = @"api.eventgrid.com";
static NSString *DEV_HOST               = @"api.dev.eventgrid.com";
static NSString *QA_HOST                = @"api.qa.eventgrid.com";
static NSString *STABLE_HOST            = @"api.stable.eventgrid.com";


@interface Constants : NSObject
@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong) NSString *base_url;
@property (nonatomic, strong) NSString *eventLink;
+ (Constants *)instance;
- (void) reset;
@end