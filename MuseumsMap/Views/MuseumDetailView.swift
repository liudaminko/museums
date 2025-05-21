//
//  MuseumDetailView.swift
//  MuseumsMap
//
//  Created by Liudmyla Minkovets on 21.05.2025.
//

import SwiftUI

struct MuseumDetailView: View {
    let museum: Museum

    @State private var reviewText = ""
    @State private var isSubmitting = false
    @State private var showConfirmation = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(museum.name)
                    .font(.largeTitle)
                    .bold()

                Text(museum.description)

                Divider()

                Text("Адреса: \(museum.address)")
                Text("Години роботи: \(museum.openingHours)")

                Button("Прокласти маршрут") {
                    let url = URL(string: "http://maps.apple.com/?daddr=\(museum.coordinate.latitude),\(museum.coordinate.longitude)")!
                    UIApplication.shared.open(url)
                }
                .padding(.top)

                Divider()

                Text("Залишити відгук")
                    .font(.headline)

                TextEditor(text: $reviewText)
                    .frame(height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )

                Button(action: submitReview) {
                    if isSubmitting {
                        ProgressView()
                    } else {
                        Text("Надіслати")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .disabled(reviewText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isSubmitting)

                if showConfirmation {
                    Text("✅ Відгук надіслано!")
                        .foregroundColor(.green)
                }
            }
            .padding()
        }
        .navigationTitle("Інформація")
    }

    func submitReview() {
        isSubmitting = true
        // 🟡 Тут пізніше буде запит на Supabase або бекенд
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showConfirmation = true
            reviewText = ""
            isSubmitting = false
        }
    }
}


