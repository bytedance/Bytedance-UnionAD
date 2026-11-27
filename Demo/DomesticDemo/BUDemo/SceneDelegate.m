//
//  SceneDelegate.m
//  BUDemo
//

#import "SceneDelegate.h"
#import "AppDelegate.h"

@implementation SceneDelegate

- (void)scene:(UIScene *)scene
    willConnectToSession:(UISceneSession *)session
               options:(UISceneConnectionOptions *)connectionOptions {
    if (![scene isKindOfClass:[UIWindowScene class]]) {
        return;
    }
    AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    UIWindow *window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    window.rootViewController = [appDelegate rootViewController];
    self.window = window;
    appDelegate.window = window;
    [window makeKeyAndVisible];
}

@end
