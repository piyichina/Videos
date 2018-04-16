//
//  FetchResult.m
//  YiPaiApp
//
//  Created by 易 彬锋 on 16/6/8.
//  Copyright © 2016年 bfy. All rights reserved.
//

#import "FetchResult.h"
#import <CoreLocation/CoreLocation.h>
@implementation FetchResult
+ (FetchResult*)shareResult
{
    static  FetchResult *fetchResult    =   nil;
    static  dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        fetchResult =   [[FetchResult alloc]init];
    });
    return fetchResult;
}

#pragma mark if have authstatus
- (BOOL)authStatus
{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    
    if(author   ==  ALAuthorizationStatusRestricted ||author    ==  ALAuthorizationStatusDenied){
        
        //无权限
        return NO;
        
    }else{
        
        return YES;
    }
}

- (void)getVideoArray
{
        NSMutableArray  *videoArray =   [NSMutableArray array];
        NSMutableArray  *imageArray =   [NSMutableArray array];
        ALAssetsLibrary *libarary   =   [[ALAssetsLibrary alloc]init];
        [libarary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop){
            
//            NSLog(@"goup==%@",group.Name);
//             NSString* groupname = [group valueForProperty:ALAssetsGroupPropertyName];
            if (group!=nil) {
//                if ( ![groupname isEqualToString:@"ONEDAY"]) {
//                    return ;
//                }
//                   [group setAssetsFilter:[ALAssetsFilter allVideos]];
                
                [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger xxindex, BOOL *xxstop) {
                    if ([result valueForProperty:ALAssetPropertyType]==ALAssetTypeVideo){
                        FetchObject *fetchObject    =   [[FetchObject alloc]init];
                        fetchObject.thumbImage  =   [UIImage imageWithCGImage:result.thumbnail];
                        fetchObject.fileUr   =  [result defaultRepresentation].url;
                         NSLog(@"videoDuration==%@",[result valueForProperty:ALAssetPropertyDuration]);
                        fetchObject.videoDuration   =  [result valueForProperty:ALAssetPropertyDuration];
                        fetchObject.videoName    =   [result defaultRepresentation].filename;
                        fetchObject.fileSize    =   [NSString stringWithFormat:@"%2.fM",(CGFloat)([result defaultRepresentation].size)/1024/1024];
                        fetchObject.location    =   [result valueForProperty:ALAssetPropertyLocation];
                        [videoArray addObject:fetchObject];
                    }else if ([result valueForProperty:ALAssetPropertyType]==ALAssetTypePhoto)
                    {
                        FetchObject *fetchObject    =   [[FetchObject alloc]init];
                        fetchObject.thumbImage  =   [UIImage imageWithCGImage:result.thumbnail];
                        fetchObject.fileUr   =  [result defaultRepresentation].url;
                        fetchObject.videoName    =   [result defaultRepresentation].filename;
                        fetchObject.fileSize    =   [NSString stringWithFormat:@"%2.fM",(CGFloat)([result defaultRepresentation].size)/1024/1024];
                        fetchObject.location    =   [result valueForProperty:ALAssetPropertyLocation];
                        NSLog(@"videoDuration==%@",[result valueForProperty:ALAssetPropertyDuration]);
                        [imageArray addObject:fetchObject];
                    }
                }];
            }else{
                NSLog(@"group==nil");
                _block(videoArray,imageArray);
            }
        }failureBlock:^(NSError *error){
            
            NSLog(@"error=======%@",error);
        }];
}


- (void)loadAssetsGroup {
    if (!self.assetsLibrary) {
        // 初始化一个ALAssetsLibrary
        self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        @weakify(self)
        [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                          usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//                                              @strongify(self)
                                              if (group) {
                                                  [group setAssetsFilter:[ALAssetsFilter allVideos]];		// 设置过滤，当前只读取相册中的视频
                                                  if ([group numberOfAssets] > 0) {	// 判断是当前相册是否有图片
                                                      if (ALAssetsGroupSavedPhotos == [[group valueForProperty:ALAssetsGroupPropertyType] integerValue]) {
//                                                          [self.assetsGroupArray insertObject:group atIndex:0];	// 如果是系统相册的话就放到第一个
                                                      } else {
//                                                          [self.assetsGroupArray addObject:group];
                                                      }
                                                  }
                                              } else {	// 如果group为nil，说明枚举到最后，可以刷新页面了
                                                  dispatch_async(dispatch_get_main_queue(), ^{
//                                                      self.assetsGroup = self.assetsGroupArray[0];
//                                                      [self loadAssetsFromAssetsGroup];
                                                  });
                                              }
                                          } failureBlock:^(NSError *error) {
                                              NSLog(@"%@", [error userInfo]);
                                          }];
    });
}


@end
