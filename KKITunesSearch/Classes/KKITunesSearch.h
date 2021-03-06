//
//  KKITunesSearch.h
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 14/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum {
    KKITunesProductTypeAll,
    KKITunesProductTypeApps,
    KKITunesProductTypeMusic,
    KKITunesProductTypeMovies,
    KKITunesProductTypeBooks
} KKITunesProductType;

@interface KKITunesSearch : AFHTTPClient

@property (nonatomic, strong) NSMutableDictionary *defaultParameters;
@property (nonatomic, readonly) NSString *countryCode;
@property (nonatomic, strong) NSNumber *lowLimit;
@property (nonatomic, strong) NSNumber *mediumLimit;
@property (nonatomic, strong) NSNumber *highLimit;

+ (KKITunesSearch *)sharedClient;

- (AFHTTPRequestOperation *)HTTPRequestOperationWithParams:(NSDictionary *)searchParams
                                                   success:(void(^)(NSUInteger count, NSArray *results))success
                                                   failure:(void(^)(NSError *error))failure;

- (void)search:(NSString *)term
      withType:(KKITunesProductType)type
       success:(void(^)(NSUInteger count, NSArray *results))success
       failure:(void(^)(NSError *error))failure;

@end
