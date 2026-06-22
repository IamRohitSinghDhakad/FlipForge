//
//  InquiryDateField.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import SwiftUI

struct InquiryDateField: View {

    let title: String

    @Binding var date: Date

    @State private var showDatePicker = false

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.white)

            Button {

                showDatePicker = true

            } label: {

                HStack {

                    Text(
                        date.formatted(
                            date: .numeric,
                            time: .omitted
                        )
                    )

                    Spacer()

                    Image(systemName: "calendar")
                }
                .foregroundColor(.gray)
                .padding()
                .frame(height: 58)
                .background(
                    RoundedRectangle(
                        cornerRadius: 18
                    )
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
        .sheet(
            isPresented: $showDatePicker
        ) {

            VStack {

                DatePicker(
                    "Select Date",
                    selection: $date,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)

                Button("Done") {
                    showDatePicker = false
                }
                .padding()
            }
            .presentationDetents([.medium])
        }
    }
}
