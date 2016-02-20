//
//  CAStudent.m
//  CampusAssistant
//
//  Created by JacobKong on 16/2/20.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

#import "CAStudent.h"
#import <objc/runtime.h>

@implementation CAStudent
#pragma mark - 归档解党
/**
 *  解档
 */
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        unsigned int count = 0;
        // 获取类中所有成员变量名
        Ivar *ivar = class_copyIvarList([CAStudent class], &count);
        for (int i = 0; i < count; i++) {
            Ivar iva = ivar[i];
            const char *name = ivar_getName(iva);
            NSString *strName = [NSString stringWithUTF8String:name];
            // 进行解档读值
            id value = [coder decodeObjectForKey:strName];
            // 利用KVC赋值
            [self setValue:value forKey:strName];
        }
        free(ivar);
    }
    return self;
}

/**
 *  归档
 */
- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count;
    Ivar *ivar = class_copyIvarList([CAStudent class], &count);
    for (int i=0; i<count; i++) {
        Ivar iv = ivar[i];
        const char *name = ivar_getName(iv);
        NSString *strName = [NSString stringWithUTF8String:name];
        //利用KVC取值
        id value = [self valueForKey:strName];
        [aCoder encodeObject:value forKey:strName];
    }
    free(ivar);
}

@end
