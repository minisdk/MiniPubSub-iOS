//
//  ModuleLoader.h
//  MiniPubSub
//
//  Created by sangmin park on 12/26/24.
//

#ifndef ModuleLoader_h
#define ModuleLoader_h

#import <Foundation/Foundation.h>
#import <MiniPubSub/MiniPubSub-Swift.h>

@interface ModuleLoader : NSObject
-(id<ModuleBase>) mount;
-(const char*) loadModule;
+(void) unloadModuleOf: (const char*) name;
@end

#endif /* ModuleLoader_h */
