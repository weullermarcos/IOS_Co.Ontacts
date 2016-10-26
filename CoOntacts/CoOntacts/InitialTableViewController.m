//
//  InitialTableViewController.m
//  CoOntacts
//
//  Created by Hoff Silva on 14/09/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import "InitialTableViewController.h"
#import "AppDelegate.h"
#import "Contato+CoreDataClass.h"

@interface InitialTableViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation InitialTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Contatos"];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

// Método para recuperar dados do BD
- (NSFetchedResultsController *)fetchedResultsController {
    
    if (!_fetchedResultsController) {
        
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSPersistentContainer *persistentContainer = delegate.persistentContainer;
        
        NSFetchRequest *fetchRequest = [Contato fetchRequest];
        [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES]]];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:persistentContainer.viewContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
        [_fetchedResultsController setDelegate:self];
    }
    return _fetchedResultsController;
    
}

// Vai aparecer
- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSError *erro;
    
    if( [self.fetchedResultsController performFetch:&erro] ){
        
        //Sucesso
        [self.tableView reloadData];
        
    }
    else{
        
        //erro
        NSLog(@"Erro ao recuperar pessoas");
        
    }
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.fetchedResultsController.sections.count;

}

//Retorna o número de elementos que será apresentado na tablea
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
}

//Configura a celula que sera mostrada na tabela
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celulaPadrao" forIndexPath:indexPath];
    
    Contato *contato = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Exibe o nome do contato na célula
    [cell.textLabel setText:contato.nome];
    
    return cell;
    
}


- (void) configurarCelula: (UITableViewCell *) cell noIndexPath: (NSIndexPath *) indexPath {
    Contato *contato = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.textLabel setText:contato.nome];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Apagando itens
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Contato *contato = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.fetchedResultsController.managedObjectContext deleteObject:contato];
        
        NSError *erroCoreData;
        
        if (![self.fetchedResultsController.managedObjectContext save:&erroCoreData]) {
            NSLog(@"Deu erro: %@", erroCoreData);
        }
    }
    
}

#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            if (newIndexPath) {
                [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            break;
        case NSFetchedResultsChangeDelete:
            if (indexPath) {
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            break;
        case NSFetchedResultsChangeUpdate:
            [self configurarCelula:[self.tableView cellForRowAtIndexPath:indexPath] noIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
