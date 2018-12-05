//
//  MPVASTResource.m
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPVASTResource.h"

@implementation MPVASTResource

+ (NSDictionary *)modelMap
{
    return @{@"content":            @"text",
             @"staticCreativeType": @"creativeType"};
}

@end
