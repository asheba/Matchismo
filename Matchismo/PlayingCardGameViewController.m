//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Avishay Sheba on 1/6/14.
//  Copyright (c) 2014 Via Transportation Inc. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (CardMatchingGame *)createGameWithCardCount:(NSInteger)count
{
    CardMatchingGame *game = [[CardMatchingGame alloc] initWithCardCount:count
                                                               usingDeck:[self createDeck]];
    [game setMatchType:2];
    return game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    return card.isChosen ? [self frontForCard:card] : [[NSAttributedString alloc] initWithString:(@"")];
}

- (NSAttributedString *)frontForCard:(Card *)card
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:(card.description)];
    PlayingCard *playingCard = (PlayingCard *)card;
    
    [str addAttribute:NSForegroundColorAttributeName
                value:playingCard.isBlack ? [UIColor blackColor] : [UIColor redColor]
                range:NSMakeRange(0, [str length])];
    
    return str;
}

@end
