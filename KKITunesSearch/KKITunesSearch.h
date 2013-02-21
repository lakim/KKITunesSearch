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
    KKITunesSearchTypeAll,
    KKITunesSearchTypeApps,
    KKITunesSearchTypeMusic
} KKITunesSearchType;

@interface KKITunesSearch : AFHTTPClient

@property (nonatomic, strong) NSMutableDictionary *defaultParameters;
@property (nonatomic, readonly) NSString *countryCode;

+ (KKITunesSearch *)sharedClient;

- (void)searchWithParams:(NSDictionary *)searchParams
                 success:(void(^)(NSUInteger count, NSArray *results))success
                 failure:(void(^)(NSError *error))failure;

- (void)search:(NSString *)term
      withType:(KKITunesSearchType)type
       success:(void(^)(NSUInteger count, NSArray *results))success
       failure:(void(^)(NSError *error))failure;

@end
