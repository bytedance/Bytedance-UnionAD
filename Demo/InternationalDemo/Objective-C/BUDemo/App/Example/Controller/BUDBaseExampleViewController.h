//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import <Foundation/Foundation.h>
#import "BUDExampleDefine.h"
#import <UIKit/UIKit.h>
#import "BUDSwitchView.h"

@interface BUDBaseExampleViewController : UIViewController <BUDExampleViewControl>
@property (nonatomic, strong) id<BUDExampleViewModel> viewModel;
@property (nonatomic, copy) NSString *adName;
@property (nonatomic, assign) BOOL haveRenderSwitchView;
@property (nonatomic, strong, readonly) BUDSwitchView *renderSwitchView;


@property (nonatomic, getter=logKeyword, readonly) NSString *logKeyword;
- (void)bud_delegateLogWithSEL:(SEL)sel error:(NSError *)error;
- (void)bud_delegateLogWithSEL:(SEL)sel msg:(NSString *)msg;

@end
