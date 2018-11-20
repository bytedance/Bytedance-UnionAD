//
//  BUDBaseExampleViewController.h
//  BUDemo
//
//  Created by carl on 2017/12/4.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUDExampleDefine.h"
#import <UIKit/UIKit.h>

@interface BUDBaseExampleViewController : UIViewController <BUDExampleViewControl>
@property (nonatomic, strong) id<BUDExampleViewModel> viewModel;
@end
