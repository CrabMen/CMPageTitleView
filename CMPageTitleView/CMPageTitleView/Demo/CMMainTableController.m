//
//  CMMainTableController.m
//  CMPageTitleView
//
//  Created by 智借iOS on 2019/4/10.
//  Copyright © 2019 CrabMan. All rights reserved.
//

#import "CMMainTableController.h"
#import "CMViewController.h"
@interface CMMainTableController ()

/**样式数组*/
@property (nonatomic,strong) NSArray *styleArray;


@end

@implementation CMMainTableController


-(NSArray *)styleArray {
    if (!_styleArray) {
        _styleArray = @[@"今日头条",@"网易新闻",@"腾讯视频",@"喜马拉雅"];
    }
    
    return _styleArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"CMPageTitleView";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.styleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.styleArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            {
               CMViewController *vc0 = [CMViewController new];
                [vc0 style0];
                vc0.title = self.styleArray[indexPath.row];
                [self.navigationController pushViewController:vc0 animated:YES];
            }
            break;
            
        case 1:
            {
                CMViewController *vc0 = [CMViewController new];
                vc0.title = self.styleArray[indexPath.row];

                [vc0 style1];
                [self.navigationController pushViewController:vc0 animated:YES];
            }
            break;
            
        case 2:
            
            {
                CMViewController *vc0 = [CMViewController new];
                vc0.title = self.styleArray[indexPath.row];

                [vc0 style2];
                [self.navigationController pushViewController:vc0 animated:YES];
            }
           
            break;
            
        case 3:
            {
                CMViewController *vc0 = [CMViewController new];
                vc0.title = self.styleArray[indexPath.row];

                [vc0 style3];
                [self.navigationController pushViewController:vc0 animated:YES];
            }
            break;
            
        default:
            break;
    }
    
    
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
