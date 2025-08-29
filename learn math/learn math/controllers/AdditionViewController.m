//
//  additionViewController.m
//  learn math
//
//  Created by 基 on 2025/8/28.
//

#import "AdditionViewController.h"
#import "AdditionModels.h"
#import "AdditionCell.h"
@interface AdditionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *addition;
@end

@implementation AdditionViewController
#pragma mark - 懒加载
- (NSArray *)addition{
    if (_addition==nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"addition.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict in arrayDict) {
            AdditionModels *models = [AdditionModels additionWithDict:dict];
            [arrayModels addObject:models];
        }
        _addition = arrayModels;
    }
    return _addition;
}
- (void)viewDidLoad {
    [super viewDidLoad];
        self.tableView.rowHeight = 60;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addition.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AdditionModels *addition = self.addition[indexPath.row];
    static NSString *ID=@"Cell_ID";
    AdditionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.addition = addition;
    return cell;
}


@end
