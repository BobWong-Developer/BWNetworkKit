//
//  BWAFNetworking.h
//  BWNetworkKit
//
//  Created by BobWong on 15/7/17.
//  Copyright (c) 2015年 Bob Wong Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWNetworkCenter.h"
@class AFHTTPRequestOperation;


#define BWAFNetworkingInstance [BWAFNetworking sharedInstance]


@interface BWAFNetworking : NSObject

/*
 * Data
 */
@property (nonatomic, assign) BOOL isLog;  //!< 是否打印日志


/**
 *  单例方法，创建网络请求框架的单例对象
 *
 *  @return 单例对象
 */
+ (BWAFNetworking *)sharedInstance;

#pragma mark - 请求Command字进行区分

/**
 * POST请求，默认路径，通过Command进行操作间的区分
 */
- (void)POSTDefaultWithCommand:(NSString *)command
                    parameters:(id)parameters
                       success:(void (^)(AFHTTPRequestOperation * operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation * operation, NSError * error))failure;

#pragma mark - 请求路径进行区分

/**
 *  POST请求，请求的URL上已有URL_BASE
 *
 *  @param urlString 基体的后缀URL文本
 *  @param parameters 请求参数
 *  @param success 成功后的处理
 *  @param failure 失败后的处理
 */
- (void)POSTDefaultWithURLString:(NSString *)urlString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation * operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation * operation, NSError * error))failure;

/**
 *  POST请求，urlString为全路径文本
 *
 *  @param urlString 请求URL文本
 *  @param parameters 请求参数
 *  @param success 成功后的处理
 *  @param failure 失败后的处理
 */
- (void)POSTWithURLString:(NSString *)urlString
               parameters:(id)parameters
                  success:(void (^)(AFHTTPRequestOperation * operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation * operation, NSError * error))failure;

/**
 *  GET请求，请求的URL上已有URL_BASE
 *
 *  @param urlString 基体的后缀URL文本
 *  @param parameters 请求参数
 *  @param success 成功后的处理
 *  @param failure 失败后的处理
 */
- (void)GETDefaultWithURLString:(NSString *)urlString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation * operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation * operation, NSError * error))failure;

/**
 *  GET请求，urlString为全路径文本
 *
 *  @param urlString URL文本
 *  @param parameters 请求参数
 *  @param success 成功后的处理
 *  @param failure 失败后的处理
 */
- (void)GETWithURLString:(NSString *)urlString
              parameters:(id)parameters
                 success:(void (^)(AFHTTPRequestOperation * operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation * operation, NSError * error))failure;

/**
 *  POST图像上传，urlString为全路径文本
 *
 *  @param urlString URL文本
 *  @param fileData 图像数据
 *  @param parameters 请求参数
 *  @param progressBlock 进度回调事件
 *  @param success 成功后的处理
 *  @param failure 失败后的处理
 */
- (void)uploadImageURLString:(NSString *)urlString
                        data:(NSData *)fileData
                  parameters:(id)parameters
               progressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progressBlock
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
