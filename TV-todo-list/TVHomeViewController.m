//
//  TVHomeViewController.m
//  Cross-platform-todo-list
//
//  Created by Rio Balderas on 5/9/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import "TVHomeViewController.h"
#import "TVLoginVC.h"
#import "FirebaseAPI.h"
#import "Todo.h"
#import "TodoDetailViewController.h"

@interface TVHomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(strong, nonatomic) NSArray<Todo *> *allTodos;


@end

@implementation TVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.userEmail);
    
    [self checkUserStatus];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)checkUserStatus{
    if (self.userEmail == NULL) {
        TVLoginVC *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"TVLoginVC"];
        
        [self presentViewController:loginController animated:YES completion:nil];
        
    } else{
        
        [FirebaseAPI fetchAllTodos:^(NSArray<Todo *> *allTodos){
            NSLog(@"%@", allTodos);
            
            self.allTodos = allTodos;
            [self.tableView reloadData];
        }];
    }
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
////manual way of writing data to it without using firebase

//-(NSArray<Todo *> *)allTodos{
//    Todo *firstTodo = [[Todo alloc]init];
//    firstTodo.title = @"First Todo";
//    firstTodo.content = @"This is a todo";
//
//    Todo *secondTodo = [[Todo alloc]init];
//    secondTodo.title = @"First Todo";
//    secondTodo.content = @"This is a todo";
//
//    Todo *thirdTodo = [[Todo alloc]init];
//    thirdTodo.title = @"First Todo";
//    thirdTodo.content = @"This is a todo";
//
//    return @[firstTodo, secondTodo, thirdTodo];
//
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.allTodos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.allTodos[indexPath.row].title;
    cell.detailTextLabel.text = self.allTodos[indexPath.row].content;
    
    return cell;
}

@end
