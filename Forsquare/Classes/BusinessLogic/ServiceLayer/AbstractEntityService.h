//
//  AbstractEntityService.h
//  EventGridManager
//
//  Created by Anton Kovalchuk on 07.01.15.
//  Copyright (c) 2015 Entech Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AbstractCache;
@class AbstractParser;
@class AbstractTransport;
@class AbstractSerializer;

@interface AbstractEntityService : NSObject
@property (nonatomic, strong) AbstractCache      *abstractCache;
@property (nonatomic, strong) AbstractParser     *abstractParser;
@property (nonatomic, strong) AbstractTransport  *abstractTransport;
@property (nonatomic, strong) AbstractSerializer *abstractSerializer;
@end
