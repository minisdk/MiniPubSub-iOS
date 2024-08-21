//
//  ObjcSide.m
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

#import <Foundation/Foundation.h>
#import "ObjcSide.h"
#import <iOSPubSub/iOSPubSub-Swift.h>

@implementation ObjcSide : NSObject
+ (instancetype)sharedInstance{
    static ObjcSide *shard = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shard = [[ObjcSide alloc] init];
    });
    return shard;
}

- (void)initializeWithStringCallback:(NativeStringCallback)stringCallback{
    gameRelay = [[GameRelay alloc] initWithCallback:self];
    self->stringCallback = stringCallback;
}

- (void)initializeWith:(NativeBytesCallback)bridgeCallback {
    gameRelay = [[GameRelay alloc] initWithCallback:self];
    
    self->dataCallback = bridgeCallback;
}

- (void)sendToNative:(const Byte *)data withLength:(int)length{
    NSData *nsData = [NSData dataWithBytes:data length:length];
    [gameRelay sendWithData:nsData];
}
- (void)sendToNativeWithString:(const char *)cString{
    NSString *messageString = [[NSString alloc] initWithUTF8String:cString];
    [gameRelay sendWithString:messageString];
}

- (void)fromSwiftWithData:(NSData *)data{
    self->dataCallback([data bytes], (int)data.length);
}

- (void)fromSwiftWithString:(NSString *)string{
    self->stringCallback([string UTF8String]);
}

@end
