//
//  AddContactViewController.m
//  CoOntacts
//
//  Created by Weuller Marcos on 13/11/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import "AddContactViewController.h"
#import "AppDelegate.h"
#import "Contato+CoreDataClass.h"


@interface AddContactViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation AddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //Tornando a imagem clicavel
    [self.userImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadImage:)];
    
    [self.userImage addGestureRecognizer:tap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//Carrega imagem da galeria
- (IBAction)uploadImage:(id)sender {
    
    //importante ir no arquivo info.plist e adicionar permissão para acessar albúm de fotos:
    //Privacy - Photo Library Usage Description
    
    UIImagePickerController * picker = [UIImagePickerController new];
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [picker setDelegate:self];
    
    [self presentViewController:picker animated:YES completion:nil];
    
}

//Metodo executado após selecionar foto
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *imagem = info[UIImagePickerControllerOriginalImage];
    
    [self.userImage setImage:imagem];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


//Volta para a tela anterior
- (IBAction)cancel:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//Cadastra um novo Contato
- (IBAction)createUser:(id)sender {
    
    NSMutableString *message = [NSMutableString new];
    
    Boolean sucess = false;
    
    //faz trim e verifica se a string nome está vazia
    if( [[self.name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 ){
    
        [message setString:@"O campo Nome é de preenchimento obrigatório"];
        
    }
    //faz trim e verifica se a string telefone está vazia
    else if( [[self.phone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 ){
      
        [message setString:@"O campo Telefone é de preenchimento obrigatório"];
    }
    else{
        
        AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        
        NSPersistentContainer *containerPersistencia = delegate.persistentContainer;
        
        //Criando contexto
        NSManagedObjectContext *context = containerPersistencia.viewContext;
        
        
        //Criando um novo objeto do tipo contato para ser inserido no BD
        Contato *contato = [NSEntityDescription insertNewObjectForEntityForName:@"Contato"
                                                         inManagedObjectContext:context];
        
        [contato setNome:self.name.text];
        [contato setEmail:self.email.text];
        [contato setTelefone:self.phone.text];
        [contato setDescricao:self.contactDescription.text];
        
        //Salvando a Imagem
        [contato setImagem: UIImagePNGRepresentation(self.userImage.image)];
        
        
        NSError *errorCoreData;
        
        
        
        if([context save:&errorCoreData]){
            
            [message setString:@"Contato cadastrado com sucesso"];
            sucess = true;
            
        }
        else{
            
            [message setString:@"Erro ao cadastrar contato"];
            sucess = false;
        }
        
    }

    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alerta"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    //retorna para a tela anterior caso tenha sido inserido com sucesso
    if(sucess)
        [self.navigationController popViewControllerAnimated:YES];
    
}



@end







