//
//  FetchObject.h
//  YiPaiApp
//
//  Created by 易 彬锋 on 16/6/9.
//  Copyright © 2016年 bfy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FetchObject : NSObject
@property   (nonatomic,strong)NSURL     *fileUr; //文件地址
@property   (nonatomic,strong)UIImage   *thumbImage;    //图片缩列图
@property   (nonatomic,strong)NSString   *videoDuration; //视频时长
@property   (nonatomic,strong)NSString  *videoName;  //视频名字
@property   (nonatomic,strong)NSString  *fileSize;//视频文件的大小
@property   (nonatomic,strong)NSString  *location;//视频拍摄的地点



@end
