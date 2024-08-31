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
    void __iOSInitializeWithString(NativeStringCallback stringCallback)
    {
        [[ObjcSide sharedInstance] initializeWithStringCallback:stringCallback];
    }

    void __iOSInitialize(NativeBytesCallback unityCallback)
    {
        [[ObjcSide sharedInstance] initializeWith:unityCallback];
    }

    void __iOSByteSend(const Byte* bytes, int length)
    {
        [[ObjcSide sharedInstance] sendToNative:bytes withLength:length];
    }

    void __iOSStringSend(const char* cString)
    {
        [[ObjcSide sharedInstance] sendToNativeWithString:cString];
    }
}
