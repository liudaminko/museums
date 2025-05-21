//
//  MuseumLibreMapView.swift
//  MuseumsMap
//
//  Created by Liudmyla Minkovets on 21.05.2025.
//

import SwiftUI
import MapLibre

struct MuseumLibreMapView: UIViewRepresentable {
    @ObservedObject var locationManager: LocationManager
    let museums: [Museum]
    let onSelectMuseum: (Museum) -> Void

    func makeUIView(context: Context) -> MLNMapView {
        let mapView = MLNMapView(frame: .zero)
        mapView.styleURL = URL(string: "https://api.maptiler.com/maps/streets/style.json?key=BWZDOlepKGykUPlraLlR")
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ mapView: MLNMapView, context: Context) {
        if let coordinate = locationManager.userLocation {
            mapView.setCenter(coordinate, zoomLevel: 13, animated: true)
        }

        mapView.removeAnnotations(mapView.annotations ?? [])

        for museum in museums {
            let annotation = MLNPointAnnotation()
            annotation.coordinate = museum.coordinate
            annotation.title = museum.name
            mapView.addAnnotation(annotation)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(museums: museums, onSelectMuseum: onSelectMuseum)
    }

    class Coordinator: NSObject, MLNMapViewDelegate {
        let museums: [Museum]
        let onSelectMuseum: (Museum) -> Void

        init(museums: [Museum], onSelectMuseum: @escaping (Museum) -> Void) {
            self.museums = museums
            self.onSelectMuseum = onSelectMuseum
        }

        func mapView(_ mapView: MLNMapView, didSelect annotation: MLNAnnotation) {
            if let found = museums.first(where: { $0.coordinate.latitude == annotation.coordinate.latitude && $0.coordinate.longitude == annotation.coordinate.longitude }) {
                onSelectMuseum(found)
            }
        }

        func mapView(_ mapView: MLNMapView, imageFor annotation: MLNAnnotation) -> MLNAnnotationImage? {
            let identifier = "museum-pin"
            if let image = mapView.dequeueReusableAnnotationImage(withIdentifier: identifier) {
                return image
            } else {
                let image = UIImage(named: "museum-pin") ?? UIImage(systemName: "building.columns")!
                return MLNAnnotationImage(image: image, reuseIdentifier: identifier)
            }
        }
    }
}
