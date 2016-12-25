//
//  ContactMapViewController.m
//  CoOntacts
//
//  Created by Weuller Marcos on 23/12/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import "ContactMapViewController.h"
#import "MapPin.h"

@import MapKit;
@import CoreLocation;

@interface ContactMapViewController () <CLLocationManagerDelegate>

@property (strong,nonatomic) CLLocationManager* locationManager;

@end

@implementation ContactMapViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setTitle:@"Mapa"];
    
    _locationManager = [[CLLocationManager alloc] init];
    
    [_locationManager setDelegate:self];
    
    //Mostra a localizacao do usuario
    [self.contactMap setShowsUserLocation:YES];

}


-(void) viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    //verifica se nao esta autorizado oara perguntar ao usuario se ele autoriza
    if(status == kCLAuthorizationStatusNotDetermined){
        
        //Autorizacao para quando estiver em uso
        [_locationManager requestWhenInUseAuthorization];
        
        //autorizacao para sempre
        [_locationManager requestAlwaysAuthorization];
        
    }
    
    double latitude = [self.contact.latitude doubleValue];
    double longitude = [self.contact.longitude doubleValue];
    
    if(latitude == 0 || longitude == 0){
    
    
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Alerta"
                                      message:@"O contato selecionado não possui dados corretos de localização"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {}];
        
        [alert addAction:ok];
    
    }
    else{
        
        //Configura coordenadas do contato
        CLLocationCoordinate2D contactCoordinate;
        contactCoordinate.latitude = latitude;
        contactCoordinate.longitude = longitude;
        
        //Criando Pin
        MapPin *pin = [[MapPin alloc] init];
        pin.subtitle = @"";
        pin.title = self.contact.nome;
        
        [self.contactMap addAnnotation:pin];
        pin.coordinate = contactCoordinate;

        
//        Configura centro do mapa para a localizacao do contato
//        MKCoordinateRegion region;
////        MKCoordinateSpan span;
//        
////        span.latitudeDelta = 0.010;
////        span.longitudeDelta = 0.010;
//        
////        region.span = span;
//        region.center = contactCoordinate;
//        [self.contactMap setRegion:region animated:YES];
    
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
