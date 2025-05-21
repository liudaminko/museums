//
//  Museum.swift
//  MuseumsMap
//
//  Created by Liudmyla Minkovets on 21.05.2025.
//

import Foundation
import CoreLocation

struct Museum: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let coordinate: CLLocationCoordinate2D
    let description: String
    let address: String
    let openingHours: String
}
