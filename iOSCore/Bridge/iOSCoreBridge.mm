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
    void __iOSInitialize(NativeDataCallback unityCallback)
    {
        [[ObjcSide sharedInstance] initializeWith:unityCallback];
    }

    void __iOSSend(const Byte* bytes, int length)
    {
        [[ObjcSide sharedInstance] sendToNative:bytes withLength:length];
    }
}
