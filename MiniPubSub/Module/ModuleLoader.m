//
//  ModuleLoader.m
//  MiniPubSub
//
//  Created by sangmin park on 12/26/24.
//

#import <Foundation/Foundation.h>
#import "ModuleLoader.h"


@implementation ModuleLoader

- (id<ModuleBase>)mount {
    NSAssert(NO, @"load your module derived from ModuleBase");
    return nil;
}

- (const char *)loadModule {
    id<ModuleBase> module = [self mount];
    if(module == nil){
        return "";
    }
    
    NSString* moduleName = [module getName];
    [[ModuleManager shared] addWithName:moduleName module:module];
    
    return [moduleName UTF8String];
}

+ (void) unloadModuleOf:(const char *)name{
    if(name == nil){
        return;
    }
    NSString* moduleName = [NSString stringWithUTF8String:name];
    [[ModuleManager shared] removeWithName:moduleName];
}

@end
