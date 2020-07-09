#import <Foundation/Foundation.h>
#import <BUFoundation/BUCommonMacros.h>
#if __has_include(<MoPub/MoPub.h>)
    #import <MoPub/MoPub.h>
#elif __has_include(<MoPubSDKFramework/MoPub.h>)
    #import <MoPubSDKFramework/MoPub.h>
#else
    #import "MoPub.h"
#endif

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PangleRenderMethod) {
    PangleRenderMethodExpress = 1,
    PangleRenderMethodTraditional = 2
};

@interface PangleAdapterConfiguration :MPBaseAdapterConfiguration

// Caching
/**
 Extracts the parameters used for network SDK initialization and if all required
 parameters are present, updates the cache.
 @param parameters Ad response parameters
 */
+ (void)updateInitializationParameters:(NSDictionary *)parameters;

@property (nonatomic, copy, readonly) NSString * adapterVersion;
@property (nonatomic, copy, readonly) NSString * biddingToken;
@property (nonatomic, copy, readonly) NSString * moPubNetworkName;
@property (nonatomic, copy, readonly) NSString * networkSdkVersion;

// MPAdapterConfiguration
extern NSString * const kPangleNetworkName;
extern NSString * const kPangleAppIdKey;
extern NSString * const kPanglePlacementIdKey;

- (void)initializeNetworkWithConfiguration:(NSDictionary<NSString *, id> * _Nullable)configuration
                                  complete:(void(^ _Nullable)(NSError * _Nullable))complete;
@end

NS_ASSUME_NONNULL_END
