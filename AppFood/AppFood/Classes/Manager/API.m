//
//  API.m
//  AppFood
//
//  Created by HHumorous on 3/14/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "API.h"

@interface _API ()
@property (nonatomic, assign) NSInteger _countRequest;
@end

@implementation _API

+ (_API *)shared {
    static _API *sharedAPI = nil;
    
    static dispatch_once_t t;
    dispatch_once(&t, ^{
        sharedAPI = [[_API alloc] init];
        sharedAPI._countRequest = 0;
    });
    
    return sharedAPI;
}

- (void)increaseCountRequest{
    __countRequest++;
}

- (void)descreaCountRequest{
    __countRequest--;
}

- (void) processAPI:(NSString*)route
          serverURL:(NSString*)server
             method:(NSInteger)methodType
             header:(NSDictionary*)headers
               body:(id)body
       successClass:(Class)successClass
           callback:(APICallback)callback {
    
    __block APICallback cb = NULL;
    if(callback) {
        cb = [callback copy];
    }
    
    //ROUTE
//    NSString *strURL;
//    if ([server isEqualToString:Config.server_Api]) {
//        //Server API
//        strURL = SF(@"%@/%@",Config.server_Api,route);
//    }else{
//        //Other server
//        strURL = SF(@"%@/%@",server,route);
//    }
    
    // For debug route
//    route = [strURL substringFromIndex:server.length];
    
    
    // REQUEST
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    request.URL = [NSURL URLWithString:strURL];
    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    request.timeoutInterval = 30.0f;
    
    
    // METHOD
//    NSArray *arrMethod = arrMethods;
//    //methodType = VALRANGE(methodType, 0, [arrMethod count]);
//    NSString *method = arrMethod[methodType%NUM_METHOD];
//    request.HTTPMethod = method;
//
//    // HEADER
//    NSMutableDictionary *allHeader = [[NSMutableDictionary alloc] init];
//    [allHeader setObject:@"application/json" forKey:@"Content-Type"];
//    [allHeader setObject:SECOND_TK_VALUE forKey:SECOND_TK_KEY];
//    if(headers) {
//        [allHeader addEntriesFromDictionary:headers];
//    }
    
    //    UserDto *user = Config.user;
    //    if( user && user.token) {
    //        NSLog(@"TOKEN = \n%@ \n", Config.keychain[@"token"]);
    //        [allHeader setObject:Config.keychain[@"token"] forKey:@"token"];
    //        [allHeader setObject:Config.user.companyId._id forKey:@"companyId"];
    //        [allHeader setObject:@"YES" forKey:@"mobile"];//Update api get content code (file > 25MB báo lỗi): thêm vào header {mobile : true} nếu là mobile
    //        //
    //    }
    
//    NSString *companyId = Config.keychain[@"companyId"];
//    NSString *token = Config.keychain[@"token"];
//    if (token.length > 0 && companyId.length > 0) {
//        [allHeader setObject:token forKey:@"token"];
//        [allHeader setObject:companyId forKey:@"companyId"];
//    }
//    //    else {
//    //        [App onReloginApp];
//    //    }
//
//    [allHeader setObject:@"true" forKey:@"mobile"];//Update api get content code (file > 25MB báo lỗi): thêm vào header {mobile : true} nếu là mobile
//
//    request.allHTTPHeaderFields = allHeader;
//
//    // BODY (except GET)
//    if(body) {
//        id obj = body;
//        if([obj isKindOfClass:[BaseDto class]]) {
//            obj = [obj getJSONObjectWithMethod:methodType];
//        }
    
        if([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]]) {
            NSMutableDictionary *dicBody = obj;
            NSData *dataBody = [NSJSONSerialization dataWithJSONObject:dicBody options:0 error:nil];
            request.HTTPBody = dataBody;
            
            NSString *json = dataBody?[[NSString alloc] initWithData:dataBody encoding:NSUTF8StringEncoding]:@"<null>";
            NSLog(@"[API] [%@] [%@] Data: %@", method, route, json);
            
        } else {
            if([obj isKindOfClass:[NSData class]]) {
                request.HTTPBody = obj;
                
            } else if([obj isKindOfClass:[NSString class]]) {
                request.HTTPBody = [obj dataUsingEncoding:NSUTF8StringEncoding];
            }
        }
        
    } else {
        NSLog(@"[API] [%@] [%@]", method, route);
    }
    
    void (^errorCallback)(id data) = ^(id data) {
        NSLog(@"[API] [%@] [%@] errorCallback Error: %@", method, route, E(data));
        
        if(cb) {
            cb(NO, data);
            cb = NULL;
        }
    };
    
    void (^successCallback)(id data) = ^(id data) {
        NSMutableDictionary *respondData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if(respondData) {
            
            // Print Track Log
            NSString *strLog = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"[API] [%@] [%@] SERVER RESPONSE: \n==>\n %@ \n\n<==\n\n", method, route, strLog);
            
            BOOL serviceSuccess = [[respondData objectForKey:@"success"] boolValue];
            if(serviceSuccess) {
                NSMutableDictionary *content = [respondData objectForKey:@"results"];
                if(content) {
                    if ([content isKindOfClass:[NSDictionary class]]) {
                        if (content.count > 1) {
                            if([content isKindOfClass:[NSDictionary class]]) {
                                NSString *token = [content objectForKey:@"token"];
                                if(token && [token isKindOfClass:[NSString class]] && [token length] > 5) {
                                    NSInteger pfL = TK_RPREFIX.length;
                                    NSInteger sfL = TK_RSUFFIX.length;
                                    NSRange r = NSMakeRange(pfL, token.length-pfL-sfL);
                                    token = [token substringWithRange:r];
                                    token = SF(@"%@%@%@", TK_SPREFIX, token, TK_SSUFFIX);
                                    //NSLog(@"%@",token);
                                    content = [content objectForKey:@"user"];
                                    [content setObject:token forKey:@"token"];
                                }
                            }
                        }
                    }
                    
                    if(cb) {
                        if(successClass == ListMySalaryDto.class) {
                            if([content isKindOfClass:[NSMutableArray class]]) {
                                [(NSMutableArray*)content addObject:strLog];
                            }
                        }
                        
                        cb(YES, successClass ? [[successClass alloc] initWithData:content] : nil);
                        cb = NULL;
                        return;
                    }
                }
                
            } else {
                
                if ([respondData isKindOfClass:[NSDictionary class]]) {
                    ErrorMessageDto *message = [[ErrorMessageDto alloc] initWithData:respondData];
                    
                    if (message.status == CODE_TOKEN_EXPIRED ||
                        message.status == CODE_USER_NOT_FOUND ||
                        message.status == CODE_IP_ACCESS ||
                        message.status == CODE_RELOGIN) {
                        
                        [Config.userDefaults setBool:NO forKey:@"login"];
                        [Config.userDefaults setObject:@"" forKey:@"tokenTemp"];
                        [Config.userDefaults synchronize];
                        
                        [App onReloginApp];
                    }
                    
                    [RMessage showNotificationWithTitle:@"Error"
                                               subtitle:message.message
                                                   type:RMessageTypeError
                                         customTypeName:nil
                                               duration:10.0
                                               callback:nil
                                   canBeDismissedByUser:YES];
                    
                    if (message.status == CODE_ESTATE_NOT_FOUND) {
                        // Fix for issues https://github.com/vantoan8x/Gito-Issues/issues/1817
                        EstateListVC *vc = VCFromSB(EstateListVC, SB_Estate);
                        Config.selectedMenu = HFMenu_Estate;
                        [App.mainVC.contentNV setViewControllers:@[vc] animated:NO];
                    }
                    
                    cb(NO, message);
                    cb = NULL;
                    return;
                    
                }else{
                    NSLog(@"\nSERVER RETURN WRONG ERROR MESSAGE FORMAT!\n");
                }
            }
            
        } else {
            // Server Error should Relogin
            [App onReloginApp];
        }
        
        // Other Case Error
        errorCallback(data);
    };
    
    [self increaseCountRequest];
    if (__countRequest > 0) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self descreaCountRequest];
            if (__countRequest == 0) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            }
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            
            if(!error && data) {
                
                if(httpResponse) {
                    NSInteger code = httpResponse.statusCode;
                    if(code == 200) {
                        
                        successCallback(data);
                        return;
                    }
                }
            }else{
                
                if (error.code == -CODE_DOMAIN) {
                    
                    [Config.userDefaults setBool:NO forKey:@"login"];
                    [Config.userDefaults setObject:@"" forKey:@"tokenTemp"];
                    [Config.userDefaults synchronize];
                    
                    [App onReloginApp];
                    
                }else{
                    [RMessage showNotificationWithTitle:@"Error"
                                               subtitle:error.localizedDescription
                                                   type:RMessageTypeError
                                         customTypeName:nil
                                               duration:10.0
                                               callback:nil
                                   canBeDismissedByUser:YES];
                }
            }
            
            // Other Case, Failed
            errorCallback(error? error:response.description);
        });
    }];
    
    [task resume];
}

