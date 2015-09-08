//
//  SEServerAPICredentialManager.h
//  SEServerAPIClient
//
//  Created by Sergey Evseev on 13/07/15.
//  Copyright (c) 2015 Sergey Evseev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SEServerAPICredentialManager : NSObject

- (NSURLCredential *)getCredentialForAuthMethod:(NSString *)authMethod;

@end
