//
//  TVHomeViewController.m
//  Cross-platform-todo-list
//
//  Created by Rio Balderas on 5/9/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import "TVHomeViewController.h"
#import "FirebaseAPI.h"
//#import "Todo.h"

@interface TVHomeViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOulet UITableview *tableView;
@property(strong, nonatomic) NSArray<Todo *> *allTodos;

@end

@implementation TVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [FirebaseAPI fetchAllTodos:^(NSArray<Todo *> *allTodos){
        NSLog(@"%@", allTodos);
        
        self.allTodos = allTodos;
        [self.tableView reloadData];
    }];

self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.allTodos[indexPath.row].title;
    cell.detailTextlabel.text = self.allTodos[indexPath.row].content;
    
    return cell;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.allTodos.count;
}

@end
