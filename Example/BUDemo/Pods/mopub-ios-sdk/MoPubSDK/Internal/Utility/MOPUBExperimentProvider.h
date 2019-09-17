//
//  MOPUBExperimentProvider.h
//
//  Copyright 2018-2019 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPAdDestinationDisplayAgent.h"

@interface MOPUBExperimentProvider : NSObject

+ (void)setDisplayAgentType:(MOPUBDisplayAgentType)displayAgentType;
+ (void)setDisplayAgentFromAdServer:(MOPUBDisplayAgentType)displayAgentType;
+ (MOPUBDisplayAgentType)displayAgentType;

@end
