//
//  UIWebView+MPAdditions.m
//
//  Copyright 2018-2019 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "UIWebView+MPAdditions.h"

NSString *const kJavaScriptDisableDialogSnippet = @"window.alert = function() { }; window.prompt = function() { }; window.confirm = function() { };";

@implementation UIWebView (MPAdditions)

/*
 * Find all subviews that are UIScrollViews or subclasses and set their scrolling and bounce.
 */
- (void)mp_setScrollable:(BOOL)scrollable {
    if ([self respondsToSelector:@selector(scrollView)])
    {
        UIScrollView *scrollView = self.scrollView;
        scrollView.scrollEnabled = scrollable;
        scrollView.bounces = scrollable;
    }
    else
    {
        UIScrollView *scrollView = nil;
        for (UIView *v in self.subviews)
        {
            if ([v isKindOfClass:[UIScrollView class]])
            {
                scrollView = (UIScrollView *)v;
                break;
            }
        }
        scrollView.scrollEnabled = scrollable;
        scrollView.bounces = scrollable;
    }
}

/*
 * Redefine alert, prompt, and confirm to do nothing
 */
- (void)disableJavaScriptDialogs
{
    [self stringByEvaluatingJavaScriptFromString:kJavaScriptDisableDialogSnippet];
}

@end
