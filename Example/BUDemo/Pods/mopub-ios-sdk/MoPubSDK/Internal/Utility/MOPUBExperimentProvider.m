//
//  MOPUBExperimentProvider.m
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MOPUBExperimentProvider.h"

@implementation MOPUBExperimentProvider

static BOOL gIsDisplayAgentOverriddenByClient = NO;
static MOPUBDisplayAgentType gDisplayAgentType = MOPUBDisplayAgentTypeInApp;

+ (void)setDisplayAgentType:(MOPUBDisplayAgentType)displayAgentType
{
    gIsDisplayAgentOverriddenByClient = YES;
    gDisplayAgentType = displayAgentType;
}

+ (void)setDisplayAgentFromAdServer:(MOPUBDisplayAgentType)displayAgentType
{
    if (!gIsDisplayAgentOverriddenByClient) {
        gDisplayAgentType = displayAgentType;
    }
}

+ (MOPUBDisplayAgentType)displayAgentType
{
    return gDisplayAgentType;
}

// used in test only
+ (void)setDisplayAgentOverriddenByClientFlag:(BOOL)flag
{
    gIsDisplayAgentOverriddenByClient = flag;
}

@end
