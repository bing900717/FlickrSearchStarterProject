//
//  RWTViewModelServicesImpl.h
//  RWTFlickrSearch
//
//  Created by yaoxb on 2016/11/14.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTViewModelServices.h"

@interface RWTViewModelServicesImpl : NSObject<RWTViewModelServices>
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;
@end
