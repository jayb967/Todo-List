//
//  LoginViewController.m
//  Cross-platform-todo-list
//
//  Created by Rio Balderas on 5/10/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)loginButtonPressed:(id)sender {
//    //signout user with this 
//    NSError *signOutError;
//    [[FIRAuth auth] signOut:&signOutError];
    
    [[FIRAuth auth] signInWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error signing in: %@", error.localizedDescription);
        }
        if (user) {
            NSLog(@"Logged in User: %@", user);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    
}
- (IBAction)signupButtonPressed:(id)sender {
    [FIRAuth auth] createUserWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error signing up user: %@", error.localizedDescription);
        }
        if (user) {
            NSLog(@"Succesfully signed up: %@", user);
            //put somethin
        }
    }
    
}



@end
