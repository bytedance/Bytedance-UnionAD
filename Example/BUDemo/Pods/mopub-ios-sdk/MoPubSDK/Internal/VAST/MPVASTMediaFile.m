//
//  MPVASTMediaFile.m
//
//  Copyright 2018-2019 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPVASTMediaFile.h"
#import "MPVASTStringUtilities.h"

@implementation MPVASTMediaFile

+ (NSDictionary *)modelMap
{
    return @{@"bitrate":    @[@"bitrate", MPParseNumberFromString(NSNumberFormatterDecimalStyle)],
             @"height":     @[@"height", MPParseNumberFromString(NSNumberFormatterDecimalStyle)],
             @"width":      @[@"width", MPParseNumberFromString(NSNumberFormatterDecimalStyle)],
             @"identifier": @"id",
             @"delivery":   @"delivery",
             @"mimeType":   @"type",
             @"URL":        @[@"text", MPParseURLFromString()]};
}

@end
