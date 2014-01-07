//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Avishay Sheba on 1/7/14.
//  Copyright (c) 2014 Via Transportation Inc. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@property (strong, nonatomic) IBOutlet UITextView *historyTextView;
@property (strong, nonatomic) NSArray *history;
@end

@implementation HistoryViewController

@synthesize historyTextView;

- (IBAction)touchClearHistoryButton:(UIButton *)sender {
    [self.originController removeAllHistoryEntries];
    self.historyTextView.attributedText = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
    for (NSAttributedString *entry in self.history) {
        [str appendAttributedString:entry];
        [str appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
    
    [self.historyTextView setAttributedText:str];
}

@end
