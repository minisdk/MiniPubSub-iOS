//
//  ObjcSide.h
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

#ifndef ObjcSide_h
#define ObjcSide_h

#import <Foundation/Foundation.h>

typedef void (*NativeMessageCallback)(const char* data);

@class Game;
@protocol SwiftCallback;

@interface ObjcSide : NSObject<SwiftCallback>
{
    NativeMessageCallback messageCallback;
    Game* swiftSide;
}

+(instancetype) sharedInstance;

-(void) initializeWith : (NativeMessageCallback) bridgeCallback;
-(void) sendToNative : (NSString*) data;
//-(void) sendToGame : (NSString*) data;
@end

#endif /* ObjcSide_h */
