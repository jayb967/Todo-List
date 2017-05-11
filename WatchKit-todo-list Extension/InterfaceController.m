//
//  InterfaceController.m
//  WatchKit-todo-list Extension
//
//  Created by Rio Balderas on 5/9/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import "InterfaceController.h"
#import "TodoRowController.h"
#import "Todo.h"


@interface InterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;
//                                    strong typed array with <Todo> array
@property (strong, nonatomic) NSArray<Todo *> *allTodos;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    [self setupTable];
}

-(void)setupTable{
    //                                                          this matches one in storyboard
    [self.table setNumberOfRows:self.allTodos.count withRowType:@"TodoRowController"];
    for (NSInteger i = 0; i < self.allTodos.count; i++) {
        TodoRowController *rowController = [self.table rowControllerAtIndex:i];
        
        [rowController.titleLabel setText:self.allTodos[i].title];
        [rowController.contentLabel setText:self.allTodos[i].content];
        
        
        
    }
//    for i in 0..self.allTodos.count{} this is the swift way to put it.
    
}

-(NSArray<Todo *> *)allTodos{
    Todo *firstTodo = [[Todo alloc]init];
    firstTodo.title = @"First Todo";
    firstTodo.content = @"This is a todo";
    
    Todo *secondTodo = [[Todo alloc]init];
    secondTodo.title = @"First Todo";
    secondTodo.content = @"This is a todo";
    
    Todo *thirdTodo = [[Todo alloc]init];
    thirdTodo.title = @"First Todo";
    thirdTodo.content = @"This is a todo";
    
    return @[firstTodo, secondTodo, thirdTodo];
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

-(void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex{
//this is when you click on a n index path
    
}
- (IBAction)newTodoPressed {
    
    NSArray *suggestions = @[@"Hello there", @"idk something", @"I dont know what to put here either, testing"];
    
    [self presentTextInputControllerWithSuggestions:suggestions allowedInputMode:WKTextInputModeAllowEmoji completion:^(NSArray * _Nullable results) {
        NSLog(@"%@", results);
    }];
}

@end



