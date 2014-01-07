//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Avishay Sheba on 1/2/14.
//  Copyright (c) 2014 Via Transportation Inc. All rights reserved.
//

#import "CardGameViewController.h"
#import "HistoryViewController.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [self createGameWithCardCount:[self.cardButtons count]];
    return _game;
}

- (CardMatchingGame *)createGameWithCardCount:(NSInteger)count
{
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    Card *card = [self.game cardAtIndex:chosenButtonIndex];
    NSString *action = (card.isChosen ? @"Selected" : @"Unselected");
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ card: ", action]];
    [str appendAttributedString:[self frontForCard:card]];
    [self updateStatus:str];
    [self updateUI];
}

- (IBAction)touchResetButton:(UIButton *)sender {
    [self.game reset];
    [self updateUI];
    [self updateStatus:[[NSAttributedString alloc] initWithString:@"Restarted game."]];
}

- (void)updateStatus:(NSAttributedString *)status
{
    [self.statusLabel setAttributedText:status];
    [self addHistoryEntriesObject:status];
}

- (void)updateUI
{
    int oldScore = [[self.scoreLabel.text componentsSeparatedByString:@" "][1] integerValue];
    int scoreDiff = self.game.score - oldScore;
    
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    if (self.game.matchType == [self.game.currentSelection count]) {
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        for (Card *c in self.game.currentSelection) {
            [titles addObject:[self titleForCard:c]];
        }
        NSAttributedString *prefix = [[NSAttributedString alloc] initWithString:
                                      [NSString stringWithFormat:@"Got %d points for matching: ", scoreDiff]];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:prefix];
        for (Card *c in self.game.currentSelection) {
            [text appendAttributedString:[self frontForCard:c]];
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:@", "]];
        }
        NSAttributedString *status = [text attributedSubstringFromRange:NSMakeRange(0, [text length] - 2)];
        [self updateStatus:status];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSAttributedString *)frontForCard:(Card *)card
{
    return nil;
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"History"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController *hvc = (HistoryViewController *)segue.destinationViewController;
            hvc.history = self.historyEntries;
            hvc.originController = self;
        }
    }
}

- (void)removeAllHistoryEntries
{
    [self.historyEntries removeAllObjects];
}

- (void)addHistoryEntriesObject:(NSAttributedString *)entry
{
    [self.historyEntries addObject:entry];
}

- (NSMutableArray *)historyEntries
{
    if (!_historyEntries) _historyEntries = [[NSMutableArray alloc] init];
    return _historyEntries;
}

@end
