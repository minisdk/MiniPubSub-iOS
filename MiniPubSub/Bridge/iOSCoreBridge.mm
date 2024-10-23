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
    void __iOSInitialize(NativeMessageCallback messageCallback)
    {
        [[ObjcSide sharedInstance] initializeWith:messageCallback];
    }

    void __iOSStringSend(const char* cMessageInfo, const char* cJson)
    {
        [[ObjcSide sharedInstance] sendToNativeWithInfo:cMessageInfo AndData:cJson];
    }
}
