//
//  MPVASTResource.h
//
//  Copyright 2018-2019 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <Foundation/Foundation.h>
#import "MPVASTModel.h"

@interface MPVASTResource : MPVASTModel

@property (nonatomic, readonly) NSString *content;
@property (nonatomic, readonly) NSString *staticCreativeType;

@end