#pragma mark FileItem - AttachFile
- (void) processAPIFileItem:(NSString*)route
                  serverURL:(NSString*)server
                     method:(NSInteger)methodType
                     header:(NSDictionary*)headers
                       body:(id)body
               successClass:(Class)successClass
                   callback:(APICallback)callback {
    
    __block APICallback cb = NULL;
    if(callback) {
        cb = [callback copy];
    }
    
    //ROUTE
    NSString *strURL;
    if ([server isEqualToString:Config.server_File]) {
        //Server FileItem
        strURL = SF(@"%@/%@",Config.server_File,route);
    }else{
        //Other server
        strURL = SF(@"%@/%@",server,route);
    }
    
    // For debug route
    route = [strURL substringFromIndex:server.length];
    
    
    // REQUEST
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:strURL];
    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    request.timeoutInterval = 30.0f;
    
    
    // METHOD
    NSArray *arrMethod = arrMethods;
    //methodType = VALRANGE(methodType, 0, [arrMethod count]);
    NSString *method = arrMethod[methodType%NUM_METHOD];
    request.HTTPMethod = method;
    
    NSMutableDictionary *allHeader = [[NSMutableDictionary alloc] init];
    [allHeader setObject:@"application/x-rar-compressed" forKey:@"Content-Type"];
    [allHeader setObject:SECOND_TK_VALUE forKey:SECOND_TK_KEY];
    
    if(headers) {
        [allHeader addEntriesFromDictionary:headers];
    }
    
    if (Config.keychain[@"token"].length > 0 && Config.keychain[@"companyId"].length > 0 ) {
        //NSLog(@"TOKEN = \n%@ \n", Config.keychain[@"token"]);
        [allHeader setObject:Config.keychain[@"token"] forKey:@"token"];
        [allHeader setObject:Config.keychain[@"companyId"] forKey:@"companyId"];
        [allHeader setObject:@"YES" forKey:@"mobile"];//Update api get content code (file > 25MB báo lỗi): thêm vào header {mobile : true} nếu là mobile
    } else {
        [App onReloginApp];
    }
    
    request.allHTTPHeaderFields = allHeader;
    
    // BODY (except GET)
    NSLog(@"[API] [%@] [%@]", method, route);
    
    void (^errorCallback)(id data) = ^(id data) {
        NSLog(@"[API] [%@] [%@] Error: %@", method, route, E(data));
        
        if(cb) {
            cb(NO, data);
            cb = NULL;
        }
    };
    
    void (^successCallback)(id data) = ^(id data) {
        if(cb) {
            cb(YES, data);
            cb = NULL;
            return;
        }
    };
    
    [self increaseCountRequest];
    if (__countRequest > 0) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self descreaCountRequest];
            if (__countRequest == 0) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            }
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            if(!error && data) {
                if(httpResponse) {
                    NSInteger code = httpResponse.statusCode;
                    if(code == 200) {
                        AttachFileDto *file = body;
                        file.fileContent = data;
                        successCallback(file);
                        return;
                    }
                }
            }else{
                
                if (error.code == -CODE_DOMAIN) {
                    
                    [Config.userDefaults setBool:NO forKey:@"login"];
                    [Config.userDefaults setObject:@"" forKey:@"tokenTemp"];
                    [Config.userDefaults synchronize];
                    [App onReloginApp];
                    
                }else{
                    
                    [RMessage showNotificationWithTitle:@"Error"
                                               subtitle:error.localizedDescription
                                                   type:RMessageTypeError
                                         customTypeName:nil
                                               duration:10
                                               callback:nil
                                   canBeDismissedByUser:YES];
                }
            }
            
            // Other Case, Failed
            errorCallback(error);
        });
    }];
    
    [task resume];
}


- (void) processAPI:(NSString*)route
             method:(NSInteger)methodType
             header:(NSDictionary*)headers
               body:(id)body
       successClass:(Class)successClass
           callback:(APICallback)callback {
    
    [self processAPI:route serverURL:Config.server_Api method:methodType header:headers body:body successClass:successClass callback:callback];
}
@end
