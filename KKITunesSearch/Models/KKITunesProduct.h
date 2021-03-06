//
//  KKITunesProduct.h
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 21/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKITunesSearch.h"

typedef NSInteger KKITunesProductSection;

extern NSInteger const KKITunesProductSectionNone;

typedef enum {
    KKITunesAppsSectionIPad = 0,
    KKITunesAppsSectionIPhone = 1,
    KKITunesAppsSectionUniversal = 2,
    KKITunesAppsSectionMacOS = 3,
    KKITunesAppsSectionCount = 4
} KKITunesAppsSection;

typedef enum {
    KKITunesMusicSectionArtist = 0,
    KKITunesMusicSectionAlbum = 1,
    KKITunesMusicSectionTrack = 2,
    KKITunesMusicSectionCount = 3
} KKITunesMusicSection;

typedef enum {
    KKITunesMoviesSectionMovies = 0,
    KKITunesMoviesSectionTVSeasons = 1,
    KKITunesMoviesSectionTVEpisodes = 2,
    KKITunesMoviesSectionCount = 3
} KKITunesMoviesSection;

typedef enum {
    KKITunesBooksSectionAuthor = 0,
    KKITunesBooksSectionIBooks = 1,
    KKITunesBooksSectionAudioBooks = 2,
    KKITunesBooksSectionCount = 3,
} KKITunesBooksSection;

typedef enum {
    KKITunesStoreApp = 0,
    KKITunesStoreMacApp = 1,
    KKITunesStoreITunes = 2,
    KKITunesStoreIBook = 3,
    KKITunesStoreNone = -1
} KKITunesStore;

@interface KKITunesProduct : NSObject

@property (assign, nonatomic) KKITunesProductSection section;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSURL *thumbnailURL;
@property (readonly, nonatomic) KKITunesStore store;

+ (id)productWithResult:(NSDictionary *)result type:(KKITunesProductType)type;
+ (KKITunesProductSection)sectionFromResult:(NSDictionary *)result;
- (id)initWithResult:(NSDictionary *)result section:(KKITunesProductSection)section;
- (BOOL)isEqual:(KKITunesProduct *)product;

@end
