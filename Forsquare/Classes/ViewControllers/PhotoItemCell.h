//
//  PhotoItemCell.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 31.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoItem;

@interface PhotoItemCell : UITableViewCell

@property (nonatomic, strong) UIImageView             *picture;
@property (nonatomic, strong) NSIndexPath             *lastIndexPath;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

- (void)fillWithEntity:(PhotoItem *)photoItem;

@end
