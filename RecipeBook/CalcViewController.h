//
//  CalcViewController.h
//  Bengaluru1
//
//  Created by Gouthami Byraiah on 4/25/15.
//
//

#import <UIKit/UIKit.h>

@interface CalcViewController : UIViewController {

    IBOutlet UILabel *calculatorScreen;
    float currentNumber;
    float result;
    int currentOperation;
    
}

- (IBAction)operationPressed:(id)sender;
- (IBAction)numberPressed:(id)sender;
- (IBAction)AC:(id)sender;
- (IBAction)C:(id)sender;


@property float currentNumber;
@property float result;
@property int currentOperation;

@end

