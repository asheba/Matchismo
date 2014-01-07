//
//  SetCard.m
//  Matchismo
//
//  Created by Avishay Sheba on 1/6/14.
//  Copyright (c) 2014 Via Transportation Inc. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSUInteger)typeCount { return 3; }
+ (BOOL)isValid:(NSUInteger)property { return property > 0 && property <= [self typeCount]; }

- (void)setShape:(NSUInteger)shape { _shape = [SetCard isValid:shape] ? shape : 0; }
- (void)setCount:(NSUInteger)count { _count = [SetCard isValid:count] ? count : 0; }
- (void)setColor:(NSUInteger)color { _color = [SetCard isValid:color] ? color : 0; }
- (void)setStyle:(NSUInteger)style { _style = [SetCard isValid:style] ? style : 0; }

- (int)match:(NSArray *)otherCards
{
    SetCard *first = [otherCards firstObject];
    
    int shapeTarget = (BOOL)(first.shape - self.shape) ? 0 : 1;
    int countTarget = (BOOL)(first.count - self.count) ? 0 : 1;
    int styleTarget = (BOOL)(first.style - self.style) ? 0 : 1;
    int colorTarget = (BOOL)(first.color - self.color) ? 0 : 1;
    
    for (SetCard *card in otherCards) {
        int shapeMatch = (BOOL)(card.shape - self.shape) ? 0 : 1;
        int countMatch = (BOOL)(card.count - self.count) ? 0 : 1;
        int styleMatch = (BOOL)(card.style - self.style) ? 0 : 1;
        int colorMatch = (BOOL)(card.color - self.color) ? 0 : 1;
        
        BOOL match = (shapeMatch == shapeTarget) &&
                     (countMatch == countTarget) &&
                     (styleMatch == styleTarget) &&
                     (colorMatch == colorTarget);
        if (!match) return 0;
    }
    
    return 1;
}

- (BOOL)isEqualToCard:(Card *)card
{
    if (!card || ![card isKindOfClass:[self class]]) return NO;
    
    SetCard *other = (SetCard *)card;
    
    return  self.shape == other.shape &&
            self.count == other.count &&
            self.style == other.style &&
            self.color == other.color;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"[%d,%d,%d,%d]",
            self.shape, self.count, self.style, self.color];
}

@end
