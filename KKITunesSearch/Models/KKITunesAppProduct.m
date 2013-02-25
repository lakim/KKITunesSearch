//
//  KKITunesAppProduct.m
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 21/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKITunesAppProduct.h"

@implementation KKITunesAppProduct

- (NSSet *)sectionsFromResult:(NSDictionary *)result {
    
    NSMutableSet *sections = [NSMutableSet set];
    
    if ([result[@"kind"] isEqual:@"mac-software"]) {
        
        [sections addObject:[NSNumber numberWithInteger:KKITunesAppsSectionMacOS]];
    } else {
        NSArray *devices = result[@"supportedDevices"];
        
        if ([devices containsObject:@"all"]) {
            [sections addObject:[NSNumber numberWithInteger:KKITunesAppsSectionIPad]];
            [sections addObject:[NSNumber numberWithInteger:KKITunesAppsSectionIPhone]];
        }
        if ([devices indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            return [obj rangeOfString:@"iPad"].location != NSNotFound;
        }] != NSNotFound) {
            [sections addObject:[NSNumber numberWithInteger:KKITunesAppsSectionIPad]];
        }
        if ([devices indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            return [obj rangeOfString:@"iPhone"].location != NSNotFound;
        }] != NSNotFound) {
            [sections addObject:[NSNumber numberWithInteger:KKITunesAppsSectionIPhone]];
        }
    }
    
    return sections;
}

@end
