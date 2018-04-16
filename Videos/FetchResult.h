//
//  FetchResult.h
//  YiPaiApp
//
//  Created by 易 彬锋 on 16/6/8.
//  Copyright © 2016年 bfy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "FetchObject.h"
typedef void (^getVideoBlock)(NSMutableArray *videoArray,NSMutableArray *imageArray);
@interface FetchResult : NSObject

@property   (nonatomic,strong)NSMutableArray   *videoArray; //视频对象数组
@property   (nonatomic,strong)NSMutableArray   *imageArray; //图片对象数组
@property   (nonatomic,copy)getVideoBlock block;    //返回获取视频音频对象
@property   (nonatomic,strong)ALAssetsLibrary   *assetsLibrary;
+ (FetchResult*)shareResult; //单列方法
- (void)getVideoArray;       //获取本地视频对象
- (BOOL)authStatus;  //验证是否有相册访问权限
- (void)loadAssetsGroup;

@end
