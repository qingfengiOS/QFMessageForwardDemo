//
//  QFOtherPerson.m
//  QFMessageForwardDemo
//
//  Created by iosyf-02 on 2018/3/20.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "QFOtherPerson.h"

@implementation QFOtherPerson

- (void)run:(NSString *)name age:(NSInteger)age{
    NSLog(@"%@ 执行了 run name = %@,age = %ld",NSStringFromClass([self class]), name,age);
}

@end
