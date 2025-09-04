//
//  MathCateGoryCollectionViewController.m
//  LearnMath
//
//  Created by 基 on 2025/9/2.
//

#import "MathCateGoryCollectionViewController.h"
@interface MathCateGoryCollectionViewController ()

@end

@implementation MathCateGoryCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [MathNavigationBarManager configureNavigationViewController:self withMathCategory:self.category];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    switch (self.category)
    {
        case mathCategoryAddition:
            self.skills = @[@"Column vertical form(add)",@"Make-Ten",@"Decomposition and compensation",@"Moving the numbers",@"Finding the base number"];
            break;
        case mathCategorySubtraction:
            self.title = @"Subtraction";
            self.skills = @[@"Column vertical Form(sub)",@"Break-Ten",@"Moving the numbers",@"Making up interal"];
            break;
        case mathCategoryMultiplication:
            self.title = @"Multiplication";
            self.skills = @[@"Multiplication Table",@"Column vertical form(mul)",@"Everal tens and one",@"Decomposing terms",@"Plus 5 or 25"];
            break;
        case mathCategoryDivision:
            self.title = @"Division";
            self.skills = @[@"Division Table",@"Column vertical Form(sub)",@"Divded by 5 or 25",@"Decomposing terms"];
            break;
    }
    self.collectionView.layer.cornerRadius = LearnMathScale(30.0);
    self.collectionView.layer.masksToBounds = YES;
    self.collectionView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.collectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.collectionView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [self.collectionView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    UIColor *navColor = [MathNavigationBarManager configureNavigationViewController:self withMathCategory:self.category];
    self.view.backgroundColor = navColor;
    [self.collectionView registerClass:[MathCateGoryViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.skills.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MathCateGoryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.titleLabel.text = self.skills[indexPath.row];
            // Configure the cell
            
    return cell;
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
