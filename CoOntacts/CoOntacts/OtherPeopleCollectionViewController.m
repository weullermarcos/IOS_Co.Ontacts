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
    
    NSArray *names;

}

@end

@implementation OtherPeopleCollectionViewController

static NSString * const reuseIdentifier = @"ContactCell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"Pessoas que usam Co.Ontacts"];
    
    
    
    // Initialize array
    photos = [NSArray arrayWithObjects:
              @"user0", @"user1", @"user2", @"user3", @"user4", @"user5",
              @"user6", @"user7", @"user8", @"user9", @"user10", @"user11",
              @"user12", @"user13", @"user14", @"user15", @"user16", @"user17",
              @"user18",@"user19",@"user20",
              nil];
    
    // Initialize array
    names = [NSArray arrayWithObjects:
              @"Maria", @"João", @"Pedro", @"Tiago", @"Joana", @"Alice",
              @"Talita", @"Paula", @"Muhamed", @"Otávio", @"Flávia", @"Lucas",
              @"Augusto", @"Stevan", @"Ailton", @"Tião", @"Marcelo", @"Iona",
              @"Afonso",@"Amanda",@"Tadeu",
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

    
    ContactCollectionViewCell *cell = (ContactCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.contactImage.image = [UIImage imageNamed:[photos objectAtIndex:indexPath.row]];
    
    cell.contactName.text = [names objectAtIndex:indexPath.row];
    
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
