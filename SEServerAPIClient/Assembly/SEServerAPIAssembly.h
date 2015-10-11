//
//  SEServerAPIAssembly.h
//  SEServerAPIClient
//
//  Created by Evseev Sergey on 11/10/15.
//  Copyright © 2015 Sergey Evseev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TyphoonAssembly.h"


@protocol SEServerAPIDataMapperProtocol;
@protocol SEServerAPIRPCServiceProtocol;
@protocol SEAppConfigProtocol;

@interface SEServerAPIAssembly : TyphoonAssembly

- (UIViewController *)viewController;

@end
