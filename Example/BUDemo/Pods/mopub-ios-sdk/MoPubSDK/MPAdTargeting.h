//
//  MPAdTargeting.h
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <Foundation/Foundation.h>

@class CLLocation;

/**
 Optional targeting parameters to use when requesting an ad.
 */
@interface MPAdTargeting : NSObject

/**
 A string representing a set of non-personally identifiable keywords that should be passed
 to the MoPub ad server to receive more relevant advertising.

 @remark If a user is in General Data Protection Regulation (GDPR) region and MoPub doesn't obtain
 consent from the user, @c keywords will still be sent to the server.
 */
@property (nonatomic, copy) NSString * keywords;

/**
 Key-value pairs that are locally available to the custom event.
 */
@property (nonatomic, copy) NSDictionary * localExtras;

/**
 A user's location that should be passed to the MoPub ad server to receive more relevant advertising.
 */
@property (nonatomic, copy) CLLocation * location;

/**
 A string representing a set of personally identifiable keywords that should be passed to the MoPub ad server to receive
 more relevant advertising.

 Keywords are typically used to target ad campaigns at specific user segments. They should be
 formatted as comma-separated key-value pairs (e.g. "marital:single,age:24").

 On the MoPub website, keyword targeting options can be found under the "Advanced Targeting"
 section when managing campaigns.

 @remark If a user is in General Data Protection Regulation (GDPR) region and MoPub doesn't obtain
 consent from the user, @c userDataKeywords will not be sent to the server.
 */
@property (nonatomic, copy) NSString * userDataKeywords;

@end
