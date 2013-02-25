//
//  KKViewController.m
//  KKITunesSearchExample
//
//  Created by Louis-Alban KIM on 21/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKIPadViewController.h"
#import "KKITunesViewController.h"

@implementation KKIPadViewController

- (IBAction)buttonTapped:(UIButton *)button {
    
    KKITunesViewController *iTunesViewController = [[KKITunesViewController alloc] initWithNibName:NSStringFromClass([KKITunesViewController class]) bundle:nil];
    
    self.popover = [[UIPopoverController alloc] initWithContentViewController:iTunesViewController];
    [self.popover presentPopoverFromRect:button.frame
                                       inView:self.view
                     permittedArrowDirections:UIPopoverArrowDirectionAny
                                     animated:YES];
}

@end
