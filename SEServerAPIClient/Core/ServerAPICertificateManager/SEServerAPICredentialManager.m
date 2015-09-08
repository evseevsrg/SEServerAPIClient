//
//  SEServerAPICredentialManager.m
//  SEServerAPIClient
//
//  Created by Sergey Evseev on 13/07/15.
//  Copyright (c) 2015 Sergey Evseev. All rights reserved.
//

#import "SEServerAPICredentialManager.h"
#import "SEServerAPIConstants.h"

@implementation SEServerAPICredentialManager

- (NSURLCredential *)getCredentialForAuthMethod:(NSString *)authMethod {
    // manage credential
    return [NSURLCredential new];
}

@end
