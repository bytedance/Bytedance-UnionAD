//Jenkins防系统库编译出错自动添加 
#import <UIKit/UIKit.h> 
//Jenkins防系统库编译出错自动添加 
//
//  HMDBUToBAddressRange.h
//  HeimdallrToB
//
//  Created by xuminghao.eric on 2020/1/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMDBUToBAddressRange : NSObject

/**
 startAddress 直接传当前加载进去的函数地址就好了 [没必要区间转换 虽然可以用 但是没必要]
 endAddress 直接传当前加载进去的函数地址就好了
 */
@property(nonatomic, assign)int64_t startAddress;
@property(nonatomic, assign)int64_t endAddress;

- (instancetype)initWithStartAddress:(int64_t)startAddress endAddress:(int64_t)endAddress;

@end

NS_ASSUME_NONNULL_END
