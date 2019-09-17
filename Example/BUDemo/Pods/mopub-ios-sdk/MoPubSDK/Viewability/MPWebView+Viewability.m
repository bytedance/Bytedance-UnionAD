//
//  MPWebView+Viewability.m
//
//  Copyright 2018-2019 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPWebView+Viewability.h"
#import <WebKit/WebKit.h>

@interface MPWebView ()

- (UIWebView *)uiWebView;
- (WKWebView *)wkWebView;

@end

@implementation MPWebView (Viewability)

- (UIView *)containedWebView {
    return self.uiWebView ? self.uiWebView : self.wkWebView;
}

@end
