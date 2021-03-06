//
//  KKITunesProductsCollection.m
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 21/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKITunesProductsCollection.h"

@interface KKITunesProductsCollection ()

@property (strong, nonatomic) NSArray *products;
@property (strong, nonatomic) NSArray *sections;

- (void)setProductsWithResults:(NSArray *)results;
- (NSInteger)availableSectionsCount;

@end

@implementation KKITunesProductsCollection

#pragma mark Request

- (void)search:(NSString *)term
      withType:(KKITunesProductType)type
       success:(void(^)())success
       failure:(void(^)(NSError *error))failure {
    
    self.type = type;
    [[KKITunesSearch sharedClient] search:term
                                 withType:type
                                  success:^(NSUInteger count, NSArray *results) {
                                      [self setProductsWithResults:results];
                                      success();
                                  } failure:^(NSError *error) {
                                      failure(error);
                                  }];
}

- (void)setProductsWithResults:(NSArray *)results {
    
    NSMutableArray *products = [NSMutableArray array];
    NSMutableArray *sections = [NSMutableArray array];
    
    for (NSInteger i = 0; i < self.availableSectionsCount; i++) {
        NSDictionary *section = @{
            @"section": [NSNumber numberWithInteger:i],
            @"products": [NSMutableArray array]
        };
        [sections addObject:section];
    }
    
    for (NSDictionary *result in results) {
        
        KKITunesProduct *product = [KKITunesProduct productWithResult:result type:self.type];
        if (product && ![products containsObject:product]) {
            [products addObject:product];
            if (product.section != KKITunesProductSectionNone) {
                [sections[product.section][@"products"] addObject:product];
            }
        }
    }
    
    self.products = [NSArray arrayWithArray:products];
    NSIndexSet *nonEmptyIndexes = [sections indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [obj[@"products"] count] > 0;
    }];
    self.sections = [sections objectsAtIndexes:nonEmptyIndexes];
}

#pragma mark Accessors

- (NSInteger)availableSectionsCount {
    
    switch (self.type) {
        case KKITunesProductTypeApps:
            return KKITunesAppsSectionCount;
        case KKITunesProductTypeMusic:
            return KKITunesMusicSectionCount;
        case KKITunesProductTypeMovies:
            return KKITunesMoviesSectionCount;
        case KKITunesProductTypeBooks:
            return KKITunesBooksSectionCount;
        default:
            return 0;
    }
}

- (NSInteger)sectionsCount {
    
    return self.sections.count;
}

- (NSInteger)numberOfProductsInSection:(NSInteger)section {
    
    return [self.sections[section][@"products"] count];
}

- (KKITunesProductSection)sectionAtIndex:(NSInteger)section {
    
    return [self.sections[section][@"section"] integerValue];
}

- (KKITunesProduct *)productAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.sections[indexPath.section][@"products"][indexPath.row];
}

@end
