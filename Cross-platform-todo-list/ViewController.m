//
//  ViewController.m
//  Cross-platform-todo-list
//
//  Created by Rio Balderas on 5/9/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "Todo.h"
#import "TodoTableViewCell.h"
#import "NewTodoViewController.h"
@import FirebaseAuth;

@import Firebase;

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(strong, nonatomic) FIRDatabaseReference *userReference;
@property(strong, nonatomic) FIRUser *currentUser;
@property (strong, nonatomic) NSMutableArray *allTodos;
@property (weak, nonatomic) IBOutlet UITableView *todoTableView;

@property(nonatomic)FIRDatabaseHandle allTodosHandler;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.todoTableView.delegate = self;
    self.todoTableView.dataSource = self;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self checkUserStatus];
    
}

-(void)checkUserStatus{
    if (![[FIRAuth auth] currentUser]) {
        LoginViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        [self presentViewController:loginController animated:YES completion:nil];
        
    } else {
        [self setupFirebase];
        [self startMonitoringTodoUpdates];
    }
}

-(void)setupFirebase{
    FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
    self.currentUser = [[FIRAuth auth] currentUser];
    
    self.userReference = [[databaseReference child:@"users"]child:self.currentUser.uid];
    NSLog(@"user reference %@", self.userReference);
}

-(void)startMonitoringTodoUpdates{
    self.allTodosHandler = [[self.userReference child:@"todos"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        self.allTodos = [[NSMutableArray alloc]init];
        
        for (FIRDataSnapshot *child in snapshot.children) {
            NSDictionary *todoData = child.value;
            
            NSString *todoTitle = todoData[@"title"];
            NSString *todoContent = todoData[@"content"];
            
            Todo *currentTodo = [[Todo alloc] init];
            currentTodo.title = todoTitle;
            currentTodo.content = todoContent;
            [self.allTodos addObject:currentTodo];
        }
        [self.todoTableView reloadData];
    }];
}

- (IBAction)addTodoButtonPressed:(UIBarButtonItem *)sender {
    if (self.topConstraint.constant == -150) {
        self.topConstraint.constant = 0;
    } else {
        self.topConstraint.constant = -150;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"%@",self.allTodos);
        [self.allTodos removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allTodos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Todo *currentCell = self.allTodos[indexPath.row];
    
    cell.titleCellLabel.text = currentCell.title;
    cell.contentCellLabel.text = currentCell.content;
    
    
    return cell;
}


@end
