//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Avishay Sheba on 1/5/14.
//  Copyright (c) 2014 Via Transportation Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// Designated initializer.
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)reset;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger matchType;
@property (nonatomic, strong) NSMutableArray *currentSelection; // of cards

@end
