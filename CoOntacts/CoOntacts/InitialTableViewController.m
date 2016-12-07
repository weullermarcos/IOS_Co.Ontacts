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
#import "ContactTableViewCell.h"

@interface InitialTableViewController () <NSFetchedResultsControllerDelegate, NSURLSessionDataDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

//Propriedade para dados retornados do webservice
@property (strong, nonatomic) NSMutableData *bytesResposta;

@end

@implementation InitialTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Contatos"];
    
    self.tableView.delegate = self;
    
    UINib *cell = [UINib nibWithNibName:@"ContactTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cell forCellReuseIdentifier:@"ContactTableViewCell"];
    
    //Botao para adicionar novo contato
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(Add:)];
    
    //Instancia para fazer uma nova requisicao
    _bytesResposta = [NSMutableData new];
    
    
}

// Vai aparecer
- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    NSError *erro;
    
    if( [self.fetchedResultsController performFetch:&erro] ){
        
        //Verifica se não tem contatos cadastrados
        //se não tiver busca da Web
        if([[self.fetchedResultsController.sections objectAtIndex:0] numberOfObjects] == 0){
            
            [self getOnlineUsers];
            
        }
        else{
            
            //Sucesso
            [self.tableView reloadData];
        }

    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alerta"
                                                        message:@"Não foi possível recuperar os seus contatos"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
    }
    
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

- (void) getOnlineUsers{

    //Requisicao Web
    NSURLSessionConfiguration *sc =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sc
                                                          delegate:self
                                                     delegateQueue:nil];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:@"http://jsonplaceholder.typicode.com/users"]];
    
    [task resume];
    
    //Fim
    
}

//Direciona para a tela de novo contato
-(IBAction)Add:(id)sender
{
    //Direciona para a proxima tela
    [self performSegueWithIdentifier:@"segueAddContatct" sender:self];
    
}

//2
#pragma mark - NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    [_bytesResposta appendData:data];
}


//3
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error{
    
    if (error) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alerta"
                                                        message:@"Erro de conexão"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        NSLog(@"Erro de conexão: %@", error);
    }
    else {
        NSError *erroJSON;
        
        NSArray<NSDictionary *> *posts =
        [NSJSONSerialization JSONObjectWithData:_bytesResposta
                                        options:kNilOptions
                                          error:&erroJSON];
        
        if (erroJSON) {
            
            NSLog(@"JSON recebido é inválido: %@", erroJSON);
        }
        else {
            
            NSLog(@"Dados recebidos: %@", posts);
            
            for (NSDictionary *post in posts) {
                
                //NSLog(@"Usuario: %@", [post objectForKey:@"username"]);
                [self saveContact:post];
                
            }
            
            //recarrega os dados da tabela..
            [self.tableView reloadData];
            
        }
    }
}

//Método para inserir novo contato
-(void) saveContact: (NSDictionary*) contact{

    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSPersistentContainer *containerPersistencia = delegate.persistentContainer;
    
    //Criando contexto
    NSManagedObjectContext *context = containerPersistencia.viewContext;
    
    
    //Criando um novo objeto do tipo contato para ser inserido no BD
    Contato *contato = [NSEntityDescription insertNewObjectForEntityForName:@"Contato"
                                                     inManagedObjectContext:context];
    
    [contato setNome:[contact objectForKey:@"username"]];
    [contato setEmail:[contact objectForKey:@"email"]];
    [contato setTelefone:[contact objectForKey:@"phone"]];
    [contato setDescricao:[contact objectForKey:@"name"]];
    
    //TODO: salvar Imagem do usuário
    //[contato setImagem: UIImagePNGRepresentation(contact.userImage.image)];
    
    
    NSError *errorCoreData;
    
    if([context save:&errorCoreData]){
        
        NSLog(@"Contato cadastrado com sucesso");
        
    }
    else{
        
        NSLog(@"Erro ao cadastrar contato");
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

    
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactTableViewCell" forIndexPath:indexPath];
    
    Contato *contato = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [cell.contactName setText:contato.nome];
    [cell.contactPhone setText:contato.telefone];
    
    UIImage *image = [UIImage imageWithData:contato.imagem];
    
    //Seta a imagem recuperada
    [cell.contactImage setImage:image];
    
    return cell;
    
}


#pragma mark - UITableViewDelegate
//Retornar aqui a altura estimada da célula... olhe no XIB a altura.
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

//Faz a tableView aceitar células com alturas dinâmicas
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
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
