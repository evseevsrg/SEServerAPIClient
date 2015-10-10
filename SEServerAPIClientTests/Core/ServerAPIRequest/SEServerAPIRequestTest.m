//
//  SEServerAPIRequestTest.m
//  SEServerAPIClient
//
//  Created by Evseev Sergey on 10/10/15.
//  Copyright © 2015 Sergey Evseev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SEServerAPIRequest.h"

@interface SEServerAPIRequestTest : XCTestCase

@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *mappingScheme;
@property (nonatomic, retain) NSString *lang;
@property (nonatomic, retain) SEServerAPIRequest *request;

@end

@implementation SEServerAPIRequestTest

- (void)setUp {
    [super setUp];
    
    self.url = @"http://google.com";
    self.mappingScheme = @"SECategories";
    self.lang = @"en";
    
    self.request = [[SEServerAPIRequest alloc] initGetRequestWithURLString:self.url parameters:@{@"lang": self.lang} andMappingScheme:self.mappingScheme];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitGETRequestIsNotNil {
    SEServerAPIRequest *request = [[SEServerAPIRequest alloc] initGetRequestWithURLString:self.url parameters:@{@"lang": self.lang} andMappingScheme:self.mappingScheme];
    XCTAssertNotNil(request);
}

- (void)testGETURLRequestIsNotNil {
    SEServerAPIRequest *request = [[SEServerAPIRequest alloc] initGetRequestWithURLString:self.url parameters:@{@"lang": self.lang} andMappingScheme:self.mappingScheme];
    NSMutableURLRequest *urlRequest = request.request;
    XCTAssertNotNil(urlRequest);
    XCTAssertTrue([urlRequest isKindOfClass:[NSMutableURLRequest class]]);
}

- (void)testRequestInitializedParameters {
    SEServerAPIRequest *request = [[SEServerAPIRequest alloc] initGetRequestWithURLString:self.url parameters:@{@"lang": self.lang} andMappingScheme:self.mappingScheme];
    XCTAssertEqualObjects(request.method, @"GET");
    XCTAssertEqualObjects(request.scheme, self.mappingScheme);
    XCTAssertFalse([request.request.URL.absoluteString rangeOfString:self.url].location == NSNotFound);
}

- (void)testGetParameters {
    NSDictionary *params = @{@"lang": self.lang};
    NSString *expectedURL = [NSString stringWithFormat:@"%@?%@=%@", self.url, params.allKeys.firstObject, params[params.allKeys.firstObject]];
    
    SEServerAPIRequest *request = [[SEServerAPIRequest alloc] initGetRequestWithURLString:self.url parameters:params andMappingScheme:self.mappingScheme];
    
    XCTAssertTrue([expectedURL isEqualToString:request.request.URL.absoluteString]);
}

- (void)testSetServerAPIToken {
    SEServerAPIRequest *request = [[SEServerAPIRequest alloc] initGetRequestWithURLString:self.url parameters:@{@"lang": self.lang} andMappingScheme:self.mappingScheme];
    NSString *token = @"token";
    [request setServerAPIToken:token];
    
    NSDictionary *headers = request.request.allHTTPHeaderFields;
    
    XCTAssertTrue([headers[@"X-API-TOKEN"] isEqualToString:token]);
}


@end
