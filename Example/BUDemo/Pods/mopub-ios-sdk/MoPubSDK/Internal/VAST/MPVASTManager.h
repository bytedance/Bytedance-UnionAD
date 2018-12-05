//
//  MPVASTManager.h
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <Foundation/Foundation.h>
#import "MPVASTResponse.h"

typedef enum {
    MPVASTErrorXMLParseFailure,
    MPVASTErrorExceededMaximumWrapperDepth,
    MPVASTErrorNoAdsFound
} MPVASTError;

@interface MPVASTManager : NSObject

+ (void)fetchVASTWithURL:(NSURL *)URL completion:(void (^)(MPVASTResponse *, NSError *))completion;
+ (void)fetchVASTWithData:(NSData *)data completion:(void (^)(MPVASTResponse *, NSError *))completion;

@end
