//
//  FirebaseAPI.m
//  Cross-platform-todo-list
//
//  Created by Rio Balderas on 5/10/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import "FirebaseAPI.h"
#import "Credentials.h"

@implementation FirebaseAPI

+(void)fetchAllTodos:(AllTodosCompletion)completion{
    //                                                                                                  ? is end of url and beginning of query string
    NSString *urlString = [NSString stringWithFormat:@"https://todo-list-e9f10.firebaseio.com/users.json?auth%@", APP_KEY];
    
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];//ephmeral means it will happen only once, ignore caching mechanism
    
    [[session dataTaskWithURL:databaseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
//        NSLog(@"ROOT OBJECT:%@", rootObject);
        
        NSMutableArray *allTodos = [[NSMutableArray alloc]inti];
        //                                                   bypasses the keys to read all values in json
        for (NSDictionary *userTodosDictionary in [rootObject allValues]) {
            //
            NSArray *userTodos = [userTodosDictionary[@"todos"] allValues];//will get all values for todos
            
//            NSLog(@"%@", userTodos);
            for (NSDictionary *todoDictionary in userTodos) {
                Todo *newTodo = [[Todo alloc]init];
                newTodo.title = todoDictionary[@"title"];//grabs the value for the key of title key
                newTodo.content = todoDictionary[@"content"];//grabs the value for the content key
                //can assign other properties here
                
                [allTodos addObject:newTodo];
            }
        }
        
        if (completion) {
//            //this is using operation queues, and usese more memory
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                completion(allTodos);
//                
//            }];
            
            
            //more quicker and lighweight
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(allTodos);
            })
        }
        
    }] resume];//resume is needed for data tasks to fire, aka start
    
    
}



@end
