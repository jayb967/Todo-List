//
//  TodoTableViewCell.h
//  Cross-platform-todo-list
//
//  Created by Rio Balderas on 5/11/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@interface TodoTableViewCell : UITableViewCell

@property (strong, nonatomic) Todo *todo;
@property (weak, nonatomic) IBOutlet UILabel *titleCellLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentCellLabel;


@end
