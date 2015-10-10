//
//  SEServerAPIClientTest.m
//  SEServerAPIClient
//
//  Created by Evseev Sergey on 10/10/15.
//  Copyright © 2015 Sergey Evseev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "SEServerAPIRPCService.h"
#import "SEServerAPIClient.h"
#import "SEServerAPIRPCService.h"
#import "SEMapperWrapper.h"
#import "SECategories.h"
#import "SEAppConfig.h"
#import "SEServerAPIRPCServiceProtocol.h"
#import "SEServerAPIDataMapperProtocol.h"
#import "SEServerAPIConstants.h"

@interface SEServerAPIClientTest : XCTestCase

@property (nonatomic, assign) double responseTimeout;
@property (nonatomic, retain) NSDictionary *json;
@property (nonatomic, assign) Class mockedRPCService;
@property (nonatomic, assign) Class mockedDataMapper;
@property (nonatomic, assign) Class mockedAppConfig;

@end

@implementation SEServerAPIClientTest

- (void)setUp {
    [super setUp];
    
    self.responseTimeout = 2;
    self.mockedRPCService = [SEServerAPIRPCService class];
    self.mockedDataMapper = [SEMapperWrapper class];
    self.mockedAppConfig = [SEAppConfig class];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLoadCategoriesSuccessInvoked {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Task is longer than timeout"];
    
    id <SEServerAPIRPCServiceProtocol> rpcService = OCMClassMock(self.mockedRPCService);
    OCMStub([rpcService performRequest:[OCMArg any] success:[OCMArg any] failure:[OCMArg any]]).andDo(^(NSInvocation *invocation){
        
        void(^success)(NSString *requestURL, NSDictionary *JSON);
        [invocation getArgument:&success atIndex:3];
        success(nil, nil);
    });
    
    id <SEServerAPIDataMapperProtocol> dataMapper = OCMClassMock(self.mockedDataMapper);
    OCMStub([dataMapper parseJSON:[OCMArg any] withMappingScheme:[OCMArg any] success:[OCMArg any] failure:[OCMArg any]]).andDo(^(NSInvocation *invocation){
        
        void(^success)(id result);
        [invocation getArgument:&success atIndex:4];
        success(nil);
    });
    
    id <SEAppConfigProtocol> appConfig = OCMClassMock(self.mockedAppConfig);
    OCMStub([appConfig getProperty:kConfigCurrentLanguage]).andReturn(@"en");
    
    SEServerAPIClient *serverAPIClient = [SEServerAPIClient new];
    serverAPIClient.rpcService = rpcService;
    serverAPIClient.dataMapper = dataMapper;
    serverAPIClient.appConfig = appConfig;
    
    [serverAPIClient loadCategoriesWithAllLevels:YES success:^(BOOL success) {
        XCTAssertTrue(success);
        [expectation fulfill];
    } failure:^(NSError *error) {
        XCTFail();
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:self.responseTimeout handler:nil];
}


- (void)testLoadCategoriesFailInvokedIfNoRPCResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Task is longer than timeout"];
    
    id <SEServerAPIRPCServiceProtocol> rpcService = OCMClassMock(self.mockedRPCService);
    OCMStub([rpcService performRequest:[OCMArg any] success:[OCMArg any] failure:[OCMArg any]]).andDo(^(NSInvocation *invocation){
        
        void(^failure)(NSString *requestURL, NSError *error);
        [invocation getArgument:&failure atIndex:4];
        failure(nil, [NSError errorWithDomain:@"" code:0 userInfo:@{}]);
    });
    
    id <SEAppConfigProtocol> appConfig = OCMClassMock(self.mockedAppConfig);
    OCMStub([appConfig getProperty:kConfigCurrentLanguage]).andReturn(@"en");
    
    SEServerAPIClient *serverAPIClient = [SEServerAPIClient new];
    serverAPIClient.rpcService = rpcService;
    serverAPIClient.appConfig = appConfig;
    
    [serverAPIClient loadCategoriesWithAllLevels:YES success:^(BOOL success) {
        XCTFail();
        [expectation fulfill];
    } failure:^(NSError *error) {
        XCTAssertNotNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:self.responseTimeout handler:nil];
}

- (void)testLoadCategoriesFailInvokedIfMapperError {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Task is longer than timeout"];
    
    id <SEServerAPIRPCServiceProtocol> rpcService = OCMClassMock(self.mockedRPCService);
    OCMStub([rpcService performRequest:[OCMArg any] success:[OCMArg any] failure:[OCMArg any]]).andDo(^(NSInvocation *invocation){
        
        void(^success)(NSString *requestURL, NSDictionary *JSON);
        [invocation getArgument:&success atIndex:3];
        success(nil, nil);
    });
    
    id <SEServerAPIDataMapperProtocol> dataMapper = OCMClassMock(self.mockedDataMapper);
    OCMStub([dataMapper parseJSON:[OCMArg any] withMappingScheme:[OCMArg any] success:[OCMArg any] failure:[OCMArg any]]).andDo(^(NSInvocation *invocation){
        
        void(^failure)(NSError *error);
        [invocation getArgument:&failure atIndex:5];
        failure([NSError errorWithDomain:@"" code:0 userInfo:@{}]);
    });
    
    id <SEAppConfigProtocol> appConfig = OCMClassMock(self.mockedAppConfig);
    OCMStub([appConfig getProperty:kConfigCurrentLanguage]).andReturn(@"en");
    
    SEServerAPIClient *serverAPIClient = [SEServerAPIClient new];
    serverAPIClient.rpcService = rpcService;
    serverAPIClient.dataMapper = dataMapper;
    serverAPIClient.appConfig = appConfig;
    
    [serverAPIClient loadCategoriesWithAllLevels:YES success:^(BOOL success) {
        XCTFail();
        [expectation fulfill];
    } failure:^(NSError *error) {
        XCTAssertNotNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:self.responseTimeout handler:nil];
}

@end
