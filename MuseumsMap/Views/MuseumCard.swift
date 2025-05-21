//
//  MuseumCard.swift
//  MuseumsMap
//
//  Created by Liudmyla Minkovets on 21.05.2025.
//

import SwiftUI

struct MuseumCard: View {
    let museum: Museum
    var onClose: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(museum.name)
                    .font(.headline)
                Spacer()
                Button(action: onClose) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                }
            }
            Text("Категорія: \(museum.category.capitalized)")
            Button("Детальніше") {
                // handled by NavigationLink in parent
            }
            .padding(.top, 5)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemBackground)).shadow(radius: 5))
        .padding()
    }
}
