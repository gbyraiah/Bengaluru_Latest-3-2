//
//  TipconverterViewController.m
//  Bengaluru
//
//  Created by Gouthami Byraiah on 3/27/15.
//
//

#import "TipconverterViewController.h"

@interface TipconverterViewController ()

@end

@implementation TipconverterViewController

- (void)viewDidLoad { // When the view loads, run this action.
    [super viewDidLoad]; // This NEEDS to be here or the application will not work!
   billTotal.delegate= self;
   // [_textName setText:[_party getPartyName]];

    pickerViewArray = [[NSMutableArray alloc] init]; // This will allocate tableViewArray.
    for(int i = 1; i <= 20; i ++) { // Set 'i' to every number from 1 and 20.
        NSString *myString = [NSString stringWithFormat:@"%d%%", i]; // Create a new string that will display the number 'i' followed by a percent sign.
        [pickerViewArray addObject:myString]; // Add the string to the tableViewArray.
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField { // When the return button is pressed on a textField.
    [textField resignFirstResponder]; // Remove the keyboard from the view.
    return YES; // Set the BOOL to YES.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView { // This method needs to be used. It asks how many columns will be used in the UIPickerView
    return 1; // We only need one column so we will return 1.
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component { // This method also needs to be used. This asks how many rows the UIPickerView will have.
    return [pickerViewArray count]; // We will need the amount of rows that we used in the pickerViewArray, so we will return the count of the array.
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component { // This method asks for what the title or label of each row will be.
    return [pickerViewArray objectAtIndex:row]; // We will set a new row for every string used in the array.
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component { // And now the final part of the UIPickerView, what happens when a row is selected.
    tipSelector = row + 1; // We will set the float 'tipSelected' to row + 1 because the row count starts at 0, so it is 1 number behind our array.
    tipSelector = tipSelector / 100; // We will now divide 'tipSelected' by 100 to give us the decimal value of the percentage.
    float tipTotal = [billTotal.text floatValue] * tipSelector; // Now we will set the tipTotal to the text inserted in the Bill Total UITextField multiplied by 'tipSelected'.
    tipAmount.text = [NSString stringWithFormat:@"Tip: Rs.%.2f", tipTotal]; // Set the tipAmount labels text to the tipTotal amount.
    
}
/*
- (IBAction)aboutAction { // The action called when the about button is clicked.
    UIAlertView * aboutView = [[UIAlertView alloc] initWithTitle:@"About" // Create a new UIAlertView named aboutScreen, and allocate it. Set the title to "About"
                                                         message:@"This application was made in under 30 minutes to learn about UIPickerViews\nAbout Screen text will go here!" // \n is a line break. Here we will store the message the Alert View displays.
                                                        delegate:self // Set the delegate to self.
                                               cancelButtonTitle:@"OK"  // Change the Cancel button's text to "OK".
                                               otherButtonTitles:nil, nil]; // Do no use any other buttons in the UIAlertView
    [aboutView show]; // Show the UIAlertView on the screen.
    [aboutView release]; // Release the UIAlertView from the memory.
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
