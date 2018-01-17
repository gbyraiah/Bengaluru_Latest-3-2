//
//  CalcViewController.m
//  Bengaluru1
//
//  Created by Gouthami Byraiah on 4/25/15.
//
//

#import "CalcViewController.h"

@interface CalcViewController ()

@end

@implementation CalcViewController
@synthesize currentNumber;
@synthesize currentOperation;
@synthesize result;


- (IBAction)numberPressed:(id)sender
{
     [self.view endEditing:YES];
    currentNumber = currentNumber *10 + (float)[sender tag];
    calculatorScreen.text = [[NSString alloc]initWithFormat:@"%2.f", currentNumber];
}


- (IBAction)operationPressed:(id)sender
{
    if (currentOperation == 0) {
        [self setResult:currentNumber];
    } else {
        switch (currentOperation) {
            case 1:
                [self setResult:[self result] + currentNumber];
                break;
            case 2:
                [self setResult:[self result] - currentNumber];
                break;
            case 3:
                [self setResult:[self result] / currentNumber];
                break;
            case 4:
                [self setResult:[self result] * currentNumber];
                break;
            default:
                break;
        }
    }
    currentNumber = 0;
    calculatorScreen.text = [[NSString alloc] initWithFormat:@"%2.f", result];
    currentOperation = [sender tag];
}


- (IBAction)AC:(id)sender
{
    [self setResult:currentNumber];
    [self setCurrentNumber:0];
    calculatorScreen.text = @"0";
}


- (IBAction)C:(id)sender
{
    
    [self setCurrentNumber:0];
     calculatorScreen.text = @"0";
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UIView * txt in self.view.subviews){
        if ([txt isKindOfClass:[UITextField class]] && [txt isFirstResponder]) {
            [txt resignFirstResponder];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{ // When the return button is pressed on a textField.
    [textField resignFirstResponder]; // Remove the keyboard from the view.
    return YES; // Set the BOOL to YES.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
