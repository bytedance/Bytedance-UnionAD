//
//  MPTimer.h
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <Foundation/Foundation.h>

/*
 * MPTimer wraps an NSTimer and adds pause/resume functionality.
 */
@interface MPTimer : NSObject

@property (nonatomic, copy) NSString *runLoopMode;

+ (MPTimer *)timerWithTimeInterval:(NSTimeInterval)seconds
                            target:(id)target
                          selector:(SEL)aSelector
                           repeats:(BOOL)repeats;

- (BOOL)isValid;
- (void)invalidate;
- (BOOL)isScheduled;
- (BOOL)scheduleNow;
- (BOOL)pause;
- (BOOL)resume;
- (NSTimeInterval)initialTimeInterval;

@end
