//
//  BUDCommonMacros.h
//  BUDAdSDK
//
//  Created by 崔亚楠 on 2018/10/23.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>


#ifndef BUD_weakify
#if __has_feature(objc_arc)
#define BUD_weakify(object) __weak __typeof__(object) weak##object = object;
#else
#define BUD_weakify(object) __block __typeof__(object) block##object = object;
#endif
#endif
#ifndef BUD_strongify
#if __has_feature(objc_arc)
#define BUD_strongify(object) __typeof__(object) object = weak##object;
#else
#define BUD_strongify(object) __typeof__(object) object = block##object;
#endif
#endif



#ifndef BUDScreenWidth
#define BUDScreenWidth [[UIScreen mainScreen] bounds].size.width
#endif

#ifndef BUDScreenHeight
#define BUDScreenHeight [[UIScreen mainScreen] bounds].size.height
#endif

#ifndef BUDMINScreenSide
#define BUDMINScreenSide                    MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#endif

#ifndef BUDMAXScreenSide
#define BUDMAXScreenSide                   MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#endif

#define BUDIsNotchScreen bud_is_notch_screen()

#define BUDiPhoneX BUDIsNotchScreen
#define kBUDDefaultNavigationBarHeight  (BUDiPhoneX?88:64)      // 导航条高度
#define kBUDSafeTopMargin (BUDiPhoneX?24:0)
#define kBUDDefaultStautsBarHeight  (BUDiPhoneX?44:20)      // 状态栏高度


FOUNDATION_EXPORT BOOL bud_is_notch_screen(void);



