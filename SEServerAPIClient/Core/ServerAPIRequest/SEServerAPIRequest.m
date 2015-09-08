//
//  SEServerAPIRequest.m
//  SEServerAPIClient
//
//  Created by Sergey Evseev on 19/05/15.
//  Copyright (c) 2015 Sergey Evseev. All rights reserved.
//

#import "SEServerAPIRequest.h"
#import <AFNetworking.h>


@implementation SEServerAPIRequest

- (instancetype)initGetRequestWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters andMappingScheme:(NSString *)scheme {
    if (self = [super init]) {
        [self setURLString:urlString parameters:parameters mappingScheme:scheme andRequestType:@"GET"];
    }
    
    return self;
}

- (instancetype)initPostRequestWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters andModelName:(NSString *)scheme {
    if (self = [super init]) {
        [self setURLString:urlString parameters:parameters mappingScheme:scheme andRequestType:@"POST"];
    }
    
    return self;
}

- (void)setServerAPIToken:(NSString *)serverAPIToken {
    if (!self.request || !serverAPIToken || [serverAPIToken isEqualToString:@""]) {
        return ;
    }
    [self.request setValue:serverAPIToken forHTTPHeaderField:@"X-API-TOKEN"];
}

#pragma mark - private methods

- (void)setURLString:(NSString *)urlString parameters:(NSDictionary *)parameters
       mappingScheme:(NSString *)scheme
      andRequestType:(NSString *)requestType {
    if (scheme) {
        _scheme = scheme;
    }
    
    if (requestType) {
        _method = requestType;
    }
    
    if (urlString) {
        self.request = [[AFHTTPRequestSerializer serializer] requestWithMethod:requestType URLString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters error:nil];
        
        // add special headers for request
        
    } else {
        NSLog(@"nil URL passed");
    }
}

@end
