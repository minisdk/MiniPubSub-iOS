//
//  SampleKitLoader.m
//  sample
//
//  Created by sangmin park on 12/26/24.
//

#import <Foundation/Foundation.h>
#import "SampleKitLoader.h"
#import "Sample/sample-Swift.h"


@implementation SampleKitLoader
-(id<ModuleBase>) mount{
    id<ModuleBase> module = [[SampleKit alloc] init];
    return module;
}
@end
