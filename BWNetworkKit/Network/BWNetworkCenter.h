//
//  BWNetworkCenter.h
//  BWNetworkActivity
//
//  Created by Bob Wong on 16/7/12.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const basicCommandURLString;
extern NSString *const basicURLString;  //!< 请求URL基体，这种比宏定义的方式更加合理

extern NSString *const kCommonRegister;
extern NSString *const kCommonLogin;
extern NSString *const kCommonLogout;

@interface BWNetworkCenter : NSObject

@end
