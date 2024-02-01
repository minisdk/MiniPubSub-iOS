//
//  Loader.m
//  SampleKit
//
//  Created by sangmin park on 1/31/24.
//

#import <Foundation/Foundation.h>
#import <SampleKit/SampleKit-Swift.h>

@interface OnModuleLoad : NSObject

@end

@implementation OnModuleLoad

+(void) load{
    [Loader loadModule];
}

@end
