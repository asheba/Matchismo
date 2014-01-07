//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Avishay Sheba on 1/6/14.
//  Copyright (c) 2014 Via Transportation Inc. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (CardMatchingGame *)createGameWithCardCount:(NSInteger)count
{
    CardMatchingGame *game = [[CardMatchingGame alloc] initWithCardCount:count
                                                               usingDeck:[self createDeck]];
    [game setMatchType:3];
    return game;
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardselected" : @"cardfront"];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    return [self frontForCard:card];
}

- (NSAttributedString *)frontForCard:(Card *)card
{
    SetCard *setCard = (SetCard *)card;
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    UIColor *color = [SetCardGameViewController colors:setCard.color];
    [attributes addEntriesFromDictionary:@{NSForegroundColorAttributeName:color}];
    [attributes addEntriesFromDictionary:[SetCardGameViewController styles:setCard.style forColor:color]];
    
    NSAttributedString *singleShape = [[NSAttributedString alloc]
                                       initWithString:[SetCardGameViewController shapes:setCard.shape]                                                                      attributes:attributes];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
    
    for (int i = 0; i < setCard.count ; i++) {
        [str appendAttributedString:singleShape];
    }
    
    return str;
}

- (void)viewDidAppear:(BOOL)animated {
    [self updateUI];
}

+ (NSString *)shapes:(int)index
{
    return [@{@"1": @"▴", @"2": @"◆", @"3": @"●"} valueForKey:[NSString stringWithFormat:@"%d", index]];
}

+ (UIColor *)colors:(int)index
{
    return [@{@"1": [UIColor greenColor],
              @"2": [UIColor redColor],
              @"3": [UIColor purpleColor] } valueForKey:[NSString stringWithFormat:@"%d", index]];
}


+ (NSDictionary *)styles:(int)index forColor:(UIColor *)color
{
    
    switch (index) {
        case 1:
            return @{NSStrokeWidthAttributeName: @-5};
        case 2:
            return @{NSStrokeWidthAttributeName: @-5,
                     NSStrokeColorAttributeName: color,
                     NSForegroundColorAttributeName: [color colorWithAlphaComponent:0.1]};
        case 3:
            return @{NSStrokeWidthAttributeName: @5};
    }
    
    return @{};
}

@end
