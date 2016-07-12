//
//  OKCategoriesTests.m
//  OKCategoriesTests
//
//  Created by Herb on 16/7/8.
//  Copyright © 2016年 Herb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OKCategoties.h"

@interface OKCategoriesTests : XCTestCase

@end

@implementation OKCategoriesTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testArray {
    NSArray *array = @[@"1", @"2", @"3"];
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:array];
    
    id nilValue = nil;
}

@end
