//
//  SEMapperWrapperTest.m
//  SEServerAPIClient
//
//  Created by Evseev Sergey on 10/10/15.
//  Copyright © 2015 Sergey Evseev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SECategories.h"
#import "SEMapperWrapper.h"
#import "SEServerAPIDataMapperProtocol.h"

@interface SEMapperWrapperTest : XCTestCase

@property (nonatomic, retain) id <SEServerAPIDataMapperProtocol> dataMapper;
@property (nonatomic, assign) double responseTimeout;

@end

@implementation SEMapperWrapperTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.dataMapper = [SEMapperWrapper new];
    self.responseTimeout = 2;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSuccessBlockInvokes {
    NSDictionary *data = @{@"result": @"OK", @"data": @[@{ @"id_catalog_category": @(3541), @"name": @"Special Promotion 2015", @"url_key": @"special-promotion" }], @"error": @""};
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Task is longer than timeout"];
    [self.dataMapper parseJSON:data withMappingScheme:NSStringFromClass([SECategories class]) success:^(id result) {
        XCTAssertNotNil(result);
        [expectation fulfill];
    } failure:^(NSError *error) {
        XCTFail();
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:self.responseTimeout handler:nil];
}


- (void)testFailureBlockInvokes {
    NSDictionary *data = @{@"result": @"ERROR", @"data": @"Language not found", @"error": @"LANGUAGE_NOT_FOUND"};
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Task is longer than timeout"];
    [self.dataMapper parseJSON:data withMappingScheme:NSStringFromClass([SECategories class]) success:^(id result) {
        XCTFail();
        [expectation fulfill];
    } failure:^(NSError *error) {
        XCTAssertNotNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:self.responseTimeout handler:nil];
}


- (void)testFailureBlockInvokesWithNoData {
    NSDictionary *data = @{@"result": @"OK", @"data": @"", @"error": @""};
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Task is longer than timeout"];
    [self.dataMapper parseJSON:data withMappingScheme:NSStringFromClass([SECategories class]) success:^(id result) {
        XCTFail();
        [expectation fulfill];
    } failure:^(NSError *error) {
        XCTAssertNotNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:self.responseTimeout handler:nil];
}

@end
