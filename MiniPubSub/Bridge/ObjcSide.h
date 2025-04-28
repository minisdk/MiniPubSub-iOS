//
//  ObjcSide.h
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

#ifndef ObjcSide_h
#define ObjcSide_h

#import <Foundation/Foundation.h>
#import <MiniPubSub/MiniPubSub-Swift.h>

typedef void (*NativeMessageCallback)(const char* infoCStr, const char* dataCStr);

@protocol SwiftCallback;
@class GameRelay;

@interface ObjcSide : NSObject<SwiftCallback>
{
    NativeMessageCallback messageCallback;
    GameRelay* gameRelay;
}

+(instancetype) sharedInstance;

-(void) initializeWith: (NativeMessageCallback) messageCallback;
-(void) sendToNativeWithInfo: (const char*) infoCStr andData: (const char*) dataCStr;
-(const char*) sendSyncToNativeWithInfo: (const char*) infoCStr andData: (const char*) dataCStr;
-(void) freeCString: (const char*) ptr;

@end

#endif /* ObjcSide_h */
