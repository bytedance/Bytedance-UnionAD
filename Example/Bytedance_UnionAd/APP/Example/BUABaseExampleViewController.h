//
//  BUABaseExampleViewController.h
//  BUAemo
//
//  Created by carl on 2017/12/4.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUAExampleDefine.h"
#import <UIKit/UIKit.h>

@interface BUABaseExampleViewController : UIViewController <BUAExampleViewControl>
@property (nonatomic, strong) id<BUAExampleViewModel> viewModel;
@end
