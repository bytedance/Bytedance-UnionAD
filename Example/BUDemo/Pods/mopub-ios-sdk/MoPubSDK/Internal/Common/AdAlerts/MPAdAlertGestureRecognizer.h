//
//  MPAdAlertGestureRecognizer.h
//
//  Copyright 2018-2019 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <UIKit/UIKit.h>

extern NSInteger const kMPAdAlertGestureMaxAllowedYAxisMovement;

typedef enum
{
    MPAdAlertGestureRecognizerState_ZigRight1,
    MPAdAlertGestureRecognizerState_ZagLeft2,
    MPAdAlertGestureRecognizerState_Recognized
} MPAdAlertGestureRecognizerState;

@interface MPAdAlertGestureRecognizer : UIGestureRecognizer

// default is 4
@property (nonatomic, assign) NSInteger numZigZagsForRecognition;

// default is 100
@property (nonatomic, assign) CGFloat minTrackedDistanceForZigZag;

@property (nonatomic, readonly) MPAdAlertGestureRecognizerState currentAlertGestureState;
@property (nonatomic, readonly) CGPoint inflectionPoint;
@property (nonatomic, readonly) BOOL thresholdReached;
@property (nonatomic, readonly) NSInteger curNumZigZags;

@end
