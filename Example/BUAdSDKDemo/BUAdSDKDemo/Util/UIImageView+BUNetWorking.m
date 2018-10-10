//
//  UIImageView+BUNetWorking.m
//  BUAdSDKDemo
//
//  Created by carl on 2017/8/15.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "UIImageView+BUNetWorking.h"

@implementation UIImageView (BUNetWorking)

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    NSURLSession *shareSessin = [NSURLSession sharedSession];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [shareSessin dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setImage:image];
        });
    }];
    [dataTask resume];
}

@end
