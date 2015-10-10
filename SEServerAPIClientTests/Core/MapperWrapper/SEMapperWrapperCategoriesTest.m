//
//  SEMapperWrapperCategoriesTest.m
//  SEServerAPIClient
//
//  Created by Evseev Sergey on 10/10/15.
//  Copyright © 2015 Sergey Evseev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SECategories.h"
#import "SEMapperWrapper.h"
#import "SEServerAPIDataMapperProtocol.h"

@interface SEMapperWrapperCategoriesTest : XCTestCase

@property (nonatomic, retain) id <SEServerAPIDataMapperProtocol> dataMapper;
@property (nonatomic, assign) double responseTimeout;

@end

@implementation SEMapperWrapperCategoriesTest

- (void)setUp {
    [super setUp];
    
    self.dataMapper = [SEMapperWrapper new];
    self.responseTimeout = 2;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testResultCountIsCorrect {
    NSDictionary *data = @{@"result": @"OK", @"data": @[@{ @"category_id": @(3541), @"name": @"Samsung", @"key": @"samsung" }, @{ @"category_id": @(3542), @"name": @"Apple", @"key": @"apple" }], @"error": @""};
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Task is longer than timeout"];
    [self.dataMapper parseJSON:data withMappingScheme:NSStringFromClass([SECategories class]) success:^(NSArray *result) {
        XCTAssertEqual(result.count, 2);
        [expectation fulfill];
    } failure:^(NSError *error) {
        XCTFail();
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:self.responseTimeout handler:nil];
}


- (void)testRusultClassIsCorrect {
    NSDictionary *data = @{@"result": @"OK", @"data": @[@{ @"category_id": @(3541), @"name": @"Samsung", @"key": @"samsung" }], @"error": @""};
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Task is longer than timeout"];
    [self.dataMapper parseJSON:data withMappingScheme:NSStringFromClass([SECategories class]) success:^(NSArray *result) {
        id item = [result firstObject];
        XCTAssertTrue([item isKindOfClass:[SECategories class]]);
        [expectation fulfill];
    } failure:^(NSError *error) {
        XCTFail();
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:self.responseTimeout handler:nil];
}


- (void)testAllFieldsAreMapped {
    NSDictionary *data = @{@"result": @"OK", @"data": @[@{ @"category_id": @(3541), @"name": @"Samsung", @"key": @"samsung" }], @"error": @""};
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Task is longer than timeout"];
    [self.dataMapper parseJSON:data withMappingScheme:NSStringFromClass([SECategories class]) success:^(NSArray *result) {
        SECategories *item = [result firstObject];
        XCTAssertEqual(item.categoryId, [[data[@"data"] firstObject][@"category_id"] intValue]);
        XCTAssertEqual(item.name, [data[@"data"] firstObject][@"name"]);
        XCTAssertEqual(item.key, [data[@"data"] firstObject][@"key"]);
        [expectation fulfill];
    } failure:^(NSError *error) {
        XCTFail();
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:self.responseTimeout handler:nil];
}


- (void)testChildrenCountIsCorrect {
    NSDictionary *data = @{@"result": @"OK", @"data": @[@{ @"category_id": @(3541), @"name": @"Samsung", @"key": @"samsung", @"children": @[@{ @"category_id": @(3542), @"name": @"HP", @"key": @"hp" }, @{ @"category_id": @(3543), @"name": @"Dell", @"key": @"dell" }]}], @"error": @""};
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Task is longer than timeout"];
    [self.dataMapper parseJSON:data withMappingScheme:NSStringFromClass([SECategories class]) success:^(NSArray *result) {
        NSUInteger childrenCount = [[result firstObject] children].count;
        XCTAssertEqual(childrenCount, 2);
        [expectation fulfill];
    } failure:^(NSError *error) {
        XCTFail();
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:self.responseTimeout handler:nil];
    
}


- (void)testChildrenClassIsCorrect {
    NSDictionary *data = @{@"result": @"OK", @"data": @[@{ @"category_id": @(3541), @"name": @"Samsung", @"key": @"samsung", @"children": @[@{ @"category_id": @(3542), @"name": @"Apple", @"key": @"apple" }, @{ @"category_id": @(3543), @"name": @"Dell", @"key": @"dell" }]}], @"error": @""};
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Task is longer than timeout"];
    [self.dataMapper parseJSON:data withMappingScheme:NSStringFromClass([SECategories class]) success:^(NSArray *result) {
        SECategories *item = [[[result firstObject] children] firstObject];
        XCTAssertTrue([item isKindOfClass:[SECategories class]]);
        [expectation fulfill];
    } failure:^(NSError *error) {
        XCTFail();
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:self.responseTimeout handler:nil];
    
}


@end
