//
//  PlayingCard.m
//  Matchismo
//
//  Created by Avishay Sheba on 1/2/14.
//  Copyright (c) 2014 Via Transportation Inc. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuites
{
    return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}

- (BOOL)isBlack
{
    return [[PlayingCard validSuites] indexOfObject:self.suit] < 2;
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuites] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6",
             @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank { return [[self rankStrings] count] - 1; }

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

static const int MATCH_DIFFICULTY_EXPONENT = 5;

- (int)match:(NSArray *)otherCards
{
    int rankMatches = -1;
    int suitMatches = -1;
    
    for (PlayingCard *card in otherCards) {
        if (card.rank == self.rank) rankMatches++;
        if (card.suit == self.suit) suitMatches++;
    }
    
    if (rankMatches > -1 || suitMatches > -1) {
        int rankScore = 4 * pow(MATCH_DIFFICULTY_EXPONENT, rankMatches * 2);
        int suitScore = 1 * pow(MATCH_DIFFICULTY_EXPONENT, suitMatches);
        
        return MAX(rankScore, suitScore);
    } else {
        return 0;
    }    
}

- (BOOL)isEqualToCard:(Card *)card
{
    if (!card || ![card isKindOfClass:[self class]]) return NO;
    
    return [self.contents isEqualToString:card.contents];
}

@end
