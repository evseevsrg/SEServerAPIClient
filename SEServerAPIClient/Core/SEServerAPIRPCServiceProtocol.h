//
//  SEServerAPIRPCServiceProtocol.h
//  SEServerAPIClient
//
//  Created by Sergey Evseev on 25/08/15.
//  Copyright (c) 2015 Sergey Evseev. All rights reserved.
//

@class SEServerAPIRequest;

@protocol SEServerAPIRPCServiceProtocol <NSObject>

- (NSNumber *)performRequest:(SEServerAPIRequest *)urlRequest success:(void(^)(NSString *requestURL, NSString *JSON))success failure:(void(^)(NSString *requestURL, NSError *error)) failure;

- (void)cancellAllOperations;
- (void)cancelGetOperations;
- (void)cancelPostOperations;
- (void)cancelOperationByID:(NSNumber *)operationId;

@end