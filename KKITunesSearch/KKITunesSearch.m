//
//  KKITunesSearch.m
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 14/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKITunesSearch.h"

static NSString *kKKITunesSearchBaseURL = @"https://itunes.apple.com/search";
static NSString *kKKITunesSearchErrorDomain = @"com.kimkode.KKITunesSearch";
static NSInteger kKKITunesSearchErrorCode = 1;

@implementation KKITunesSearch

#pragma mark Init

+ (KKITunesSearch *)sharedClient {
    
    static KKITunesSearch *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        NSURL *baseURL = [NSURL URLWithString:kKKITunesSearchBaseURL];
        _sharedClient = [self clientWithBaseURL:baseURL];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    if (self) {
        [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/javascript"]];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    return self;
}

#pragma mark Accessors

- (NSMutableDictionary *)defaultParameters {
    
    if (!_defaultParameters) {
        _defaultParameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.countryCode, @"country", nil];
    }
    return [_defaultParameters mutableCopy];
}

- (NSString *)countryCode {
    
    NSString *code =  [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    return code;
}

#pragma mark Requests

- (void)searchWithParams:(NSDictionary *)searchParams
                 success:(void(^)(NSUInteger count, NSArray *results))success
                 failure:(void(^)(NSError *error))failure {
    
    NSMutableDictionary *params = self.defaultParameters;
    [params addEntriesFromDictionary:searchParams];
    
    [[self operationQueue] cancelAllOperations];
    [self getPath:nil
       parameters:params
          success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
              
              NSNumber *count = nil;
              NSArray *results = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]] &&
                  (count = responseObject[@"resultCount"]) &&
                  [count isKindOfClass:[NSNumber class]] &&
                  (results = responseObject[@"results"]) &&
                  [results isKindOfClass:[NSArray class]]) {
                  
                  success(count.integerValue, results);
              } else {
                  
                  failure([NSError errorWithDomain:kKKITunesSearchErrorDomain
                                              code:kKKITunesSearchErrorCode
                                          userInfo:nil]);
              }
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              failure(error);
          }];
}

- (void)search:(NSString *)term
      withType:(KKITunesSearchType)type
       success:(void(^)(NSUInteger count, NSArray *results))success
       failure:(void(^)(NSError *error))failure {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   term, @"term",
                                   @"songTerm", @"attribute",
                                   nil];
    
    switch (type) {
        case KKITunesSearchTypeApps:
            params[@"entity"] = @"iPadSoftware,software,macSoftware";
            break;
        case KKITunesSearchTypeMusic:
            params[@"media"] = @"music";
        default:
            break;
    }
    
    [self searchWithParams:params success:success failure:failure];
}

@end
