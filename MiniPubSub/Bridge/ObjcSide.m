//
//  ObjcSide.m
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

#import <Foundation/Foundation.h>
#import "ObjcSide.h"

@implementation ObjcSide : NSObject
+ (instancetype)sharedInstance{
    static ObjcSide *shard = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shard = [[ObjcSide alloc] init];
    });
    return shard;
}

- (void)initializeWith:(NativeMessageCallback) messageCallback{
    gameRelay = [[GameRelay alloc] initWithCallback:self];
    self->messageCallback = messageCallback;
}

- (void)sendToNativeWithInfo:(const char *)infoCStr AndData:(const char *)dataCStr {
    NSString *messageInfo = [[NSString alloc] initWithUTF8String:infoCStr];
    NSString *messageJson = [[NSString alloc] initWithUTF8String:dataCStr];
    [gameRelay sendWithInfo:messageInfo data:messageJson];
}

- (void)fromSwiftWithInfo:(NSString * _Nonnull)infoStr data:(NSString * _Nonnull)dataStr {
    self->messageCallback([infoStr UTF8String], [dataStr UTF8String]);
}

@end
