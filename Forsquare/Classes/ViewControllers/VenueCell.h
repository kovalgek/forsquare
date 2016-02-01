//
//  VenueCell.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 31.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Venue;

@interface VenueCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *coordinateLabel;
@property (strong, nonatomic) UIView *bottomLine;
- (void)fillWithEntity:(Venue *)venue;
@end
