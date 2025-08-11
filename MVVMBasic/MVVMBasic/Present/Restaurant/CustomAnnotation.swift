//
//  CustomAnnotation.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/11/25.
//

import Foundation
import MapKit

final class CustomAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    @objc dynamic var coordinate: CLLocationCoordinate2D
    
    init(title: String? = nil, subtitle: String? = nil, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
