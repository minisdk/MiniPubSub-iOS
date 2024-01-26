//
//  iOSCoreBridge.m
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

#import <Foundation/Foundation.h>
#import "ObjcSide.h"

extern "C"
{
    void __iOSInitialize(NativeMessageCallback unityCallback)
    {
        [[ObjcSide sharedInstance] initializeWith:unityCallback];
    }

    void __iOSSend(const char* message, int nonce)
    {
        [[ObjcSide sharedInstance] sendToNative:[NSString stringWithUTF8String:message]];
    }
}
