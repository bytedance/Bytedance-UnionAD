#import <Foundation/Foundation.h>
#if __has_include(<MoPub/MoPub.h>)
    #import <MoPub/MoPub.h>
#elif __has_include(<MoPubSDKFramework/MoPub.h>)
    #import <MoPubSDKFramework/MoPub.h>
#else
    #import "MPBannerCustomEvent.h"
    #import "MoPub.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface PangleBannerCustomEvent : MPBannerCustomEvent

@end

NS_ASSUME_NONNULL_END
