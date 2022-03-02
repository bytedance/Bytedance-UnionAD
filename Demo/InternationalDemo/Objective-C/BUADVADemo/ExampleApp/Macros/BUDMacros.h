//
//  BUDMacros.h
//  BUAdSDKDemo
//
//  Created by bytedance_yuanhuan on 2018/10/11.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#ifndef BUDMacros_h
#define BUDMacros_h

#define BUD_RGB(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1]

#define unValidColor BUD_RGB(0xd7, 0xd7, 0xd7)
#define mainColor BUD_RGB(0xff, 0x63, 0x5c)
#define selectedColor [UIColor colorWithRed:(73/255.0) green:(15/255.0) blue:(15/255.0) alpha:0.8]

/// iphone X、XR、XS、XS Max适配
#ifndef BUDMINScreenSide
#define BUDMINScreenSide                    MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#endif

#ifndef BUDMAXScreenSide
#define BUDMAXScreenSide                   MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#endif


#define BUD_Log(frmt, ...)   \
do {                                                      \
NSLog(@"【BUAdDemo】%@", [NSString stringWithFormat:frmt,##__VA_ARGS__]);  \
} while(0)

#endif /* BUDMacros_h */
