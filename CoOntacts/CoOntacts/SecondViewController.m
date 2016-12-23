//
//  SecondViewController.m
//  CoOntacts
//
//  Created by ALUNO on 10/08/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"
#import "Contato+CoreDataClass.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self applyBackgroudColor];
    
}


- (void) applyBackgroudColor{
    
    // Create the colors
    //255 165 000
    UIColor *bottomColor = [UIColor colorWithRed:255.0/255.0 green:200.0/255.0 blue:50.0/255.0 alpha:1.0];
    
    //255 140 000
    UIColor *topColor = [UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:0.0/255.0 alpha:1.0];
    
    
    // Create the gradient
    CAGradientLayer *theViewGradient = [CAGradientLayer layer];
    theViewGradient.colors = [NSArray arrayWithObjects: (id)bottomColor.CGColor, (id)topColor.CGColor, nil];
    theViewGradient.frame = self.view.bounds;
    
    //Add gradient to view
    [self.view.layer insertSublayer:theViewGradient atIndex:0];
    
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

- (IBAction)LoginAction:(id)sender {
    
    if([self.txtLogin.text isEqual: @"weuller"] && [self.txtPassword.text isEqual: @"123"]){
    
        //Inserir usuários na base local
        //[self insereDadosCarga];
        
        //Direciona para a proxima tela
        [self performSegueWithIdentifier:@"segueLoginSuccess" sender:self];
        
    }
    else{
        

        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Alerta"
                                      message:@"Os dados de acesso estão incorretos utilize login: weuller senha: 123"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        
    }
    
}

- (void) insereDadosCarga{
    
    
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSPersistentContainer *containerPersistencia = delegate.persistentContainer;
    
    //Criando contexto
    NSManagedObjectContext *context = containerPersistencia.viewContext;
    
    for (int i=0; i < 5; i++) {
        
        //Criando um novo objeto do tipo contato para ser inserido no BD
        Contato *contato = [NSEntityDescription insertNewObjectForEntityForName:@"Contato"
                                                         inManagedObjectContext:context];
        
        NSMutableString  *nome = [[NSMutableString alloc] init];
        
        [nome appendString:@"Contato "];
        [nome appendString: [NSString stringWithFormat:@"%i", i]];
        
        
        [contato setNome:nome];
        [contato setEmail:@"Usuario@empresa.com"];
        [contato setTelefone:@"3333-3554"];
        [contato setDescricao:@"Descricao x"];
        //[contato setReceberNotificacoes:true];
        
        
        NSError *errorCoreData;
        
        if([context save:&errorCoreData]){
            
            NSLog(@"Dados salvos com sucesso");
            
        }
        else{
            
            NSLog(@"Erro ao salvar dados");
            
        }
        
    }
    
}



@end
