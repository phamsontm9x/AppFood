//
//  FileHelper.m
//  AppFood
//
//  Created by machnguyen_uit on 4/28/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "FileHelper.h"
#import "AppDelegate.h"

@implementation FileHelper

+ (void)saveFoodToFavorate:(DetailDishDto *)dto {
    ListDishDetailDto *arrData = [FileHelper getListFavorite];
    if (arrData.list == nil) {
        arrData.list = [[NSMutableArray alloc] init];
    }
    [arrData.list addObject:dto];
    [FileHelper witeDataToPath:[arrData getJSONObject] filePath:[FileHelper getFilePath:SF(@"%@_ListFavorite",Config.userDto._id)]];
}

+ (ListDishDetailDto*)getListFavorite {
    NSDictionary *dic = [FileHelper readDataFromPath:[FileHelper getFilePath:SF(@"%@_ListFavorite",Config.userDto._id)]];
    ListDishDetailDto *listData = [[ListDishDetailDto alloc] initWithData:dic];
    return listData;
}

+ (void)removeFavorite:(DetailDishDto*)dto {
    ListDishDetailDto *arrData = [FileHelper getListFavorite];
    if (arrData.list == nil) {
        arrData.list = [[NSMutableArray alloc] init];
    }
    
    for (DetailDishDto *item in arrData.list) {
        if ([item._id isEqualToString:dto._id]) {
            [arrData.list removeObject:item];
            break;
        }
    }
    
    [FileHelper witeDataToPath:[arrData getJSONObject] filePath:[FileHelper getFilePath:SF(@"%@_ListFavorite",Config.userDto._id)]];
}

+ (void)removeAllFavorite {
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:[FileHelper getFilePath:SF(@"%@_ListFavorite",Config.userDto._id)] error:&error];
    
    if (error) {
        NSLog(@"remove all favorite failed");
    }
}

+ (NSString*)getFilePath:(NSString*)nameFile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *folderPath =  [paths[0] stringByAppendingPathComponent:@"AppFood"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:folderPath]){
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *path = [folderPath stringByAppendingPathComponent:[NSString stringWithFormat:@"user_%@.json",nameFile]];
    NSLog(@"SAVA DATA TO PATH :%@",path);
    
    return path ;
}

+ (BOOL)createFolder:(NSString*)folderName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *arrPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSSystemDomainMask, YES);
    
    NSString *folderPath = [arrPath.firstObject stringByAppendingString:folderName];
    
    NSError *error;
    return [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:&error];
}

+ (void)witeDataToPath:(id)data filePath:(NSString*)filePath {
    dispatch_queue_t queue = dispatch_queue_create("hoangson_writeToFile", NULL);
    dispatch_async(queue, ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:filePath]) {
            NSError *error = nil;
            [fileManager removeItemAtPath:filePath error:&error];
            if (error != nil) {
                NSLog(@" error when remove batch : %@",error.description);
            }
        }
        NSData *dataWrite = [NSKeyedArchiver archivedDataWithRootObject:data];
        [dataWrite writeToFile:filePath atomically:YES];
    });
}

+ (id)readDataFromPath:(NSString*)path {
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    if (data != nil){
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return nil;
}


@end
