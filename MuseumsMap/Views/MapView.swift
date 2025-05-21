//
//  MapView.swift
//  MuseumsMap
//
//  Created by Liudmyla Minkovets on 21.05.2025.
//

import SwiftUI
import CoreLocation

struct MapView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var selectedMuseum: Museum? = nil
    @State private var selectedCategory: String? = nil
    @State private var isShowingDetail: Bool = false

    let allMuseums: [Museum] = [
        Museum(name: "Національний музей", category: "історичний", coordinate: CLLocationCoordinate2D(latitude: 49.8419, longitude: 24.0315), description: "Один із найстаріших музеїв країни", address: "вул. Драгоманова 1", openingHours: "10:00–18:00"),
        Museum(name: "Музей мистецтв", category: "мистецтво", coordinate: CLLocationCoordinate2D(latitude: 49.8431, longitude: 24.0289), description: "Музей сучасного та класичного мистецтва", address: "пл. Ринок 2", openingHours: "11:00–19:00"),
        Museum(name: "Архітектурний музей", category: "архітектура", coordinate: CLLocationCoordinate2D(latitude: 49.8422, longitude: 24.0300), description: "Музей архітектури та побуту", address: "вул. Чернеча гора 1", openingHours: "09:00–17:00"),
        Museum(name: "Музей науки", category: "наука", coordinate: CLLocationCoordinate2D(latitude: 49.8445, longitude: 24.0333), description: "Інтерактивний музей науки для дітей і дорослих", address: "вул. Сахарова 4", openingHours: "10:00–18:00")
    ]

    var categories: [String] {
        var uniqueCategories: [String] = []
        for museum in allMuseums {
            if !uniqueCategories.contains(museum.category) {
                uniqueCategories.append(museum.category)
            }
        }
        return uniqueCategories
    }

    var filteredMuseums: [Museum] {
        guard let category = selectedCategory else { return allMuseums }
        return allMuseums.filter { $0.category == category }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Мапа музеїв")
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal)
                        .padding(.top, 12)
                        .background(Color(.systemBackground))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            FilterChip(label: "Усі", isSelected: selectedCategory == nil) {
                                selectedCategory = nil
                            }
                            ForEach(categories, id: \.self) { category in
                                FilterChip(label: category.capitalized, isSelected: selectedCategory == category) {
                                    selectedCategory = category
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }
                }
                .background(Color.clear)
                .zIndex(1)


                ZStack(alignment: .top) {
                    MuseumLibreMapView(locationManager: locationManager, museums: filteredMuseums) { museum in
                        selectedMuseum = museum
                        isShowingDetail = true
                    }
                    .ignoresSafeArea()

                    if let museum = selectedMuseum {
                        NavigationLink(destination: MuseumDetailView(museum: museum), isActive: $isShowingDetail) {
                            EmptyView()
                        }
                    }
                }
            }
        }
    }
}

   

#Preview {
    MapView()
}
