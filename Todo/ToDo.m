//
//  ToDo.m
//  Todo
//
//  Created by cyrus on 2/25/14.
//  Copyright (c) 2014 cyrus. All rights reserved.
//

#import "ToDo.h"

@implementation ToDo
-(id) initWithText:(NSString *)todoText{
    self = [super init];
    if(self){
        self.text = todoText;
        self.completed = false;
    }
    return self;
}
@end
