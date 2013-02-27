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
    
    return [[[self productClassFromResult:result] alloc] initWithResult:result];
}

+ (Class)productClassFromResult:(NSDictionary *)result {
    
    // TODO: refactor in classes
    if ([result[@"kind"] isEqual:@"software"] || [result[@"kind"] isEqual:@"mac-software"]) {
        return NSClassFromString(@"KKITunesAppProduct");
    }
    if (([result[@"wrapperType"] isEqual:@"artist"] && [result[@"artistType"] isEqual:@"Artist"]) ||
        ([result[@"wrapperType"] isEqual:@"collection"] && ([result[@"collectionType"] isEqual:@"Album"] || [result[@"collectionType"] isEqual:@"Compilation"])) ||
        ([result[@"wrapperType"] isEqual:@"track"] && [result[@"kind"] isEqual:@"song"])) {
        return NSClassFromString(@"KKITunesMusicProduct");
    }
    if (([result[@"wrapperType"] isEqual:@"collection"] && [result[@"collectionType"] isEqual:@"TV Season"]) ||
        [result[@"kind"] isEqual:@"tv-episode"] ||
        [result[@"kind"] isEqual:@"feature-movie"]) {
        return NSClassFromString(@"KKITunesMovieProduct");
    }
    if (([result[@"wrapperType"] isEqual:@"artist"] && [result[@"artistType"] isEqual:@"Author"]) ||
        [result[@"kind"] isEqual:@"ebook"] ||
        [result[@"wrapperType"] isEqual:@"audiobook"]) {
        return NSClassFromString(@"KKITunesBookProduct");
    }
    
    NSLog(@"%@: Class not found for result:", NSStringFromSelector(_cmd));
    NSLog(@"%@", result);
    return nil;
}

- (id)initWithResult:(NSDictionary *)result {
    
    self = [super init];
    if (self) {
        self.id = result[@"trackId"];
        self.title = result[@"trackName"];
        self.thumbnailURL = [NSURL URLWithString:result[@"artworkUrl60"]];
        self.section = [self sectionFromResult:result];
    }
    return self;
}

- (KKITunesProductSection)sectionFromResult:(NSDictionary *)result {
    
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return KKITunesProductSectionNone;
}

- (BOOL)isEqual:(KKITunesProduct *)product {
    
    return (self == product) || [self.id isEqual:product.id];
}

@end
