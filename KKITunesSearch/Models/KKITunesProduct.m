//
//  KKITunesProduct.m
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 21/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKITunesProduct.h"

@implementation KKITunesProduct

+ (id)productWithResult:(NSDictionary *)result {
    
    return [[[self productClassFromResult:result] alloc] initWithResult:result];
}

+ (Class)productClassFromResult:(NSDictionary *)result {
    
    if ([result[@"kind"] isEqual:@"software"] || [result[@"kind"] isEqual:@"mac-software"]) {
        return NSClassFromString(@"KKITunesAppProduct");
    }
    if ([result[@"wrapperType"] isEqual:@"artist"] || [result[@"wrapperType"] isEqual:@"collection"] || [result[@"wrapperType"] isEqual:@"track"]) {
        return NSClassFromString(@"KKITunesMusicProduct");
    }
    return [self class];
}

- (id)initWithResult:(NSDictionary *)result {
    
    self = [super init];
    if (self) {
        self.id = result[@"trackId"];
        self.title = result[@"trackName"];
        self.thumbnailURL = [NSURL URLWithString:result[@"artworkUrl60"]];
        self.sections = [self sectionsFromResult:result];
    }
    return self;
}

- (NSSet *)sectionsFromResult:(NSDictionary *)result {
    
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return nil;
}

@end