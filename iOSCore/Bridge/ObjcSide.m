//
//  ObjcSide.m
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

#import <Foundation/Foundation.h>
#import "ObjcSide.h"
#import <iOSCore/iOSCore-Swift.h>

@implementation ObjcSide : NSObject
+ (instancetype)sharedInstance{
    static ObjcSide *shard = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shard = [[ObjcSide alloc] init];
    });
    return shard;
}

- (void)initializeWith:(NativeMessageCallback)bridgeCallback {
    swiftSide = [[Game alloc] initWithCallback:self];
    
    self->messageCallback = bridgeCallback;
    self->messageCallback("ios native - init complete");
}
- (void)sendToNative:(NSString *)data{
    NSLog(@"from unity message : %@", data);
    [swiftSide sendWithData:data];
}

//- (void)sendToGame:(NSString *)data {
//    self->messageCallback([data UTF8String]);
//}

- (void)fromSwiftWithData:(NSString *)data{
    self->messageCallback([data UTF8String]);
}

@end
