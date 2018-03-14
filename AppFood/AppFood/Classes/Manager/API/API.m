//
//  API.m
//  AppFood
//
//  Created by ThanhSon on 3/14/18.
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
    
    //ROUTE -> URL
    NSString *strURL;

    // For debug route
    route = [strURL substringFromIndex:server.length];
    
    
    // REQUEST
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:strURL];
    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    request.timeoutInterval = 30.0f;
    
    
    // METHOD
    //@[@"GET", @"POST", @"PUT", @"UPDATE", @"DELETE"]
    NSString *method;
    request.HTTPMethod = method;
    
    // HEADER
    NSMutableDictionary *allHeader = [[NSMutableDictionary alloc] init];
    [allHeader setObject:@"application/json" forKey:@"Content-Type"];
    if(headers) {
        [allHeader addEntriesFromDictionary:headers];
    }
    
    request.allHTTPHeaderFields = allHeader;
    
    // BODY (except GET)
    if(body) {
        id obj = body;
        if([obj isKindOfClass:[BaseDto class]]) {
            obj = [obj getJSONObjectWithMethod:methodType];
        }
        
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
                    if([content isKindOfClass:[NSDictionary class]]) {
                        NSString *token = [content objectForKey:@"token"];
                        if(token && [token isKindOfClass:[NSString class]] && [token length] > 5) {
                            NSInteger pfL = TK_RPREFIX.length;
                            NSInteger sfL = TK_RSUFFIX.length;
                            NSRange r = NSMakeRange(pfL, token.length-pfL-sfL);
                            token = [token substringWithRange:r];
                            token = SF(@"%@%@%@", TK_SPREFIX, token, TK_SSUFFIX);
                            NSLog(@"%@",token);
                            content = [content objectForKey:@"user"];
                            [content setObject:token forKey:@"token"];
                        }
                    }
                    if(cb) {
                        cb(YES, successClass ? [[successClass alloc] initWithData:content] : nil);
                        cb = NULL;
                        return;
                    }
                }
                
            } else {
                if ([respondData isKindOfClass:[NSDictionary class]]) {
                    cb = NULL;
                    return;
                }else{
                    NSLog(@"\nSERVER RETURN WRONG ERROR MESSAGE FORMAT!\n");
                }
            }
            
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
                        
                        successCallback(data);
                        return;
                    }
                }
            }else{
               
            }
            
            // Other Case, Failed
            errorCallback(error? error:response.description);
        });
    }];
    
    [task resume];
}

@end
