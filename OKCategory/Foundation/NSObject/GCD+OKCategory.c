//
//  GCD+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#include <stdio.h>
#include <assert.h>
#include <Block.h>

#include "GCD+OKCategory.h"

void dispatch_async_main(dispatch_block_t block) {
    dispatch_async(dispatch_get_main_queue(), block);
}

void dispatch_async_low(dispatch_block_t block) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), block);
}

void dispatch_async_default(dispatch_block_t block) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

void dispatch_async_high(dispatch_block_t block) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), block);
}

void dispatch_stride(size_t stride, size_t iterations, dispatch_queue_t queue, StrideBlock block) {
    
    assert(block);
    
    size_t strideCount = iterations / stride;
    
    // queue must be a concurrent queue!
    dispatch_apply(strideCount, queue, ^(size_t idx) {
        size_t i = idx * stride;
        size_t stop = i + stride;
        do {
            block(idx);
        } while (i < stop);
    });
    
    // Picks up any left over iterations.
    for (size_t i = iterations - (iterations % stride); i < iterations; i++)
        block(i);
}
