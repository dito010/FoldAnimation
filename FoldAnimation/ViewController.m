//
//  ViewController.m
//  FoldAnimation
//
//  Created by Chris on 16/7/6.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"

@interface ViewController ()
/** header */
@property(nonatomic, strong)HeaderView *header;
/** headerFrame */
@property(nonatomic, assign)CGRect headerFrame;
@end

// 头部视图高度
const CGFloat headerHeight = 400;
// 层叠的覆盖速率
const CGFloat speed = 0.6; // speed <= 0
static NSString *reuseID = @"tableview";
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    HeaderView *header = [HeaderView viewFromXib];
    // 一定要将header插入到tableView的下面,才有层叠覆盖的效果
    [self.view insertSubview:header atIndex:0];
    self.header = header;
    
    // 给tableView顶部插入额外的滚动区域,用来显示头部视图
    self.tableView.contentInset = UIEdgeInsetsMake(headerHeight, 0, 0, 0);
    // 应用启动, 滚动到最顶部,显示额外的头部视图
    [self.tableView setContentOffset:CGPointMake(0, -headerHeight)];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseID];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    // 每次布局子控件的时候,都要更新头部视图的frame
    self.header.frame = self.headerFrame;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // 由于上面设置了应用额外的滚动区域,所以应用一启动就会来到这个方法
    // scrollView.contentOffset.y的值是添加的额外滚动的值headerHeight, 此时headerHeight * speed - headerHeight * (1 - speed) = headerHeight, 从而一启动的时候, 头部视图是按照我们想要的位置布局的
    // 以后当tableView滚动的时候, 头部视图就以我们滚动时的速度的speed倍滚动 , 把这个值保存到self.headerFrame, 在viewWillLayoutSubviews中更新头部视图的frame
    
    CGRect org = CGRectMake(0, -headerHeight, self.view.frame.size.width, headerHeight);
    org.origin.y = scrollView.contentOffset.y * speed - headerHeight * (1 - speed);
    self.headerFrame = org;
}
@end
