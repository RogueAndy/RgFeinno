//
//  ColViewController.m
//  RgFeinno
//
//  Created by rogue on 2017/6/26.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "ColViewController.h"

@interface ColCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *showSth;

@end

@implementation ColCell

- (instancetype)initWithFrame:(CGRect)frame {

    if(self = [super initWithFrame:frame]) {
    
        self.backgroundColor = [UIColor whiteColor];
        [self loadViews];
        [self loadLayouts];
        
    }
    
    return self;

}

- (instancetype)init {

    if(self = [super init]) {
    
        self.backgroundColor = [UIColor whiteColor];
        [self loadViews];
        [self loadLayouts];
        
    }
    
    return self;

}

- (void)loadViews {

    _showSth = [[UILabel alloc] init];
    _showSth.textAlignment = NSTextAlignmentCenter;
    _showSth.backgroundColor = [UIColor whiteColor];
    _showSth.textColor = [UIColor blackColor];
    _showSth.font = [UIFont systemFontOfSize:26];
    [self.contentView addSubview:_showSth];
    
}

- (void)loadLayouts {

    _showSth.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds) / 2.0, CGRectGetHeight(self.bounds) / 2.0);

}

@end


@interface ColViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collect;

@property (nonatomic, strong) NSArray *datas;

@end

@implementation ColViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    self.datas = @[@"11", @"22", @"33", @"44", @"55", @"66", @"77"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collect = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collect.delegate = self;
    _collect.dataSource = self;
    _collect.pagingEnabled = YES;
    [_collect registerClass:[ColCell class] forCellWithReuseIdentifier:@"ColCell"];
    [_collect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"reusableView"];
    _collect.contentSize = CGSizeMake(self.datas.count * CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    [self.view addSubview:_collect];
    
    _collect.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64);
}

#pragma mark - delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

//    return 1;
    return self.datas.count;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 1;
//    return self.datas.count;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 110);

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    return CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    ColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ColCell" forIndexPath:indexPath];
    if(!cell) {
    
        cell = [[ColCell alloc] init];
    
    }
    NSLog(@"cellForItemAtIndexPath ------ : %ld", indexPath.section);
    cell.showSth.text = self.datas[indexPath.section];
    
    return cell;

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    headerView.backgroundColor =[UIColor grayColor];
    UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
    label.text = @"这是collectionView的头部";
    label.font = [UIFont systemFontOfSize:20];
    [headerView addSubview:label];
    return headerView;
}

@end
