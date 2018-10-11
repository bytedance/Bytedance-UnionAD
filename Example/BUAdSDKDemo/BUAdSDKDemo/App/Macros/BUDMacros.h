//
//  BUDMacros.h
//  BUAdSDKDemo
//
//  Created by bytedance_yuanhuan on 2018/10/11.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#ifndef BUDMacros_h
#define BUDMacros_h

/// iphone X、XR、XS、XS Max适配
#ifndef BUDMINScreenSide
#define BUDMINScreenSide                    MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#endif

#ifndef BUDMAXScreenSide
#define BUDMAXScreenSide                   MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#endif

#define BUDiPhoneX ((BUDMAXScreenSide == 812.0) || (BUDMAXScreenSide == 896))
#define NavigationBarHeight (BUDiPhoneX? 88: 64)      // 导航条高度
#define TopMargin        (BUDiPhoneX? 24: 0)
#define BottomMargin     (BUDiPhoneX? 40: 0)      // 状态栏高度

#endif /* BUDMacros_h */
