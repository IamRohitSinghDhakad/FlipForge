//
//  InquiryDateField.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import SwiftUI

struct InquiryDateField: View {

    let title: String

    @Binding var date: String

    @State private var selectedDate = Date()
    @State private var showDatePicker = false

    var body: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.white)

            Button {

                // If a date already exists, parse it
                if let parsedDate = Self.dateFormatter.date(from: date) {
                    selectedDate = parsedDate
                }

                showDatePicker = true

            } label: {

                HStack {

                    Text(date.isEmpty ? "Select Date" : date)
                        .foregroundColor(date.isEmpty ? .gray : .white)

                    Spacer()

                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(height: 58)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(
                            Color(
                                red: 17/255,
                                green: 49/255,
                                blue: 109/255
                            )
                        )
                )
            }
        }
        .sheet(isPresented: $showDatePicker) {

            VStack {

                DatePicker(
                    "Select Date",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)

                Button("Done") {

                    date = Self.dateFormatter.string(from: selectedDate)
                    showDatePicker = false
                }
                .padding()
            }
            .presentationDetents([.medium])
        }
    }

    private static let dateFormatter: DateFormatter = {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"   // API format
        return formatter
    }()
}
