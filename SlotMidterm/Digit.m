//
//  Digit.m
//  SlotMidterm
//
//  Created by Tajh McDonald on 12/6/16.
//  Copyright © 2016 McDonald's Computing INC. All rights reserved.
//

#import "Digit.h"

@interface Digit ()

@property (nonatomic) NSUInteger myNumber;
@property (nonatomic, strong) UIColor *myColor;
@end


@implementation Digit



- (NSAttributedString *)digit {
    
    if (!_myColor) {
        self.myColor = [self randomColor];
        self.myNumber = 0;
    }
    
    NSMutableAttributedString *attributedDigit = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long) self.myNumber]];
    
    
    [attributedDigit setAttributes:@{NSForegroundColorAttributeName:_myColor}
                             range:NSMakeRange(0, [attributedDigit length])];
    
    return attributedDigit;
}



- (void)randomize {
    self.myNumber = [self randomNumber];
    self.myColor = [self randomColor];
}



- (NSUInteger)randomNumber {
    return (NSUInteger) (arc4random() % 10);
}



- (UIColor *)randomColor
{
    UIColor *color;
    switch (arc4random()%4) {
        case 0: color = [UIColor redColor]; break;
        case 1: color = [UIColor blueColor]; break;
        case 2: color = [UIColor greenColor]; break;
        case 3: color = [UIColor purpleColor]; break;
    }
    return color;
}

@end
