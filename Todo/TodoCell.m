//
//  TodoCell.m
//  Todo
//
//  Created by cyrus on 2/26/14.
//  Copyright (c) 2014 cyrus. All rights reserved.
//

#import "TodoCell.h"
#import "ToDo.h"

@implementation TodoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setToDo:(ToDo *)toDo {
    NSString *cellText = toDo.text;
    NSLog(@"Cell text: [%@]", cellText);
    self.textLabel.text = cellText;
    if (toDo.completed) {
        [self strikeOutCellText:cellText];
    }
}

- (void)strikeOutCellText:(NSString *)cellText {
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:cellText];
    [attributeString addAttribute:NSStrikethroughStyleAttributeName
                            value:@2
                            range:NSMakeRange(0, [attributeString length])];
    self.textLabel.attributedText = attributeString;
}
@end
