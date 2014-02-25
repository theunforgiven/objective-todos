//
//  ToDo.h
//  Todo
//
//  Created by cyrus on 2/25/14.
//  Copyright (c) 2014 cyrus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDo : NSObject
@property NSString* text;
@property BOOL completed;
-(id) initWithText:(NSString *)todoText;
@end
