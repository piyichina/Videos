//
//  FetchObject.m
//  YiPaiApp
//
//  Created by 易 彬锋 on 16/6/9.
//  Copyright © 2016年 bfy. All rights reserved.
//

#import "FetchObject.h"

@implementation FetchObject
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.fileUr     =   [aDecoder decodeObjectForKey:@"fileUr"];
        self.videoDuration  =   [aDecoder decodeObjectForKey:@"videoDuration"];
        self.videoName  =   [aDecoder decodeObjectForKey:@"videoName"];
        self.fileSize     =   [aDecoder decodeObjectForKey:@"fileSize"];
        self.location     =   [aDecoder decodeObjectForKey:@"location"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_fileUr forKey:@"fileUr"];
    [aCoder encodeObject:_videoDuration forKey:@"videoDuration"];
    [aCoder encodeObject:_videoName forKey:@"videoName"];
    [aCoder encodeObject:_location forKey:@"location"];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
@end
