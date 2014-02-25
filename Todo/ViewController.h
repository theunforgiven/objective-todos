//
//  ViewController.h
//  Todo
//
//  Created by cyrus on 2/24/14.
//  Copyright (c) 2014 cyrus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *filterCompletedTodos;
@property (weak, nonatomic) IBOutlet UIButton *clearCompletedTasksButton;
@property (weak, nonatomic) IBOutlet UIButton *markAllCompleteButton;

@end
