//
//  VenueParser.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "VenueParser.h"
#import <EasyMapping/EasyMapping.h>
#import "Venue.h"
#import "ServiceRegistry.h"
#import "CoreDataStack.h"

NSString *VenueParserErrorDomain = @"VenueParserErrorDomain";

@implementation VenueParser

- (NSArray *)venuesFromJSON:(NSString *)objectNotation error:(NSError *__autoreleasing *)error
{
    NSParameterAssert(objectNotation != nil);
    NSData *unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
    NSError *localError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation options:0 error:&localError];
    NSDictionary *parsedObject = (id)jsonObject;
    if(parsedObject == nil)
    {
        if (error != NULL)
        {
            *error = [NSError errorWithDomain: VenueParserErrorDomain
                                         code: VenueParserInvalidJSONError
                                     userInfo: nil];
        }
        return nil;
    }
    NSArray *venues = [[parsedObject objectForKey:@"response"] objectForKey:@"venues"];
    if(venues == nil)
    {
        if (error != NULL)
        {
            *error = [NSError errorWithDomain: VenueParserErrorDomain
                                         code: VenueParserMissingDataError
                                     userInfo: nil];
        }
        return nil;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Venue" inManagedObjectContext:SREG.coreDataStack.managedObjectContext];
    fetchRequest.entity = entity;
    
    NSArray *venueObjects = [EKManagedObjectMapper syncArrayOfObjectsFromExternalRepresentation:venues
                                                                                    withMapping:[Venue objectMapping]
                                                                                   fetchRequest:fetchRequest
                                                                         inManagedObjectContext:SREG.coreDataStack.managedObjectContext];
    return venueObjects;
}

- (void)fillInDetailedInfoForVenue:(Venue *)venue
                          fromJSON:(NSString *)objectNotation
{
    NSParameterAssert(venue != nil);
    NSParameterAssert(objectNotation != nil);
    NSData *unicodeNotation = [objectNotation dataUsingEncoding: NSUTF8StringEncoding];
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData: unicodeNotation options: 0 error: NULL];
    if (![parsedObject isKindOfClass: [NSDictionary class]])
    {
        return;
    }
    
    NSDictionary *venueDict = [[parsedObject objectForKey:@"response"] objectForKey:@"venue"];
    
    [EKManagedObjectMapper fillObject:venue
           fromExternalRepresentation:venueDict
                          withMapping:[Venue objectMapping]
               inManagedObjectContext:SREG.coreDataStack.managedObjectContext];
    
    /*
    NSString *venueBody = [[[parsedObject objectForKey: @"items"] lastObject] objectForKey: @"body"];
    if (questionBody)
    {
        question.body = questionBody;
    }
     */
}

@end
