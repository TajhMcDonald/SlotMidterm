//
//  HistoryViewController.m
//  SlotMidterm
//
//  Created by Tajh McDonald on 11/16/16.
//  Copyright © 2016 McDonald's Computing INC. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;
//@property (strong, nonatomic) NSArray *history;
@end

@implementation HistoryViewController

//- (void)setHistory:(NSArray *)history
//{
//    _history = history;
//    if(self.view.window)
//        [self updateUI];
//}
- (void)setFlipHistory:(NSArray *)flipHistory
{
    _flipHistory = flipHistory;
    if (self.view.window) [self updateUI];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}
-(void)updateUI
{
    NSLog(@"History View Controller UpdateUI");
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
    int i =1;
    NSLog(@"%@", self.flipHistory);
    for (NSAttributedString *step in self.flipHistory) {
        [text appendAttributedString:
         [[NSMutableAttributedString alloc] initWithString:
          [NSString stringWithFormat:@"%3d:  ",i]]];
        NSLog(@"History View Controller UpdateUI --- 1");
        NSLog(@"%@", step);
        [text appendAttributedString:step];
        [text appendAttributedString:[
                                      [NSAttributedString alloc] initWithString:@"\n\n "]];
        i++;
    }
    NSLog(@"History View Controller UpdateUI --- 2");
    self.historyTextView.attributedText = text;
    NSLog(@"History View Controller UpdateUI --- 3");
    NSLog(@"%@", text);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"Here");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"Here");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
