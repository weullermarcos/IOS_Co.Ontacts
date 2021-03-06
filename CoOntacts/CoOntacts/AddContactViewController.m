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

#define IPHONE5HEIGHT (568)


@interface AddContactViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property CGFloat currentWidth;
@property CGFloat currentHeight;

@end

@implementation AddContactViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _currentHeight = self.view.bounds.size.height;
    _currentWidth = self.view.bounds.size.width;
    

    
    //Tornando a imagem clicavel
    [self.userImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadImage:)];
    
    [self.userImage addGestureRecognizer:tap];
    
    [self.name setDelegate:self];
    [self.phone setDelegate:self];
    [self.email setDelegate:self];
    [self.contactDescription setDelegate:self];
    
}


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

- (IBAction)TouchDown:(id)sender{

    [self.name resignFirstResponder];
    [self.phone resignFirstResponder];
    [self.email resignFirstResponder];
    [self.contactDescription resignFirstResponder];
    
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
        
        //Setando latitude e longitude de Brasilia como default
        [contato setLatitude:@"-15.000"];
        [contato setLongitude:@"-47.000"];
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
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Alerta"
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //retorna para a tela anterior caso tenha sido inserido com sucesso
                             if(sucess)
                                 [self.navigationController popViewControllerAnimated:YES];
                         }];
    
    [alert addAction:ok];
    
    
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    if (textField == self.name) {
        
        [self.phone becomeFirstResponder];
    }
    
    if (textField == self.phone) {
        
        [self.email becomeFirstResponder];
    }
    
    if (textField == self.email) {
        
        [self.contactDescription becomeFirstResponder];
    }
    
    if (textField == self.contactDescription) {
        
        [textField resignFirstResponder]; //isso faz o teclado se esconder
    }
    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    
    if (textField == self.contactDescription && _currentHeight <= IPHONE5HEIGHT) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                     name:UIKeyboardDidShowNotification object:nil];
    }
    
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (textField == self.contactDescription && _currentHeight <= IPHONE5HEIGHT) {
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
                                                     name:UIKeyboardDidHideNotification object:nil];
        
        [self.view endEditing:YES];
        
    }

    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{

    [self.view setFrame:CGRectMake(0,-110,_currentWidth,_currentHeight)];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    
    [self.view setFrame:CGRectMake(0,0,_currentWidth,_currentHeight)];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end







