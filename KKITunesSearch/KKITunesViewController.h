//
//  KKViewController.h
//  KKITunesSearchExample
//
//  Created by Louis-Alban KIM on 21/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKITunesSearch.h"
#import <StoreKit/StoreKit.h>

@interface KKITunesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, SKStoreProductViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender;

@property (strong, nonatomic) NSArray *results;
@property (strong, nonatomic) NSTimer *timer;
@property (readonly, nonatomic) KKITunesSearchType searchType;

- (void)scheduleSearch;
- (void)unscheduleSearch;
- (void)search;

@end
