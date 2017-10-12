 //
//  HttpTool.m
//  05-二次封装AFN
//
//  Created by 大欢 on 16/8/4.
//  Copyright © 2016年 大欢. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#include <netinet/in.h>
#import "NetWorkStatus.h"

static NSString * kBaseUrl = UD_URL_HOME;

@interface AFHttpClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

@implementation AFHttpClient

+ (void)initialize{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (instancetype)sharedClient {
    
    static AFHttpClient * client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        client = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl] sessionConfiguration:configuration];
        //接收参数类型
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        //设置超时时间
        client.requestSerializer.timeoutInterval = 60;
//        //安全策略
//        client.securityPolicy = [AFSecurityPolicy defaultPolicy];
    });
    
    return client;
}

@end

@implementation HttpTool

#pragma mark - 网络请求前处理，无网络不请求
+(BOOL)requestBeforeCheckNetWorkWithFailureBlock:(failureBlocks)errorBlock{
    BOOL isFi=[NetWorkStatus isFi];
    if(!isFi){//无网络
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(errorBlock!=nil){
                errorBlock(nil);
                [SVProgressHUD showInfoWithStatus:@"网络不给力"];
            }
        });
    }else{//有网络
        [NetWorkStatus startNetworkActivity];
    }
    
    return isFi;
}

+ (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure {
    //获取完整的url路径
    NSString * url = [kBaseUrl stringByAppendingPathComponent:path];
    
    [[AFHttpClient sharedClient] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
         [SVProgressHUD showInfoWithStatus:@"网络错误,请稍后重试"];
    }];

}


