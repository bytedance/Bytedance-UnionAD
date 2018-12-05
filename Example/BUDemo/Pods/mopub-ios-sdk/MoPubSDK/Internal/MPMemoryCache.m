//
//  MPMemoryCache.m
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPMemoryCache.h"
#import "MPLogging.h"

@interface MPMemoryCache() <NSCacheDelegate>
/**
 Memory cache
 */
@property (nonatomic, strong) NSCache * memcache;

@end

@implementation MPMemoryCache

#pragma mark - Initialization

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static MPMemoryCache * manager;
    dispatch_once(&onceToken, ^{
        manager = [[MPMemoryCache alloc] init];
    });

    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _memcache = [[NSCache alloc] init];
        _memcache.delegate = self;
    }

    return self;
}

#pragma mark - Cache Access

- (NSData * _Nullable)dataForKey:(NSString * _Nonnull)key {
    if (key == nil) {
        return nil;
    }

    MPLogTrace(@"%@ retrieved data for key %@", NSStringFromClass(self.class), key);
    return [self.memcache objectForKey:key];
}

- (void)setData:(NSData * _Nullable)data forKey:(NSString * _Nonnull)key {
    if (key == nil) {
        return;
    }

    // Set cache entry
    if (data != nil) {
        MPLogTrace(@"%@ set data %@ for key %@", NSStringFromClass(self.class), data, key);
        [self.memcache setObject:data forKey:key];
    }
    // Remove cache entry
    else {
        MPLogTrace(@"%@ removed cache entry %@", NSStringFromClass(self.class), key);
        [self.memcache removeObjectForKey:key];
    }
}

#pragma mark - NSCacheDelegate

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    MPLogTrace(@"%@ evicted %@", NSStringFromClass(self.class), obj);
}

@end

@implementation MPMemoryCache (UIImage)

- (UIImage * _Nullable)imageForKey:(NSString * _Nonnull)key {
    NSData * imageData = [self dataForKey:key];
    if (imageData == nil) {
        MPLogTrace(@"%@ found no image data for key %@", NSStringFromClass(self.class), key);
        return  nil;
    }

    return [[UIImage alloc] initWithData:imageData];
}

@end
