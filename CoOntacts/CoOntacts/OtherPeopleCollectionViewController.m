//
//  OtherPeopleCollectionViewController.m
//  CoOntacts
//
//  Created by Weuller Marcos on 25/12/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import "OtherPeopleCollectionViewController.h"
#import "ContactCollectionViewCell.h"

@interface OtherPeopleCollectionViewController (){

    NSArray *photos; //Criando array para guardar as fotos dos usuários

}

@end

@implementation OtherPeopleCollectionViewController

static NSString * const reuseIdentifier = @"ContactCell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"Pessoas que usam Co.Ontacts"];
    
    
    
    // Initialize array
    photos = [NSArray arrayWithObjects:
              @"user0.png", @"user1.png", @"user2.png", @"user3.png", @"user4.png", @"user5.png",
              @"user0.png", @"user1.png", @"user2.png", @"user3.png", @"user4.png", @"user5.png",
              @"user0.png", @"user1.png", @"user2.png", @"user3.png", @"user4.png", @"user5.png",
              nil];
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    //Retorna o número de objetos do array
    return [photos count];

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

//    static NSString *identifier = @"Cell";
//    
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//    
//    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
//    recipeImageView.image = [UIImage imageNamed:[photos objectAtIndex:indexPath.row]];
    
    
    
    ContactCollectionViewCell *cell = (ContactCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
//    NSString * imageName = [NSString stringWithFormat:@"user%ld.png",(long)indexPath.row];
//    
//    cell.contactImage.image = [UIImage imageNamed:imageName];
    
    cell.contactImage.image = [UIImage imageNamed:[photos objectAtIndex:indexPath.row]];
    
    [cell setBackgroundColor:[UIColor orangeColor]];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
