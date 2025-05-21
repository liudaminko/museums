//
//  FilterChip.swift
//  MuseumsMap
//
//  Created by Liudmyla Minkovets on 21.05.2025.
//

import SwiftUI

import SwiftUI

struct FilterChip: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                if label.lowercased() == "історичний" {
                    Image(systemName: "clock")
                } else if label.lowercased() == "мистецтво" {
                    Image(systemName: "paintbrush")
                }
                Text(label)
                    .font(.subheadline)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? Color.green : Color(.systemGray5))
            .foregroundColor(isSelected ? .white : .black)
            .cornerRadius(20)
        }
    }
}
