//
//  TVLoginVC.m
//  Cross-platform-todo-list
//
//  Created by Rio Balderas on 5/11/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import "TVLoginVC.h"
#import "FirebaseAPI.h"
#import "TVHomeViewController.h"

@interface TVLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;


@end

@implementation TVLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
 
- (IBAction)enterButtonPressed:(UIButton *)sender {
    NSString *currEmail = self.emailTextField.text;
    NSMutableArray *filtered = [NSMutableArray array];
    
    [FirebaseAPI fetchAllTodos:^(NSArray<Todo *> *allTodos) {
        for (Todo *todo in allTodos) {
            if ([todo.email isEqualToString:currEmail]) {
                [filtered addObject:todo];
                
            }
        }
        
        self.allTodos = filtered;
        self.userEmail = currEmail;
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
