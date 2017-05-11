//
//  FirebaseAPI.h
//  Cross-platform-todo-list
//
//  Created by Rio Balderas on 5/10/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Todo.h"

typedef void(^TodosCompletion)(NSArray<Todo *> *allTodos);


@interface FirebaseAPI : NSObject

+(void)fetchAllTodos:(AllTodosCompletion)completion;

@end
