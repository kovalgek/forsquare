//
//  Constants.h
//  Gate
//
//  Created by Антон Ковальчук on 28.10.13.
//  Copyright (c) 2013 Антон Ковальчук. All rights reserved.
//

#import <UIKit/UIKit.h>

static int DEFAULT_LATITUDE = 51.50f;
static int DEFAULT_LONGITUDE = -0.123f;

static NSString *CLIENT_ID     = @"BH30UAKM02OBQKOPRFXWVI2VXYDONAFSGD10AMMEHP3QOOZ3";
static NSString *CLIENT_SECRET = @"XJNTU1ZJSDJQBMTUDOXZYMWIIYM0C2KUMLG0OEVVNRDJMNVI";

static NSString *API_URL = @"https://api.foursquare.com/v2/";

static NSString *VENUES_SEARCH = @"venues/search?ll=%f,%f&client_id=%@&client_secret=%@&v=20160130&limit=10";
static NSString *VENUE_BY_ID   = @"venues/%@?client_id=%@&client_secret=%@&v=20160130";

@interface Constants : NSObject
@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong) NSString *base_url;
@property (nonatomic, strong) NSString *eventLink;
+ (Constants *)instance;
- (void) reset;
@end