//
//  ContactMapViewController.h
//  CoOntacts
//
//  Created by Weuller Marcos on 23/12/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato+CoreDataClass.h"

@import MapKit;
@import CoreLocation;

@interface ContactMapViewController : UIViewController

@property(nonatomic) Contato *contact;

@property (weak, nonatomic) IBOutlet MKMapView *contactMap;

@end
