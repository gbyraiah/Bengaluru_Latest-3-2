//
//  BengaluruBookTableViewCell.m
//  RecipeBook
//

#import "BengaluruBookTableViewCell.h"

@implementation BengaluruBookTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.imageView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width*0.5, 0, 50, 50);

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
