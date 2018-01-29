//
//  BWYTKLoginApi.m
//  BWNetworkKit
//
//  Created by BobWong on 2018/1/29.
//  Copyright © 2018年 BobWong. All rights reserved.
//

#import "BWYTKLoginApi.h"

@implementation BWYTKLoginApi {
    NSString *_account;
    NSString *_password;
}

- (id)initWithAccount:(NSString *)account password:(NSString *)password {
    self = [super init];
    if (self) {
        _account = account;
        _password = password;
    }
    return self;
}

- (NSString *)baseUrl {
    return @"http://localhost:8081";
}

- (NSString *)requestUrl {
    return @"/account/login";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{@"account": _account,
             @"password": _password};
}

@end
