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
typedef void (*NativeBytesCallback)(const Byte* data, int length);
typedef void (*NativeStringCallback)(const char* str);

@class GameRelay;
@protocol SwiftCallback;

@interface ObjcSide : NSObject<SwiftCallback>
{
    NativeBytesCallback dataCallback;
    NativeStringCallback stringCallback;
    GameRelay* gameRelay;
}

+(instancetype) sharedInstance;

-(void) initializeWithStringCallback:(NativeStringCallback) stringCallback;
-(void) initializeWith : (NativeBytesCallback) bridgeCallback;
-(void) sendToNative : (const Byte*) data withLength:(int) length;
-(void) sendToNativeWithString: (const char*) cString;
@end

#endif /* ObjcSide_h */
