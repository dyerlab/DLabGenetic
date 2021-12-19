//
//  dyerlab.org                                          @dyerlab
//                      _                 _       _
//                   __| |_   _  ___ _ __| | __ _| |__
//                  / _` | | | |/ _ \ '__| |/ _` | '_ \
//                 | (_| | |_| |  __/ |  | | (_| | |_) |
//                  \__,_|\__, |\___|_|  |_|\__,_|_.__/
//                        |_ _/
//
//         Making Population Genetic Software That Doesn't Suck
//
//  GeneticStudio
//  MKMapRect.swift
//
//  Created by Rodney Dyer on 10/27/21.
//  Copyright (c) 2021 Rodney J Dyer.  All Rights Reserved.
//

import Foundation
import MapKit

extension MKMapRect {
    
    
    static func fromCoordinateRegion(region: MKCoordinateRegion) -> MKMapRect {
    
        let topLeft = CLLocationCoordinate2D( latitude: region.center.latitude + (region.span.latitudeDelta/2),
                                              longitude: region.center.longitude - (region.span.longitudeDelta/2))
        
        let bottomRight = CLLocationCoordinate2D( latitude: region.center.latitude - (region.span.latitudeDelta/2),
                                                  longitude: region.center.longitude + (region.span.longitudeDelta/2))
        
        let a = MKMapPoint(topLeft)
        let b = MKMapPoint(bottomRight)
        
        return MKMapRect(origin: MKMapPoint( x: min(a.x,b.x),
                                             y: min(a.y,b.y)),
                         size: MKMapSize( width: abs(a.x-b.x),
                                          height: abs(a.y-b.y)))
    }
    
}
