//
//  KKITunesProductsCollection.h
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 21/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKITunesSearch.h"
#import "KKITunesProduct.h"

@interface KKITunesProductsCollection : NSObject

@property (assign, nonatomic) KKITunesProductType type;

- (NSInteger)sectionsCount;
- (NSInteger)numberOfProductsInSection:(NSInteger)section;
- (NSString *)titleForSection:(NSInteger)section;
- (KKITunesProduct *)productAtIndexPath:(NSIndexPath *)indexPath;

- (void)search:(NSString *)term
      withType:(KKITunesProductType)type
       success:(void(^)())success
       failure:(void(^)(NSError *error))failure;

@end
