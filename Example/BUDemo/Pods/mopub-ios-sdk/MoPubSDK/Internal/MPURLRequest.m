//
//  MPURLRequest.m
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPURLRequest.h"
#import "MPAPIEndpoints.h"
#import "MPLogging.h"
#import "MPURL.h"

// All requests have a 10 second timeout.
const NSTimeInterval kRequestTimeoutInterval = 10.0;

NS_ASSUME_NONNULL_BEGIN
@interface MPURLRequest()

@end

@implementation MPURLRequest

- (instancetype)initWithURL:(NSURL *)URL {
    // In the event that the URL passed in is really a MPURL type,
    // extract the POST body.
    NSMutableDictionary<NSString *, NSObject *> * postData = [NSMutableDictionary dictionary];
    if ([URL isKindOfClass:[MPURL class]]) {
        MPURL * mpUrl = (MPURL *)URL;
        if ([NSJSONSerialization isValidJSONObject:mpUrl.postData]) {
            postData = mpUrl.postData;
        }
        else {
            MPLogFatal(@"POST Data is not serializable into JSON:\n%@", mpUrl.postData);
        }
    }

    // Requests sent to MoPub should always be in POST format. All other requests
    // should be sent as a normal GET.
    BOOL isMoPubRequest = [URL.host isEqualToString:MPAPIEndpoints.baseHostname];
    NSURL * requestUrl = URL;
    if (isMoPubRequest) {
        // Move the query parameters to the POST data dictionary.
        // NSURLQUeryItem automatically URL decodes the query parameter name and value when
        // using the `name` and `value` properties.
        NSURLComponents * components = [NSURLComponents componentsWithURL:URL resolvingAgainstBaseURL:NO];
        [components.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            postData[obj.name] = obj.value;
        }];

        // The incoming URL may contain query parameters; we will need to strip them out.
        components.queryItems = nil;
        requestUrl = components.URL;
    }

    if (self = [super initWithURL:requestUrl]) {
        // Generate the request
        [self setHTTPShouldHandleCookies:NO];
        [self setValue:MPURLRequest.userAgent forHTTPHeaderField:@"User-Agent"];
        [self setCachePolicy:NSURLRequestReloadIgnoringCacheData];
        [self setTimeoutInterval:kRequestTimeoutInterval];

        // Request contains POST data or is a MoPub request; the should be a POST
        // with a UTF-8 JSON payload as the HTTP body.
        if (isMoPubRequest || postData.count > 0) {
            [self setHTTPMethod:@"POST"];
            [self setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

            // Generate the JSON body from the POST parameters
            NSError * error = nil;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:postData options:0 error:&error];

            // Set the request body with the query parameter key/value pairs if there was no
            // error in generating a JSON from the dictionary.
            if (error == nil) {
                [self setValue:[NSString stringWithFormat:@"%lu", (unsigned long)jsonData.length] forHTTPHeaderField:@"Content-Length"];
                [self setHTTPBody:jsonData];
            }
            else {
                MPLogError(@"Could not generate JSON body from %@", postData);
            }
        }
    }

    return self;
}

+ (MPURLRequest *)requestWithURL:(NSURL *)URL {
    return [[MPURLRequest alloc] initWithURL:URL];
}

- (NSString *)description {
    if (self.HTTPBody != nil) {
        NSString * httpBody = [[NSString alloc] initWithData:self.HTTPBody encoding:NSUTF8StringEncoding];
        return [NSString stringWithFormat:@"%@\n%@", self.URL, httpBody];
    }
    else {
        return self.URL.absoluteString;
    }
}

/**
 Global variable for holding the user agent string
 */
NSString * gUserAgent = nil;

/**
 Retrieves the current user agent as determined by @c UIWebView.
 @returns The user agent.
 */
+ (NSString *)userAgent {
    if (gUserAgent == nil) {
        // The user agent string cannot be obtained from a UIWebView unless on the
        // main thread (there'll be a crash if you try to obtain on a thread other than main).
        // Therefore, obtain the string on main thread and block this thread if needed to get it.

        // Make a block to obtain the user agent string
        void (^obtainUserAgentBlock)(void) = ^void(void) {
            // Only set @c gUserAgent on the main thread to avoid undefined behavior.
            gUserAgent = [[[UIWebView alloc] init] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        };

        if ([NSThread isMainThread]) {
            // Run the block directly if on main thread.
            obtainUserAgentBlock();
        } else {
            // Block this thread to obtain user agent string on main thread.
            dispatch_sync(dispatch_get_main_queue(), obtainUserAgentBlock);
        }
    }

    return gUserAgent;
}

@end
NS_ASSUME_NONNULL_END
