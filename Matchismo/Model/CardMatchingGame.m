//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Avishay Sheba on 1/5/14.
//  Copyright (c) 2014 Via Transportation Inc. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of cards

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)currentSelection
{
    if (!_currentSelection) _currentSelection = [[NSMutableArray alloc] init];
    return _currentSelection;
}

- (void) setMatchType:(NSUInteger)matchType
{
    if (matchType < 2) {
        _matchType = 2;
        NSLog(@"Received matchType %d which is less than 2. Cannot match less than 2 cards, therefore setting 2 as a default", matchType);
    }
    
    _matchType = matchType;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        self.matchType = 2;
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (instancetype)init
{
    return nil;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)reset
{
    self.score = 0;
    for (Card *card in self.cards) {
        card.matched = NO;
        card.chosen = NO;
    }
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (Card *)rotateCurrentSelectionWithCard:(Card *)card
{
    [self.currentSelection addObject:card];
    Card *firstCard = [self.currentSelection firstObject];
    [self.currentSelection removeObjectAtIndex:0];
    return firstCard;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            [self.currentSelection removeObject:card];
        } else {
            
            // Collect cards
            [self.currentSelection removeAllObjects];
            for (Card* c in self.cards) {
                if (!c.isMatched && c.isChosen) [self.currentSelection addObject:c];
            }
            
            // Match them if collected enough cards.
            if ([self.currentSelection count] == self.matchType - 1) {
                int matchScore = [card match:self.currentSelection];
                
                Card *iteratedCard = [self rotateCurrentSelectionWithCard:card];
                while (![iteratedCard isEqualToCard:card]) {
                    matchScore += [iteratedCard match:self.currentSelection];
                    iteratedCard = [self rotateCurrentSelectionWithCard:iteratedCard];
                }
                
                // Normalize
                matchScore /= self.matchType;
                
                if (matchScore) {
                    self.score += (matchScore * MATCH_BONUS);
                    card.matched = YES;
                    
                    for (Card *collectedCard in self.currentSelection) {
                        collectedCard.matched = YES;
                    }
                } else {
                    self.score -= MISMATCH_PENALTY;
                    for (Card *collectedCard in self.currentSelection) {
                        collectedCard.chosen = NO;
                    }
                }
            }
            
            // Reduce score for choosing one card.
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            [self.currentSelection addObject:card];
        }
    }
}

@end
