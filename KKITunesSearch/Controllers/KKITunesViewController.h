//
//  KKViewController.h
//  KKITunesSearchExample
//
//  Created by Louis-Alban KIM on 21/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "KKITunesProductsCollection.h"

@class KKITunesViewController;

@protocol KKITunesViewControllerDelegate <NSObject>
@optional
- (void)iTunesViewController:(KKITunesViewController *)viewController didSelectProduct:(KKITunesProduct *)product;
@end

@interface KKITunesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, SKStoreProductViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender;

@property (weak, nonatomic) id<KKITunesViewControllerDelegate> delegate;
@property (strong, nonatomic) KKITunesProductsCollection *products;
@property (strong, nonatomic) NSTimer *timer;
@property (readonly, nonatomic) KKITunesProductType productType;

- (void)scheduleSearch;
- (void)unscheduleSearch;
- (void)search;

@end
