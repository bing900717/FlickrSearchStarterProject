//
//  RWTFlickrSearchViewModel.h
//  RWTFlickrSearch
//
//  Created by yaoxb on 2016/11/14.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTViewModelServices.h"

@interface RWTFlickrSearchViewModel : NSObject

@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) RACCommand *executeSearch;

- (instancetype)initWithServices:(id<RWTViewModelServices>)services;


@end
