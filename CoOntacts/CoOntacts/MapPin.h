//
//  MapPin.h
//  CoOntacts
//
//  Created by Weuller Marcos on 23/12/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapPin : NSObject <MKAnnotation>

@property(nonatomic,assign) CLLocationCoordinate2D coordinate;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *subtitle;

@end
