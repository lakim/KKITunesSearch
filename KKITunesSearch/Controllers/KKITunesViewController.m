//
//  KKViewController.m
//  KKITunesSearchExample
//
//  Created by Louis-Alban KIM on 21/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKITunesViewController.h"

static const NSTimeInterval kKKViewControllerSearchDelay = 0.8f;
static const NSUInteger kKKViewControllerMinimumLength = 3;

@interface KKITunesViewController ()

- (void)addKeyboardObservers;
- (void)removeKeyboardObservers;
- (void)keyboardDidShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;

@end

@implementation KKITunesViewController

#pragma mark View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.products = [[KKITunesProductsCollection alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self addKeyboardObservers];
    }
}

- (void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:animated];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self removeKeyboardObservers];
    }
}

#pragma mark Accessors

- (KKITunesProductType)productType {
    
    if (self.view) {
        switch (self.segmentedControl.selectedSegmentIndex) {
            case 0: // Apps
                return KKITunesProductTypeApps;
            case 1: // Music
                return KKITunesProductTypeMusic;
            default:;
        }
    }
    return KKITunesProductTypeAll;
}

#pragma mark Keyboard

- (void)addKeyboardObservers {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)removeKeyboardObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIEdgeInsets insets = UIEdgeInsetsMake(0.0f, 0.0f, keyboardFrame.size.height, 0.0f);
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    self.tableView.contentInset = self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.products.sectionsCount;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (self.productType) {
        case KKITunesProductTypeApps:
            switch (section) {
                case KKITunesAppsSectionIPad:
                    return NSLocalizedString(@"iPad", nil);
                case KKITunesAppsSectionUniversal:
                    return NSLocalizedString(@"iPad/iPhone", nil);
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.products numberOfProductsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"resultCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    KKITunesProduct *product = [self.products productAtIndexPath:indexPath];
    cell.textLabel.text = product.title;
    [cell.imageView setImageWithURL:product.thumbnailURL placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(iTunesViewController:didSelectProduct:)]) {
        KKITunesProduct *product = [self.products productAtIndexPath:indexPath];
        [self.delegate iTunesViewController:self didSelectProduct:product];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {

    if (![SKStoreProductViewController class]) return;
    
    KKITunesProduct *product = [self.products productAtIndexPath:indexPath];
    
    SKStoreProductViewController *productViewController = [[SKStoreProductViewController alloc] init];
    productViewController.delegate = self;
    [productViewController loadProductWithParameters:@{ SKStoreProductParameterITunesItemIdentifier: product.id }
                                     completionBlock:^(BOOL result, NSError *error) {
                                         if (result) {
                                             [self presentViewController:productViewController animated:YES completion:nil];
                                         }
                                     }];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGRect frame = self.headerView.frame;
    frame.origin.y = (scrollView.contentOffset.y > 0) ? 0 : fabsf(scrollView.contentOffset.y);
    self.headerView.frame = frame;
}

#pragma mark UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [self scheduleSearch];
}

#pragma mark Search

- (void)scheduleSearch {
    
    [self unscheduleSearch];
    if (self.searchBar.text.length < kKKViewControllerMinimumLength) return;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kKKViewControllerSearchDelay
                                                  target:self
                                                selector:@selector(search)
                                                userInfo:nil
                                                 repeats:NO];
}

- (void)unscheduleSearch {
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)search {
    
    [self unscheduleSearch];
    if (self.searchBar.text.length < kKKViewControllerMinimumLength) return;
    
    [self.activityIndicator startAnimating];
    [self.products search:self.searchBar.text
                 withType:self.productType
                  success:^() {
                      [self.tableView reloadData];
                      [self.tableView setContentOffset:CGPointZero animated:YES];
                      [self.activityIndicator stopAnimating];
                  } failure:^(NSError *error) {
                      [self.activityIndicator stopAnimating];
                  }];
}

#pragma mark UISegmentedControl actions

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
    
    [self search];
}

#pragma mark SKStoreProductViewControllerDelegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
