//
//  BWCommon.m
//  BWNetworkActivity
//
//  Created by Bob Wong on 16/7/12.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWCommon.h"

@implementation BWCommon

static NSString *deviceUUID;

+ (NSString *)deviceUUID
{
    if (!deviceUUID) {
        CFUUIDRef puuid = CFUUIDCreate(nil);
        CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
        deviceUUID = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
        return deviceUUID;
    }
    
    return deviceUUID;
}

@end
