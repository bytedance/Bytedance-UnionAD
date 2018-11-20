//
//  BUDPlayer.h
//  BUDemo
//
//  Created by iCuiCui on 2018/10/26.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BUDPlayerController : UIViewController
@property (nonatomic, strong) NSURL *contentURL;
- (void)play;
- (void)pause;
@end
