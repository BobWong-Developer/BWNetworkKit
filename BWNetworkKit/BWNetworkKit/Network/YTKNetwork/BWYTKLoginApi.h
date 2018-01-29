//
//  BWYTKLoginApi.h
//  BWNetworkKit
//
//  Created by BobWong on 2018/1/29.
//  Copyright © 2018年 BobWong. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface BWYTKLoginApi : YTKRequest

- (id)initWithAccount:(NSString *)account password:(NSString *)password;

@end
