//
//  NSFileManager+Music.h
//  Example
//
//  Created by zhuruhong on 16/7/23.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Music)

+ (NSString *)rh_pathWithFilePath:(NSString *)filepath;
+ (NSString *)rh_directoryInUserDomain:(NSSearchPathDirectory)directory;
+ (NSString *)rh_cacheDirectory;
+ (NSString *)rh_documentDirectory;

@end
