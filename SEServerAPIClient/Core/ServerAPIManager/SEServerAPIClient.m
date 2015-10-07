//
//  SEServerAPIManager.m
//  SEServerAPIClient
//
//  Created by Sergey Evseev on 19/05/15.
//  Copyright (c) 2015 Sergey Evseev. All rights reserved.
//

#import "SEServerAPIClient.h"
#import "SEServerAPIRPCService.h"
#import "SEServerAPIConstants.h"


@implementation SEServerAPIClient



- (NSNumber *)loadCategoriesWithAllLevels:(BOOL)allLevels success:(void(^)(BOOL success))success failure:(void(^)(NSError *error))failure {
    NSString *urlString = [self getUrlStringWithPath:kServerAPICategoriesURL andVersion:1];
    NSString *currentTwoLettersLanguage = [self.appConfig getProperty:kConfigCurrentLanguage];
    NSDictionary *params = @{@"lang": currentTwoLettersLanguage, @"full": allLevels?@"true":@"false"};
    
    SEServerAPIRequest *urlRequest = [[SEServerAPIRequest alloc] initGetRequestWithURLString:urlString parameters:params andMappingScheme:@"SECategories"];
    
    NSNumber *operationId = [self.rpcService performRequest:urlRequest success:^(NSString *requestURL, id responseObject) {
        [self.dataMapper parseJSON:responseObject withMappingScheme:urlRequest.scheme success:^(id result) {
            NSLog(@"%s categories JSON parsed successfully", __PRETTY_FUNCTION__);
            if (success) {
                success(YES);
            }
        } failure:^(NSError *error) {
            NSLog(@"%s error parsing categories JSON: %@", __PRETTY_FUNCTION__, error.description);
            if (failure) {
                failure(error);
            }
        }];
    } failure:^(NSString *requestURL, NSError *error) {
        NSLog(@"%s url: %@ description:%@", __PRETTY_FUNCTION__, requestURL, error.description);
        if (failure) {
            failure(error);
        }
    }];
    
    return operationId;
}



- (NSString *)getUrlStringWithPath:(NSString *)url andVersion:(NSUInteger)version {
    if (!url || [url isEqualToString:@""]) {
        return @"";
    }
    
    if (!version) {
        version = 1;
    }
    
    NSString *baseURL = [self.appConfig getProperty:kConfigBaseAPIURL];
    return [NSString stringWithFormat:@"%@%@v%lu/", baseURL, url, (unsigned long)version];
}


@end
