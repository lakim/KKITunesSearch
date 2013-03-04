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

+ (id)productWithResult:(NSDictionary *)result {
    
    NSArray *subclassesNames = @[
        @"KKITunesAppProduct",
        @"KKITunesMusicProduct",
        @"KKITunesMovieProduct",
        @"KKITunesBookProduct"
    ];
    
    for (NSString *subclassName in subclassesNames) {
        Class class = NSClassFromString(subclassName);
        KKITunesProductSection section = [class sectionFromResult:result];
        if (section != KKITunesProductSectionNone) {
            // Pass the section to the initializer to avoid double pass
            return [[class alloc] initWithResult:result section:section];
        }
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
