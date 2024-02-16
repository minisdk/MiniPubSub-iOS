//
//  ObjcSide.h
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

#ifndef ObjcSide_h
#define ObjcSide_h

#import <Foundation/Foundation.h>

//typedef void (*NativeMessageCallback)(const char* data);
typedef void (*NativeDataCallback)(const Byte* data, int length);

@class Game;
@protocol SwiftCallback;

@interface ObjcSide : NSObject<SwiftCallback>
{
    NativeDataCallback dataCallback;
    Game* game;
}

+(instancetype) sharedInstance;

-(void) initializeWith : (NativeDataCallback) bridgeCallback;
-(void) sendToNative : (const Byte*) data withLength:(int) length;
@end

#endif /* ObjcSide_h */
