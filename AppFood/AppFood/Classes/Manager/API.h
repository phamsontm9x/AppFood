//
//  API.h
//  AppFood
//
//  Created by HHumorous on 3/14/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface API : NSObject

typedef void (^APICallback)(BOOL success, id data);

@end
@interface _API : NSObject

+ (_API*) shared;

- (void) processAPI:(NSString*)route
          serverURL:(NSString*)server
             method:(NSInteger)methodType
             header:(NSDictionary*)headers
               body:(id)body
       successClass:(Class)successClass
           callback:(APICallback)callback;
- (void) processAPI:(NSString*)route
             method:(NSInteger)methodType
             header:(NSDictionary*)headers
               body:(id)body
       successClass:(Class)successClass
           callback:(APICallback)callback;

- (void) processAPIFileItem:(NSString*)route
                  serverURL:(NSString*)server
                     method:(NSInteger)methodType
                     header:(NSDictionary*)headers
                       body:(id)body
               successClass:(Class)successClass
                   callback:(APICallback)callback;

@end
