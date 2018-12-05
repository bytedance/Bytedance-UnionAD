//
//  MPAdDestinationDisplayAgent.h
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <Foundation/Foundation.h>
#import "MPActivityViewControllerHelper+TweetShare.h"
#import "MPURLResolver.h"
#import "MPProgressOverlayView.h"
#import "MPAdBrowserController.h"
#import "MPStoreKitProvider.h"
#import "MOPUBDisplayAgentType.h"

@protocol MPAdDestinationDisplayAgentDelegate;

@interface MPAdDestinationDisplayAgent : NSObject <MPProgressOverlayViewDelegate,
                                                   MPAdBrowserControllerDelegate,
                                                   MPSKStoreProductViewControllerDelegate,
                                                   MPActivityViewControllerHelperDelegate>

@property (nonatomic, weak) id<MPAdDestinationDisplayAgentDelegate> delegate;

+ (MPAdDestinationDisplayAgent *)agentWithDelegate:(id<MPAdDestinationDisplayAgentDelegate>)delegate;
+ (BOOL)shouldUseSafariViewController;
- (void)displayDestinationForURL:(NSURL *)URL;
- (void)cancel;

@end

@protocol MPAdDestinationDisplayAgentDelegate <NSObject>

- (UIViewController *)viewControllerForPresentingModalView;
- (void)displayAgentWillPresentModal;
- (void)displayAgentWillLeaveApplication;
- (void)displayAgentDidDismissModal;

@optional

- (MPAdConfiguration *)adConfiguration;

@end
