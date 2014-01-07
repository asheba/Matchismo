//
//  HistoryViewController.h
//  Matchismo
//
//  Created by Avishay Sheba on 1/7/14.
//  Copyright (c) 2014 Via Transportation Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardGameViewController.h"

@interface HistoryViewController : UIViewController

@property (nonatomic, weak) CardGameViewController *originController;

- (void)setHistory:(NSArray *)history;

@end
