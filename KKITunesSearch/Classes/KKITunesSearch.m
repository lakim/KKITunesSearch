//
//  KKITunesSearch.m
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 14/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKITunesSearch.h"

static NSString *kKKITunesSearchBaseURL = @"http://itunes.apple.com/search";
static NSString *kKKITunesSearchErrorDomain = @"com.kimkode.KKITunesSearch";
static NSInteger kKKITunesSearchErrorCode = 1;
static NSInteger kKKITunesSearchLimit = 3;

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

- (AFHTTPRequestOperation *)HTTPRequestOperationWithParams:(NSDictionary *)searchParams
                                                   success:(void(^)(NSUInteger count, NSArray *results))success
                                                   failure:(void(^)(NSError *error))failure {
    
    NSMutableDictionary *params = self.defaultParameters;
    [params addEntriesFromDictionary:searchParams];
    
    NSURLRequest *request = [self requestWithMethod:@"GET" path:nil parameters:params];
    AFHTTPRequestOperation *operation =
    [self HTTPRequestOperationWithRequest:request
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
    
    return operation;
}

- (void)search:(NSString *)term
      withType:(KKITunesProductType)type
       success:(void(^)(NSUInteger count, NSArray *results))success
       failure:(void(^)(NSError *error))failure {
    
    [[self operationQueue] cancelAllOperations];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   term, @"term",
                                   [NSNumber numberWithInteger:kKKITunesSearchLimit], @"limit",
                                   nil];
    
    NSArray *entities = nil;
    switch (type) {
        case KKITunesProductTypeApps:
            entities = @[ @"iPadSoftware", @"software", @"macSoftware" ];
            params[@"attribute"] = @"songTerm";
            break;
        case KKITunesProductTypeMusic:
            entities = @[ @"musicArtist", @"album", @"song" ];
            break;
        case KKITunesProductTypeMovies:
            entities = @[ @"movie", @"tvSeason", @"tvEpisode", @"shortFilm" ];
            break;
        case KKITunesProductTypeBooks:
            entities = @[ @"ebookAuthor", @"ebook", @"audiobook" ];
            break;
        default:;
    }
    
    __block NSInteger batchResultsCount = 0;
    NSMutableArray *batchResults = [NSMutableArray array];
    NSMutableArray *operations = [NSMutableArray array];
    for (NSString *entity in entities) {
        params[@"entity"] = entity;
        
        AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithParams:params
                                                                         success:^(NSUInteger count, NSArray *results) {
                                                                             batchResultsCount += count;
                                                                             [batchResults addObjectsFromArray:results];
                                                                         } failure:^(NSError *error) {
                                                                             
                                                                         }];
        [operations addObject:operation];
    }
    
    [self enqueueBatchOfHTTPRequestOperations:operations
                                progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
                                    
                                } completionBlock:^(NSArray *operations) {
                                    success(batchResultsCount, batchResults);
                                }];
}

@end
