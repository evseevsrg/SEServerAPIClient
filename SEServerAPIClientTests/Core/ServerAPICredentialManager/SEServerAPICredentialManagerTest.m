//
//  SEServerAPICredentialManagerTest.m
//  SEServerAPIClient
//
//  Created by Evseev Sergey on 10/10/15.
//  Copyright © 2015 Sergey Evseev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SEServerAPICredentialManager.h"

@interface SEServerAPICredentialManagerTest : XCTestCase

@end

@implementation SEServerAPICredentialManagerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetCredentialForCertificateBasedAuthenticationIsNotNil {
    SEServerAPICredentialManager *credentialManager = [SEServerAPICredentialManager new];
    
    NSURLCredential *credential = [credentialManager getCredentialForAuthMethod:nil];
    
    XCTAssertNotNil(credential);
}

@end
