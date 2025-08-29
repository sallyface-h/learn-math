//
//  ViewController.m
//  learn math
//
//  Created by 基 on 2025/8/28.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)jumpToAdditionView:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (IBAction)jumpToAdditionView:(id)sender {
    NSLog(@"dian");
    UIViewController *secondVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AdditionViewController"];
        [self.navigationController pushViewController:secondVC animated:YES];
}
@end
