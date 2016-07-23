//
//  NSString+Music.h
//  Example
//
//  Created by zhuruhong on 16/7/23.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Music)

+ (NSString *)rh_stringWithMD5Encode:(NSString *)src;
- (NSString *)rh_stringWithMD5Encode;

@end
