//
//  ExpandableSection.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//
import SwiftUI

struct CostItem: Identifiable {
    let id = UUID()
    let title: String
    let amount: String
}

struct CostBreakdownSection: View {

    let title: String
    let total: String
    let items: [CostItem]

    @Binding var isExpanded: Bool

    private var sectionColor: Color {
        switch title {
        case "BUYING COSTS":
            return .green
        case "HOLDING COSTS":
            return .pink
        case "SELLING COSTS":
            return .orange
        default:
            return .white
        }
    }

    var body: some View {

        VStack(spacing: 0) {

            Button {

                withAnimation(.easeInOut) {
                    isExpanded.toggle()
                }

            } label: {

                HStack {

                    Circle()
                        .fill(sectionColor)
                        .frame(width: 12, height: 12)

                    Text(title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)

                    Spacer()

                    Text(currency(total))
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.white)
                }
            }

            if isExpanded {

                VStack(spacing: 18) {

                    ForEach(items, id: \.title) { item in

                        HStack {

                            Text(item.title)
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(.white)

                            Spacer()

                            Text(currency(item.amount))
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.top, 24)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    Color(
                        red: 17/255,
                        green: 49/255,
                        blue: 109/255
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white.opacity(0.15), lineWidth: 1)
        )
    }

    private func currency(_ value: String) -> String {
        let number = Double(value) ?? 0
        return "$\(Int(number))"
    }
}
