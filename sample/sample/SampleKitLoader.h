//
//  SampleKitLoader.h
//  sample
//
//  Created by sangmin park on 12/26/24.
//

#ifndef SampleKitLoader_h
#define SampleKitLoader_h

#import <Foundation/Foundation.h>
#import <MiniPubSub/ModuleLoader.h>
#import <MiniPubSub/MiniPubSub-swift.h>

@interface SampleKitLoader : ModuleLoader
-(id<ModuleBase>) mount;
@end


#endif /* SampleKitLoader_h */
