//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Avishay Sheba on 1/6/14.
//  Copyright (c) 2014 Via Transportation Inc. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (CardMatchingGame *)createGameWithCardCount:(NSInteger)count
{
    return [[CardMatchingGame alloc] initWithCardCount:count
                                      usingDeck:[self createDeck]];
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end
