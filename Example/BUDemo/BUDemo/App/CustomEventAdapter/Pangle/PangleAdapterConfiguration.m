#import "PangleAdapterConfiguration.h"
#import <BUAdSDK/BUAdSDKManager.h>

@implementation PangleAdapterConfiguration

NSString * const kPangleAppIdKey = @"app_id";
NSString * const kPanglePlacementIdKey = @"ad_placement_id";

static NSString * const kAdapterVersion = @"3.0.0.6.0";
static NSString * const kAdapterErrorDomain = @"com.mopub.mopub-ios-sdk.mopub-pangle-adapters";

typedef NS_ENUM(NSInteger, PangleAdapterErrorCode) {
    PangleAdapterErrorCodeMissingIdKey,
};

#pragma mark - MPAdapterConfiguration

- (NSString *)adapterVersion {
    return kAdapterVersion;
}

- (NSString *)biddingToken {
    return [BUAdSDKManager mopubBiddingToken];
}

- (NSString *)moPubNetworkName {
    return @"pangle";
}

- (NSString *)networkSdkVersion {
    return [BUAdSDKManager SDKVersion]?:@"";
}

- (void)initializeNetworkWithConfiguration:(NSDictionary<NSString *, id> *)configuration complete:(void(^)(NSError *))complete {
    NSString *appId = configuration[kPangleAppIdKey];
    if (!BUCheckValidString(appId)) {
        NSError *error = [NSError errorWithDomain:kAdapterErrorDomain
                                             code:PangleAdapterErrorCodeMissingIdKey
                                         userInfo:@{NSLocalizedDescriptionKey:
                                                        @"appId may be not right, please set networkConfig refer to method '-configCustomEvent' in 'AppDelegate' class"}];
        if (complete != nil) {
            complete(error);
        }
    } else {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [BUAdSDKManager setAppID:appId];
                MPBLogLevel logLevel = [MPLogging consoleLogLevel];
                BOOL verboseLoggingEnabled = (logLevel == MPBLogLevelDebug);
                [BUAdSDKManager setLoglevel:verboseLoggingEnabled == true ? BUAdSDKLogLevelDebug : BUAdSDKLogLevelNone];
                if ([[MoPub sharedInstance] isGDPRApplicable] != MPBoolUnknown) {
                    BOOL canCollect =  [[MoPub sharedInstance] canCollectPersonalInfo];
                    /// Custom set the GDPR of the user,GDPR is the short of General Data Protection Regulation,the interface only works in The European.
                    /// @params GDPR 0 close privacy protection, 1 open privacy protection
                    [BUAdSDKManager setGDPR:canCollect ? 0 : 1];
                }
                if (complete != nil) {
                    complete(nil);
                }
            });
        });
    }
}

#pragma mark - Caching
+ (void)updateInitializationParameters:(NSDictionary *)parameters {
    NSString * appId = parameters[kPangleAppIdKey];
    if (BUCheckValidString(appId)) {
        NSDictionary * configuration = @{kPangleAppIdKey: appId};
        [PangleAdapterConfiguration setCachedInitializationParameters:configuration];
    }
}
@end
