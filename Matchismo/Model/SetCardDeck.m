//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Avishay Sheba on 1/6/14.
//  Copyright (c) 2014 Via Transportation Inc. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (int shape = 1; shape <= [SetCard typeCount]; shape++) {
            for (int color = 1; color <= [SetCard typeCount]; color++) {
                for (int style = 1; style <= [SetCard typeCount]; style++) {
                    for (int count = 1; count <= [SetCard typeCount]; count++) {
                        
                        SetCard *card = [[SetCard alloc] init];
                        card.shape = shape;
                        card.color = color;
                        card.style = style;
                        card.count = count;
                        
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
