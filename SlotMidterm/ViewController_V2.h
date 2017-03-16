//
//  ViewController2.h
//  SlotMidterm
//
//  Created by Tajh McDonald on 11/16/16.
//  Copyright © 2016 McDonald's Computing INC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController_V2;

@protocol ViewController_V2Delegate <NSObject>

- (void)ViewController_V2 :(ViewController_V2 *)viewController_V2 didCashOut:(NSInteger)coins;

@end

@interface ViewController_V2 : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *CoinPicker;
@property (strong, nonatomic) IBOutlet UIButton *spinButton;

@property (strong, nonatomic) NSArray *numbersArray;
@property (nonatomic) NSInteger coins;

@property (weak, nonatomic) id<ViewController_V2Delegate> delegate;

@end
