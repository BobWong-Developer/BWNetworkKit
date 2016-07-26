//
//  BWAFNetworking.m
//  BWNetworkKit
//
//  Created by BobWong on 15/7/17.
//  Copyright (c) 2015年 Bob Wong Studio. All rights reserved.
//

#import "BWAFNetworking.h"
#import "AFHTTPRequestOperationManager.h"


const NSTimeInterval time_out_interval = 30.0;
NSString *const kCommandName = @"command";


@implementation BWAFNetworking

#pragma mark - Singleton

+ (BWAFNetworking *)sharedInstance
{
    static BWAFNetworking *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.isLog = YES;
    });
    
    return sharedInstance;
}

#pragma mark - 请求Command字进行区分

- (void)POSTDefaultWithCommand:(NSString *)command
                    parameters:(id)parameters
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = time_out_interval;
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlString = [NSString stringWithFormat:@"%@", basicCommandURLString];
    NSDictionary *params = [self constructParamsWithCommand:command params:parameters basicParams:[self basicParams]];
    
    if(self.isLog) {
        NSLog(@"POST请求，请求URL：%@", urlString);
        NSLog(@"请求参数：%@",params);
    }
    
    AFHTTPRequestOperation *operation = [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(self.isLog) {
//            NSLog(@"response string is %@", operation.responseString);
            NSLog(@"请求成功:%@", responseObject);
        }
        
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(self.isLog){
            NSLog(@"请求失败: %@", error);
        }
        
        failure(operation, error);
    }];
}

#pragma mark - 请求路径进行区分

- (void)POSTDefaultWithURLString:(NSString *)urlString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",basicURLString, urlString];
    
    [self POSTWithURLString:urlStr parameters:parameters success:success failure:failure];
}

- (void)POSTWithURLString:(NSString *)urlString
               parameters:(id)parameters
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = time_out_interval;

    NSDictionary *params = [self constructParamsWithParams:parameters basicParams:[self basicParams]];
    
    if(self.isLog) {
        NSLog(@"POST请求，请求URL：%@", urlString);
        NSLog(@"请求参数：%@",params);
    }
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * operation, id responseObject){
        if(self.isLog) {
            NSLog(@"请求成功:%@",operation.responseString);
        }
        
        success(operation,responseObject);
        
//        if([responseObject isKindOfClass:[NSData class]]){
//            NSDictionary * content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            success(operation,content);
//        } else {
//            success(operation,responseObject);
//        }
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        if(self.isLog){
            NSLog(@"请求失败: %@", error);
        }
        
        failure(operation, error);
    }];
}

- (void)uploadImageURLString:(NSString *)urlString
                        data:(NSData *)fileData
                  parameters:(id)parameters
               progressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progressBlock
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = time_out_interval;
    
    AFHTTPRequestOperation *operation = [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        // Append Image Data
        [formData appendPartWithFileData:fileData name:@"image" fileName:fileName mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject)  {
        if(self.isLog){
            NSLog(@"请求成功 : \n responseString : %@\n responseObject : %@", operation.responseString, responseObject);
        }
        
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(self.isLog){
            NSLog(@"请求失败: %@", error);
        }
        
        failure(operation, error);
    }];
    
    
    [operation setUploadProgressBlock:progressBlock];
}

- (void)GETDefaultWithURLString:(NSString *)urlString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",basicURLString, urlString];
    
    [self GETWithURLString:urlStr parameters:parameters success:success failure:failure];
}

- (void)GETWithURLString:(NSString *)urlString
              parameters:(id)parameters
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = time_out_interval;
    
    [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(self.isLog){
            NSLog(@"请求成功:%@",operation.responseString);
        }
        
        success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(self.isLog){
            NSLog(@"请求失败: %@", error);
        }
        
        failure(operation, error);
    }];
}

#pragma mark - Basic Parameters Construction

- (NSDictionary *)basicParams
{
    NSDictionary *params = @{
                             
                             };
    return params;
}

#pragma mark - Tools

- (NSDictionary *)constructParamsWithParams:(NSDictionary *)requestParams
                                basicParams:(NSDictionary *)basicParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:basicParams];
    for (NSString *key in requestParams.allKeys) {
        params[key] = requestParams[key];
    }
    
    return params;
}

- (NSDictionary *)constructParamsWithCommand:(NSString *)command
                                      params:(NSDictionary *)requestParams
                                basicParams:(NSDictionary *)basicParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:basicParams];
    for (NSString *key in requestParams.allKeys) {
        params[key] = requestParams[key];
    }
    [params setObject:command forKey:kCommandName];
    
    return params;
}

@end
