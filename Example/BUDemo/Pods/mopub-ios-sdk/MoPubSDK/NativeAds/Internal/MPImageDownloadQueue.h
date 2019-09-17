//
//  MPImageDownloadQueue.h
//
//  Copyright 2018-2019 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <Foundation/Foundation.h>

typedef void (^MPImageDownloadQueueCompletionBlock)(NSArray *errors);

@interface MPImageDownloadQueue : NSObject

// pass useCachedImage:NO to force download of images. default is YES, cached images will not be re-downloaded
- (void)addDownloadImageURLs:(NSArray *)imageURLs completionBlock:(MPImageDownloadQueueCompletionBlock)completionBlock;
- (void)addDownloadImageURLs:(NSArray *)imageURLs completionBlock:(MPImageDownloadQueueCompletionBlock)completionBlock useCachedImage:(BOOL)useCachedImage;

- (void)cancelAllDownloads;

@end
