//
//  NewTodoViewController.m
//  Cross-platform-todo-list
//
//  Created by Rio Balderas on 5/10/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import "NewTodoViewController.h"
#import "ViewController.h"
#import <UIKit/UIKit.h>

@import Firebase;
@import FirebaseAuth;

@interface NewTodoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;


@end

@implementation NewTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)addTodoButtonPressed:(id)sender {
    FIRDatabaseReference *databaseReference = [[FIRDatabase database]reference];
    FIRUser *currentUser = [[FIRAuth auth] currentUser];
    
    FIRDatabaseReference *userReference = [[databaseReference child:@"users"]child:currentUser.uid];
    FIRDatabaseReference *newTodoReference = [[userReference child:@"todos"]childByAutoId];
    
    [[newTodoReference child:@"title"] setValue:self.titleTextField.text];
    [[newTodoReference child:@"content"] setValue:self.contentTextField.text];
    
    ViewController *topContraint = [[ViewController alloc]init];
    topContraint.topConstraint.constant = -150;

}



@end
