//
//  VenueCache.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "VenueCache.h"
#import "Venue.h"
#import "ServiceRegistry.h"

@implementation VenueCache

- (NSArray *)venues
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Venue" inManagedObjectContext:SREG.coreDataStack.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"nameAttribute" ascending:YES]];
    
    NSError *error;
    NSArray *venues = [SREG.coreDataStack.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if(error)
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return venues;
}

- (Venue *)venueByID:(NSString *)venueID
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Venue" inManagedObjectContext:SREG.coreDataStack.managedObjectContext];
    NSPredicate *predicateID = [NSPredicate predicateWithFormat:@"idAttribute == %@",venueID];
    [fetchRequest setPredicate:predicateID];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    
    NSError *error;
    NSArray *venues = [SREG.coreDataStack.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if(error)
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return venues.firstObject;
}

@end
