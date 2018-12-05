//
//  MPTableViewCellImpressionTracker.h
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MPTableViewCellImpressionTrackerDelegate;

@interface MPTableViewCellImpressionTracker : NSObject

- (id)initWithTableView:(UITableView *)tableView delegate:(id<MPTableViewCellImpressionTrackerDelegate>)delegate;
- (void)startTracking;
- (void)stopTracking;

@end

@protocol MPTableViewCellImpressionTrackerDelegate <NSObject>

- (void)tracker:(MPTableViewCellImpressionTracker *)tracker didDetectVisibleRowsAtIndexPaths:(NSArray *)indexPaths;

@end
