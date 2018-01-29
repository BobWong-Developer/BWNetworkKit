//
//  ViewController.m
//  BWNetworkKit
//
//  Created by BobWong on 2017/2/15.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "BWYTKLoginApi.h"

#define TEST_URL_STRING @"http://localhost:8081/account/login"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)urlSessionAction:(id)sender {
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:TEST_URL_STRING];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    
    //5.设置请求体
    request.HTTPBody = [[self class] bodyData];
    
    NSLog(@"header: %@", request.allHTTPHeaderFields);
    
    //6.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) return;
        
        //8.解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dict);
        
    }];
    
    //7.执行任务
    [dataTask resume];
}

- (IBAction)afnetworkingAction:(id)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //最大请求并发任务数
    manager.operationQueue.maxConcurrentOperationCount = 5;
    
    // 请求格式
    // AFHTTPRequestSerializer            二进制格式
    // AFJSONRequestSerializer            JSON
    // AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传普通格式
    
    // 超时时间
    manager.requestSerializer.timeoutInterval = 30.0f;
    // 设置请求头
//    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    // 设置接收的Content-Type
//    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
    
    // 返回格式
    // AFHTTPResponseSerializer           二进制格式
    // AFJSONResponseSerializer           JSON
    // AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
    // AFXMLDocumentResponseSerializer (Mac OS X)
    // AFPropertyListResponseSerializer   PList
    // AFImageResponseSerializer          Image
    // AFCompoundResponseSerializer       组合
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回格式 JSON
    
    NSDictionary *params = @{@"account": @"bob",
                             @"password": @"123"};
    [manager POST:TEST_URL_STRING parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"response object:\n%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
    }];
}

- (IBAction)ytknetworkAction:(id)sender {
    BWYTKLoginApi *loginApi = [[BWYTKLoginApi alloc] initWithAccount:@"bob" password:@"123"];
    [loginApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *responseObject = request.responseObject;
        NSLog(@"response object: %@", responseObject);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"failure: %@", request.error);
    }];
}

+ (NSData *)bodyData {
    NSDictionary *bodyDict = @{@"account": @"bob",
                               @"password": @"123"};
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:bodyDict options:NSJSONWritingPrettyPrinted error:nil];
    return bodyData;
}

@end