/*没有弹框提示*/
+ (void)PostWithPath:(NSString *)path
              params:(NSDictionary *)dict
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure {
    
    if(![self requestBeforeCheckNetWorkWithFailureBlock:failure]){
        
        [SVProgressHUD dismiss];
        return;
    }

    //获取完整的url路径
    NSString * url = [kBaseUrl stringByAppendingPathComponent:path];
    
    if (dict) {
        //请求的参数
        dict=@{@"paramJson":[ZHStringFilterTool dictionaryToJson:dict]};
    }
    //清理cookie
    [HttpTool clearCookies];
    // 2.发送请求
    [[AFHttpClient sharedClient] POST:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        NSDictionary * responseDict=responseObject;
        
        if (!kDictIsEmpty(responseDict)) {
            
            NSInteger code =[[responseObject objectForKey:@"code"] integerValue];
            NSString * message=[responseObject objectForKey:@"message"];
            if (code==200) {
                
                success(responseObject);
                
            }else{
                
                [SVProgressHUD showInfoWithStatus:message];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        failure(error);
    }];
}

#pragma mark 清理cookie
+(void)clearCookies{

    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
}

+ (void)postWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure {
    
    if(![self requestBeforeCheckNetWorkWithFailureBlock:failure]){
        return;
    }
    
    [SVProgressHUD showWithStatus:@"玩命加载中..."];
    
    //设置提示框样式
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMinimumDismissTimeInterval:2.0f];
    //获取完整的url路径
    NSString * url = [kBaseUrl stringByAppendingPathComponent:path];
    
    //请求的参数
    if (params) {
        
        params=@{@"paramJson":[ZHStringFilterTool dictionaryToJson:params]};
    }
    
    //清理cookie
    [HttpTool clearCookies];
    // 2.发送请求
    [[AFHttpClient sharedClient] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        NSDictionary * responseDict=responseObject;
        NSLog(@"responseDict***%@",responseDict);
        if (!kDictIsEmpty(responseDict)) {
            
            if (success) {
                
                if ([responseObject[@"code"] isEqualToString:@"300"] || [responseObject[@"code"] isEqualToString:@"100"]) {
                    
                    [SVProgressHUD showInfoWithStatus:responseObject[@"message"]];
                } else {
                    
                    [SVProgressHUD dismiss];
                }
                
                success(responseObject);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        failure(error);
    }];
}

+ (void)downloadWithPath:(NSString *)path
                 success:(HttpSuccessBlock)success
                 failure:(HttpFailureBlock)failure
                progress:(HttpDownloadProgressBlock)progress {
    
    //获取完整的url路径
    NSString * urlString = [kBaseUrl stringByAppendingPathComponent:path];
    
    //下载
    NSURL *URL = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [[AFHttpClient sharedClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        progress(downloadProgress.fractionCompleted);
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        //获取沙盒cache路径
        NSURL * documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        if (error) {
            failure(error);
        } else {
            success(filePath.path);
        }
        
    }];
    
    [downloadTask resume];
    
}

+ (void)uploadImageWithPath:(NSString *)path
                     params:(NSDictionary *)params
                  thumbName:(NSString *)imagekey
                      image:(UIImage *)image
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure
                   progress:(HttpUploadProgressBlock)progress {
    
    //获取完整的url路径
    NSString * urlString = [kBaseUrl stringByAppendingPathComponent:path];
    
    NSData * data = UIImagePNGRepresentation(image);
    
    [[AFHttpClient sharedClient] POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:imagekey fileName:@"01.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

+(void)uploadImageArrWithPath:(NSString *)path
                     params:(NSDictionary *)params
                  thumbName:(NSArray *)imagekeys
                      image:(NSArray*)images
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure
                   progress:(HttpUploadProgressBlock)progress {
    
    if(![self requestBeforeCheckNetWorkWithFailureBlock:failure]){
        return;
    }
    
    [SVProgressHUD showWithStatus:@"玩命加载中..."];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    //获取完整的url路径
    NSString * urlString = [kBaseUrl stringByAppendingPathComponent:path];
    
    //请求的参数
    NSDictionary* param =@{@"paramJson":[ZHStringFilterTool dictionaryToJson:params]};

    [[AFHttpClient sharedClient] POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for(NSInteger i =0;i<images.count;i++){
            
            UIImage * upLoadImage=[images objectAtIndex:i];
            NSData * imageData=UIImageJPEGRepresentation(upLoadImage, 1.0);;
            
            //设置需要上传的文件
            [formData appendPartWithFileData:imageData name:@"imageFile" fileName:[imagekeys objectAtIndex:i] mimeType:@"image/jpg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        NSDictionary * responseDict=responseObject;
        
        if (!kDictIsEmpty(responseDict)) {
            
            NSInteger code =[[responseObject objectForKey:@"code"] integerValue];
            NSString * message=[responseObject objectForKey:@"message"];
            if (code==200) {
                
                [SVProgressHUD dismiss];
                
            }else{
                
                [SVProgressHUD showInfoWithStatus:message];
            }
            
            success(responseObject);
        }
                
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
          [SVProgressHUD dismiss];
          [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        failure(error);
        
    }];
}

//人脸识别接口
+ (void)postWithUrl:(NSString *)url
             params:(NSDictionary *)params
          imageData:(NSData *)imageData
           nodImage:(UIImage *)image
       imageNameArr:(NSArray *)imageNameArr
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure
{

    if(![self requestBeforeCheckNetWorkWithFailureBlock:failure]){
        return;
    }
    
    if (params) {
        // 4.字典转换为字符串
        NSString *str = [ZHStringFilterTool dictionaryToJson:params];
        // 5.转化为符合要求的字符串
        params = @{
                   @"paramJson" : str
                   };
    }
    [SVProgressHUD show];
    //     4.发送POST请求
    [[AFHttpClient sharedClient] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"imageFile" fileName:imageNameArr[0] mimeType:@"image/png"];
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 1.0) name:@"imageFile" fileName:imageNameArr[1] mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
         [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        
        if (success) {
            if ([responseObject[@"code"] isEqualToString:@"300"]) {
                
                [SVProgressHUD showInfoWithStatus:responseObject[@"message"]];
            }else {
                [SVProgressHUD dismiss];
            }
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        [SVProgressHUD showInfoWithStatus:@"请检查网络是否连接"];
    }];
}

@end
