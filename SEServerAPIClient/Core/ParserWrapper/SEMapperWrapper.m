//
//  SEParserWrapper.m
//  SEServerAPIClient
//
//  Created by Sergey Evseev on 25/08/15.
//  Copyright (c) 2015 Sergey Evseev. All rights reserved.
//

#import "SEMapperWrapper.h"
#import "SEServerAPIConstants.h"
#import "Mantle.h"

@implementation SEMapperWrapper

- (void)parseJSON:(id)jsonObject withMappingScheme:(NSString *)scheme
          success:(void(^)(id result))success
          failure:(void(^)(NSError *error))failure {
    
    if ([[jsonObject objectForKey:@"error"] isEqualToString:@""]) {
        id results = [MTLJSONAdapter modelsOfClass:NSClassFromString(scheme) fromJSONArray:[jsonObject objectForKey:@"data"] error:nil];
        if ([results isKindOfClass:[NSArray class]]) {
            success(results);
        } else {
            failure([self getJSONError:jsonObject]);
        }
    } else {
        failure([self getJSONError:jsonObject]);
    }
    
}

- (NSError *)getJSONError:(NSDictionary *)json {
    NSDictionary *message = [json objectForKey:@"messages"];
    if (message) {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [message objectForKey:@"error"]};
        if (userInfo) {
            return [NSError errorWithDomain:kServerAPIErrorDomain code:NSURLErrorUnknown userInfo:userInfo];
        }
    }
    
    if ([[json objectForKey:@"result"] isEqualToString:@"ERROR"]) {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [json objectForKey:@"error"]};
        return [NSError errorWithDomain:kServerAPIErrorDomain code:NSURLErrorUnknown userInfo:userInfo];
    }
    
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: @"UNKNOWN_ERROR"};
    return [NSError errorWithDomain:kServerAPIErrorDomain code:NSURLErrorUnknown userInfo:userInfo];
}

@end
