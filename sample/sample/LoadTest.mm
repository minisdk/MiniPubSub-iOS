//
//  LoadTest.m
//  sample
//
//  Created by sangmin park on 12/26/24.
//

#import <Foundation/Foundation.h>
#import "SampleKitLoader.h"

extern "C"{
    void loadTest(){
        [[[SampleKitLoader alloc] init] loadModule];
    }
}
