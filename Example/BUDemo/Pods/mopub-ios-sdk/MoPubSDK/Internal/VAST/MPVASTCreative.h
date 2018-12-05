//
//  MPVASTCreative.h
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <Foundation/Foundation.h>
#import "MPVASTModel.h"

@class MPVASTLinearAd;

@interface MPVASTCreative : MPVASTModel

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *sequence;
@property (nonatomic, copy, readonly) NSString *adID;
@property (nonatomic, readonly) MPVASTLinearAd *linearAd;
@property (nonatomic, readonly) NSArray *companionAds;

@end
