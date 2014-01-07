//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Avishay Sheba on 1/2/14.
//  Copyright (c) 2014 Via Transportation Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *historyEntries;

- (void)addHistoryEntriesObject:(NSAttributedString *)entry;
- (void)removeAllHistoryEntries;
- (void)updateUI;

// Abstract
- (CardMatchingGame *)createGameWithCardCount:(NSInteger) count;
- (NSAttributedString *)frontForCard:(Card *)card;
- (NSAttributedString *)titleForCard:(Card *)card;
- (UIImage *)backgroundImageForCard:(Card *)card;

@end
