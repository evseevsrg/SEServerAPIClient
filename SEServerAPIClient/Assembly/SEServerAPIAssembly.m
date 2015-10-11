//
//  SEServerAPIAssembly.m
//  SEServerAPIClient
//
//  Created by Evseev Sergey on 11/10/15.
//  Copyright © 2015 Sergey Evseev. All rights reserved.
//

#import "SEServerAPIAssembly.h"
#import "SEServerAPIClient.h"
#import "ViewController.h"
#import "SEMapperWrapper.h"
#import "SEServerAPIRPCService.h"
#import "SEAppConfig.h"


@implementation SEServerAPIAssembly

- (UIViewController *)viewController {
    return [TyphoonDefinition withClass:[ViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(serverAPIClient) with:[self serverAPIClient]];
    }];
}

- (SEServerAPIClient *)serverAPIClient {
    return [TyphoonDefinition withClass:[SEServerAPIClient class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(dataMapper) with:[SEMapperWrapper new]];
        [definition injectProperty:@selector(rpcService) with:[SEServerAPIRPCService new]];
        [definition injectProperty:@selector(appConfig) with:[SEAppConfig new]];
        definition.scope = TyphoonScopeSingleton;
    }];
}


@end
