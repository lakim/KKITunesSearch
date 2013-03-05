//
//  KKITunesProduct.m
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 21/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKITunesProduct.h"

NSInteger const KKITunesProductSectionNone = -1;

@implementation KKITunesProduct

+ (id)productWithResult:(NSDictionary *)result type:(KKITunesProductType)type {
    
    Class class = nil;
    switch (type) {
        case KKITunesProductTypeApps:
            class = NSClassFromString(@"KKITunesAppProduct");
            break;
        case KKITunesProductTypeMusic:
            class = NSClassFromString(@"KKITunesMusicProduct");
            break;
        case KKITunesProductTypeMovies:
            class = NSClassFromString(@"KKITunesMovieProduct");
            break;
        case KKITunesProductTypeBooks:
            class = NSClassFromString(@"KKITunesBookProduct");
            break;
        default:
            break;
    }
    
    KKITunesProductSection section = [class sectionFromResult:result];
    if (section != KKITunesProductSectionNone) {
        // Pass the section to the initializer to avoid double pass
        return [[class alloc] initWithResult:result section:section];
    }
    
    NSLog(@"%@: Class not found for result:", NSStringFromSelector(_cmd));
    NSLog(@"%@", result);
    return nil;
}

- (id)initWithResult:(NSDictionary *)result section:(KKITunesProductSection)section {
    
    self = [super init];
    if (self) {
        self.id = result[@"trackId"];
        self.title = result[@"trackName"];
        self.url = [NSURL URLWithString:result[@"trackViewUrl"]];
        self.thumbnailURL = [NSURL URLWithString:result[@"artworkUrl60"]];
        self.section = section;
    }
    return self;
}

+ (KKITunesProductSection)sectionFromResult:(NSDictionary *)result {
    
    return KKITunesProductSectionNone;
}

- (BOOL)isEqual:(KKITunesProduct *)product {
    
    return (self == product) || [self.id isEqual:product.id];
}

- (KKITunesStore)store {
    
    return KKITunesStoreNone;
}

@end
