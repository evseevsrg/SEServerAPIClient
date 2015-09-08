//
//  SEServerAPIRPCService.m
//  SEServerAPIClient
//
//  Created by Sergey Evseev on 19/05/15.
//  Copyright (c) 2015 Sergey Evseev. All rights reserved.
//

#import <AFNetworking.h>
#import "SEServerAPIRPCService.h"
#import "SEServerAPICredentialManager.h"
#import "SEServerAPIConstants.h"


@interface SEServerAPIRPCService () {
    
    SEServerAPICredentialManager *_certificateManager;
    
    NSOperationQueue *_getRequestQueue;
    NSOperationQueue *_postRequestQueue;
}

@end


@implementation SEServerAPIRPCService

- (instancetype)init {
    if (self = [super init]) {
        _getRequestQueue = [[NSOperationQueue alloc] init];
        _postRequestQueue = [[NSOperationQueue alloc] init];
        
        _certificateManager = [[SEServerAPICredentialManager alloc] init];
    }
    
    return self;
}


- (NSNumber *)performRequest:(SEServerAPIRequest *)urlRequest
                 success:(void(^)(NSString *requestURL, NSString *jsonString))success
                 failure:(void(^)(NSString *requestURL, NSError *error)) failure {
    
    AFHTTPRequestOperation *operation = [self getRequestOperationWithURLRequest:urlRequest.request];
    dispatch_queue_t responseQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    [self setCompletionBlocksForOperation:operation
                              withRequest:urlRequest
                                  success:success
                                  failure:failure
                            dispatchQueue:responseQueue];
    
    [_getRequestQueue addOperation:operation];
    
    return @(operation.hash);
}

- (void)cancelGetOperations {
    [_getRequestQueue cancelAllOperations];
}

- (void)cancelPostOperations {
    [_postRequestQueue cancelAllOperations];
}

- (void)cancellAllOperations {
    [self cancelGetOperations];
    [self cancelPostOperations];
}

- (void)cancelOperationByID:(NSNumber *)operationId {
    unsigned long opId = [operationId integerValue];
    
    for (NSOperation *operation in [_getRequestQueue operations]) {
        if ((operation.hash == opId) && (!operation.isCancelled)) {
            [operation cancel];
            return ;
        }
    }
    
    for (NSOperation *operation in [_postRequestQueue operations]) {
        if ((operation.hash == opId) && (!operation.isCancelled)) {
            [operation cancel];
            return ;
        }
    }
}


#pragma mark - private methods

- (void)setCompletionBlocksForOperation:(AFHTTPRequestOperation *)operation
                           withRequest:(SEServerAPIRequest *)urlRequest
                               success:(void(^)(NSString *requestURL, id JSON))successBock
                               failure:(void(^)(NSString *requestURL, NSError *error))failureBlock
                         dispatchQueue:(dispatch_queue_t)queue {
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (successBock && !operation.isCancelled) {
            dispatch_async(queue, ^{
                successBock([operation.request.URL absoluteString], responseObject);
            });
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failureBlock && !operation.isCancelled) {
            dispatch_async(queue, ^{
                failureBlock([operation.request.URL absoluteString], [NSError errorWithDomain:error.domain code:kServerProblemsError userInfo:error.userInfo]);
            });
        }
    }];
}

- (AFHTTPRequestOperation *)getRequestOperationWithURLRequest:(NSURLRequest *)request {
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    requestOperation.securityPolicy.allowInvalidCertificates = YES;
    
    NSMutableSet *acceptableContentTypesSet = [requestOperation.responseSerializer.acceptableContentTypes mutableCopy];
    requestOperation.responseSerializer.acceptableContentTypes = acceptableContentTypesSet;
    
    AFSecurityPolicy *sec = [[AFSecurityPolicy alloc] init];
    [sec setAllowInvalidCertificates:YES];
    requestOperation.securityPolicy=sec;

    [requestOperation setWillSendRequestForAuthenticationChallengeBlock:^(NSURLConnection *connection, NSURLAuthenticationChallenge *challenge) {
        // manage auth issues with SEServerAPICredentialManager
        // [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    }];
    
    return requestOperation;
}

@end
