//
//  CMMainTableController.m
//  CMPageTitleView
//
//  Created by CrabMan on 2019/4/10.
//  Copyright © 2019 CrabMan. All rights reserved.
//

#import "CMMainTableController.h"
#import "CMViewController.h"
@interface CMMainTableController ()

/**样式数组*/
@property (nonatomic,strong) NSArray *styleArray;

/**组合效果*/
@property (nonatomic,strong) NSArray *mixStyleArray;


@end

@implementation CMMainTableController


-(NSArray *)styleArray {
    if (!_styleArray) {
        _styleArray =@[@{
                           @"title":@"基本样式",
                           @"array":@[
                                   
                                   @"颜色效果 - RGB渐变",
                                   @"颜色效果 - 填充渐变",
                                   @"颜色效果 - 无渐变",
                                   
                                   @"切换样式 - 字体放大",
                                   @"切换样式 - 下划线",
                                   @"切换样式 - 遮罩",
                                   @"切换样式 - 字体放大 - 延迟",
                                   @"切换样式 - 下划线 - 延迟",
                                   @"切换样式 - 遮罩 - 延迟",
                                   
                                   @"附加效果 - 标题栏下方分割线",
                                   @"附加效果 - 标题文字之间分割线",
                                   
                                   @"对齐方式 -- 左对齐",
                                   @"对齐方式 -- 右对齐",
                                   @"对齐方式 -- 居中",
                                   @"对齐方式 -- SpaceAround",
                                   
                                   @"字体放大效果时对其方式 -- 居中对齐（默认）",
                                   @"字体放大效果时对其方式 -- 上对齐",
                                   @"字体放大效果时对其方式 -- 下对齐"
                                   
                                   ]},
                       
                       @{
                           @"title":@"组合样式",
                           @"array":@[
                                   
                                   @"字体放大 - 颜色RGB渐变",
                                   @"字体放大 - 颜色填充渐变",
                                   @"字体放大 - 颜色无渐变",
                                   @"字体放大(延迟) - 颜色RGB渐变",
                                   @"字体放大(延迟) - 颜色填充渐变",
                                   @"字体放大(延迟) - 颜色无渐变",
                                   
                                   @"下划线 - 颜色RGB渐变",
                                   @"下划线 - 颜色填充渐变",
                                   @"下划线 - 颜色无渐变",
                                   @"下划线(延迟) - 颜色RGB渐变",
                                   @"下划线(延迟) - 颜色填充渐变",
                                   @"下划线(延迟) - 颜色无渐变",
                                   
                                   @"下划线（固定宽度）- 颜色RGB渐变",
                                   @"下划线（固定宽度）- 颜色填充渐变",
                                   @"下划线（固定宽度）- 颜色无渐变",
                                   @"下划线（延迟 && 固定宽度）- 颜色RGB渐变",
                                   @"下划线（延迟 && 固定宽度）- 颜色填充渐变",
                                   @"下划线（延迟 && 固定宽度）- 颜色无渐变",
                                   
                                   @"下划线（比例宽度）- 颜色RGB渐变",
                                   @"下划线（比例宽度）- 颜色填充渐变",
                                   @"下划线（比例宽度）- 颜色无渐变",
                                   @"下划线（延迟 && 比例宽度）- 颜色RGB渐变",
                                   @"下划线（延迟 && 比例宽度）- 颜色填充渐变",
                                   @"下划线（延迟 && 比例宽度）- 颜色无渐变",
                                   
                                   @"下划线（延展）- 颜色RGB渐变",
                                   @"下划线（延展）- 颜色填充渐变",
                                   @"下划线（延展）- 颜色无渐变",
                                   @"下划线（延展 && 固定宽度）- 颜色RGB渐变",
                                   @"下划线（延展 && 固定宽度）- 颜色填充渐变",
                                   @"下划线（延展 && 固定宽度）- 颜色无渐变",
                                   @"下划线（延展 && 比例宽度）- 颜色RGB渐变",
                                   @"下划线（延展 && 比例宽度）- 颜色填充渐变",
                                   @"下划线（延展 && 比例宽度）- 颜色无渐变",
                                   
                                   @"遮罩 - 颜色RGB渐变",
                                   @"遮罩 - 颜色填充渐变",
                                   @"遮罩 - 颜色无渐变",
                                   @"遮罩(延迟) - 颜色RGB渐变",
                                   @"遮罩(延迟) - 颜色填充渐变",
                                   @"遮罩(延迟) - 颜色无渐变",
                                   
                                   @"遮罩（固定宽度）- 颜色RGB渐变",
                                   @"遮罩（固定宽度）- 颜色填充渐变",
                                   @"遮罩（固定宽度）- 颜色无渐变",
                                   @"遮罩（延迟 && 固定宽度）- 颜色RGB渐变",
                                   @"遮罩（延迟 && 固定宽度）- 颜色填充渐变",
                                   @"遮罩（延迟 && 固定宽度）- 颜色无渐变",
                                   
                                   @"字体放大 && 下划线 - 颜色填充渐变",
                                   @"字体放大 && 下划线 && 延迟 - 颜色无渐变",
                                   
                                   @"字体放大 && 下划线（延展）- 颜色填充渐变",
                                   @"字体放大 && 下划线（延展 && 固定宽度 ）- 颜色填充渐变",
                                   @"字体放大 && 下划线（延展 && 比例宽度 ）-颜色填充渐变",
                                   @"字体放大 && 下划线（延展 && 放大时下对齐 ）-颜色填充渐变",
                                   @"字体放大 && 下划线（延展 && 放大时下对齐 && 左对齐）-颜色填充渐变",
                                   
                                   
                                   ]
                           },
                       
                       
                       @{
                           @"title":@"其他样式",
                           @"array":@[
                                   @"标题栏背景色",
                                   @"标题栏背景图片",
                                   @"rightView",
                                   ]},
                       
                       ];
        
        
        
        
    }
    
    return _styleArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"CMPageTitleView";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
}


#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width, 40)];
    header.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:header.bounds];
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont boldSystemFontOfSize:18];
    
    label.text = self.styleArray[section][@"title"];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [header addSubview:label];
    
    return header;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.styleArray.count;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [self.styleArray[section][@"array"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%02ld-%02ld.%@",indexPath.section,indexPath.row,self.styleArray[indexPath.section][@"array"][indexPath.row]];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CMViewController *vc = [CMViewController new];
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"style%02ld_%02ld",indexPath.section,indexPath.row]);
    [vc performSelector:selector];
    
    [self.navigationController pushViewController:vc animated:YES];
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
