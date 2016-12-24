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

@interface ContactMapViewController ()

@end

@implementation ContactMapViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setTitle:@"Mapa"];

}


-(void) viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    
    double latitude = [self.contact.latitude doubleValue];
    double longitude = [self.contact.longitude doubleValue];
    
    
    //Configura coordenadas do contato
    CLLocationCoordinate2D contactCoordinate;
    contactCoordinate.latitude = latitude;
    contactCoordinate.longitude = longitude;
    
    
//    MKCoordinateSpan zoom;
//    zoom.latitudeDelta = .1f; //the zoom level in degrees
//    zoom.longitudeDelta = .1f;//the zoom level in degrees
    
    
//    MKCoordinateRegion myRegion;
//    myRegion.center = contactCoordinate;
//    myRegion.span = zoom;
    
    //Criando Pin
    MapPin *pin = [[MapPin alloc] init];
    pin.subtitle = @"";
    pin.title = self.contact.nome;
    
    [self.contactMap addAnnotation:pin];
    pin.coordinate = contactCoordinate;
    
    
}


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
