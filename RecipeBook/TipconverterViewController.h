//
//  TipconverterViewController.h
//  Bengaluru
//
//  Created by Gouthami Byraiah on 3/27/15.
//
//

#import <UIKit/UIKit.h>

@interface TipconverterViewController : UIViewController {
    
    
    NSMutableArray *pickerViewArray;
    float tipSelector;
    IBOutlet UIPickerView * tipPicker;
    IBOutlet UILabel * tipAmount;
    IBOutlet UITextField * billTotal;
}

@end
