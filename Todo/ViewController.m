//
//  ViewController.m
//  Todo
//
//  Created by cyrus on 2/24/14.
//  Copyright (c) 2014 cyrus. All rights reserved.
//

#import "ViewController.h"
#import "ToDo.h"


@implementation ViewController

NSMutableArray *toDos;
BOOL filterRows;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [_filterCompletedTodos addTarget:self action:@selector(filterCompletedChanged:) forControlEvents:UIControlEventValueChanged];
    [_clearCompletedTasksButton addTarget:self action:@selector(clearCompletedTasks)    forControlEvents:UIControlEventTouchUpInside];
    [_markAllCompleteButton addTarget:self action:@selector(markAllToDosComplete)    forControlEvents:UIControlEventTouchUpInside];
    toDos = [NSMutableArray arrayWithObjects:[[ToDo alloc] initWithText:@"This is a test"],
                                             [[ToDo alloc] initWithText:@"A different test"],
                                             [[ToDo alloc] initWithText:@"A FINAL TEST"],
                                             nil];
    filterRows = false;
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) filterCompletedChanged:(UISegmentedControl*)control {
    NSString* segment = [control titleForSegmentAtIndex:control.selectedSegmentIndex];
    filterRows = [segment isEqualToString:@"Hide"];
    [self reloadToDoData];
    NSLog(@"Filter completed changed %@ Filter Rows? %d", segment, (int)filterRows);
}
-(void)clearCompletedTasks {
    NSLog(@"Clearing completed tasks");
    NSPredicate *incompleteTodos = [NSPredicate predicateWithFormat:@"completed = false"];
    toDos = [NSMutableArray arrayWithArray:[toDos filteredArrayUsingPredicate:incompleteTodos]];
    [self reloadToDoData];
}
- (void)markAllToDosComplete {
    for (ToDo *todo in toDos) {
        todo.completed = true;
    }
    [self reloadToDoData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// This method is called once we click inside the textField
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"Text field did begin editing");
}

// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self addToDo: textField.text];
    textField.text = @"";
    NSLog(@"Text field ended editing");
}

-(void) addToDo:(NSString*)toDoText{
    NSLog(@"Adding ToDo with text:[%@]", toDoText);
    [toDos addObject:[[ToDo alloc] initWithText:toDoText]];
    [self reloadToDoData];
    NSLog(@"ToDos: %@", toDos);
}

- (void)reloadToDoData {
    [_tableView reloadData];
}

// This method enables or disables the processing of return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (NSArray*) filteredTodos {
    if (filterRows) {
        NSPredicate *incompleteTodos = [NSPredicate predicateWithFormat:@"completed = false"];
        return [toDos filteredArrayUsingPredicate:incompleteTodos];
    }
    return toDos;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count = [[self filteredTodos] count];
    NSLog(@"numberOfRowsInSection: %lu", (unsigned long) count);
    return count;
}

- (void)addGestureRecognizer:(UITableViewCell *)cell direction:(UISwipeGestureRecognizerDirection)direction action:(SEL)action {
    UISwipeGestureRecognizer* sgr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:action];
    [sgr setDirection:direction];
    [cell addGestureRecognizer:sgr];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellForRowAtIndexPath");
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }

    ToDo* todo = [[self filteredTodos] objectAtIndex:indexPath.row];
    [self setTextForCellCell:cell todo:todo];
    [self addGestureRecognizer:cell direction:UISwipeGestureRecognizerDirectionRight action: @selector(cellMarkCompleteSwipe:)];
    [self addGestureRecognizer:cell direction:UISwipeGestureRecognizerDirectionLeft action: @selector(cellMarkIncompleteSwipe:)];
    return cell;
}

- (void)setTextForCellCell:(UITableViewCell *)cell todo:(ToDo *)todo {
    NSString* cellText = todo.text;
    NSLog(@"Cell text: [%@]", cellText);
    cell.textLabel.text = cellText;
    if (todo.completed) {
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:cellText];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [attributeString length])];
        cell.textLabel.attributedText = attributeString;
    }
}

- (void)cellMarkCompleteSwipe:(UIGestureRecognizer *)gestureRecognizer {
    [self setCellCompleted:gestureRecognizer cellCompleted: YES];
}
- (void)cellMarkIncompleteSwipe:(UIGestureRecognizer *)gestureRecognizer {
    [self setCellCompleted:gestureRecognizer cellCompleted: NO];
}
- (void)setCellCompleted:(UIGestureRecognizer *)gestureRecognizer cellCompleted:(BOOL)completed {
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        UITableViewCell* cell = (UITableViewCell *)gestureRecognizer.view;
        NSIndexPath* indexPath = [_tableView indexPathForCell:cell];
        ToDo* todo = [[self filteredTodos] objectAtIndex:indexPath.row];
        NSLog(@"Todo Swiped: Complete? %d", (int)completed);
        todo.completed = completed;
        [self setTextForCellCell:cell todo:todo];
    }
    [self reloadToDoData];
}
@end
