//
//  KKITunesProductsCollection.m
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 21/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKITunesProductsCollection.h"

@interface KKITunesProductsCollection ()

@property (strong, nonatomic) NSMutableArray *products;
@property (strong, nonatomic) NSMutableArray *productsBySection;

- (void)setProductsWithResults:(NSArray *)results;

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
    
    self.productsBySection = [NSMutableArray array];
    for (NSInteger i = 0; i < self.sectionsCount; i++) {
        [self.productsBySection addObject:[NSMutableArray array]];
    }
    
    for (NSDictionary *result in results) {
        KKITunesProduct *product = [KKITunesProduct productWithResult:result];
        
        [self.products addObject:product];
        for (NSNumber *section in product.sections) {
            [self.productsBySection[section.integerValue] addObject:product];
        }
    }
}

#pragma mark Accessors

- (NSInteger)sectionsCount {
    
    switch (self.type) {
        case KKITunesProductTypeApps:
            return KKITunesAppsSectionCount;
        case KKITunesProductTypeMusic:
            return KKITunesMusicSectionCount;
        default:
            return 0;
    }
}

- (NSInteger)numberOfProductsInSection:(NSInteger)section {
    
    return [self.productsBySection[section] count];
}

- (NSString *)titleForSection:(NSInteger)section {
    
    switch (self.type) {
        case KKITunesProductTypeApps:
            switch (section) {
                case KKITunesAppsSectionIPad:
                    return NSLocalizedString(@"iPad", nil);
                case KKITunesAppsSectionIPhone:
                    return NSLocalizedString(@"iPhone", nil);
                case KKITunesAppsSectionMacOS:
                    return NSLocalizedString(@"Mac OS", nil);
                default:
                    return nil;
            }
        case KKITunesProductTypeMusic:
            switch (section) {
                case KKITunesMusicSectionArtist:
                    return NSLocalizedString(@"Artist", nil);
                case KKITunesMusicSectionAlbum:
                    return NSLocalizedString(@"Album", nil);
                case KKITunesMusicSectionTrack:
                    return NSLocalizedString(@"Track", nil);
                default:
                    return nil;
            }
        default:
            return nil;
    }
}

- (KKITunesProduct *)productAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.productsBySection[indexPath.section][indexPath.row];
}



@end
