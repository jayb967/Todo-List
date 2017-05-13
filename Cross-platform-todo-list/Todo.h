//
//  Todo.h
//  Cross-platform-todo-list
//
//  Created by Rio Balderas on 5/10/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property(strong, nonatomic) NSString *email;
@property(strong, nonatomic) NSString *uid;
@property(nonatomic) BOOL isCompleted;

@end
