//
//  PropertyResultView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//

import SwiftUI

struct PropertyResultView: View {
    
    @StateObject private var vm:
    PropertyResultViewModel
    
    @EnvironmentObject var router: Router
    
    init(
        result: PropertyResultModel
    ) {
        
        _vm = StateObject(
            wrappedValue:
                PropertyResultViewModel(
                    result: result
                )
        )
    }
    
    var body: some View {
        
        ZStack {
            
            Image(.loginBg)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                headerSection
                
                ScrollView {
                    
                    VStack(
                        spacing: 16
                    ) {
                        
                        financingTabs
                        
                        profitCard
                        
                        metricsGrid
                        
                        costSections
                        
                        totalCostCard
                    }
                    .padding()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    
    private var headerSection: some View {
        
        HStack {
            
            Button {
                router.pop()
            } label: {
                
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
            }
            
            Spacer()
            
            Text("Deal Analysis")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.white)
            
            Spacer()
            
            Button {
                
            } label: {
                
                HStack(spacing: 6) {
                    
                    Image(systemName: "doc.fill")
                    
                    Text("Export PDF")
                }
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.orange)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .overlay(
                    Capsule()
                        .stroke(
                            Color.orange,
                            lineWidth: 1.5
                        )
                )
            }
        }
        .padding(.horizontal)
        .padding(.top, 60)
        .padding(.bottom, 20)
    }
    
    private var financingTabs: some View {
        
        HStack(spacing: 8) {
            
            ForEach(
                FinancingType.allCases,
                id: \.self
            ) { type in
                
                Button {
                    
                    vm.selectedType = type
                    
                } label: {
                    
                    Text(type.rawValue)
                        .font(
                            .system(
                                size: 14,
                                weight: .semibold
                            )
                        )
                        .foregroundColor(
                            vm.selectedType == type
                            ? .white
                            : .gray
                        )
                        .frame(maxWidth: .infinity)
                        .frame(height: 42)
                        .background(
                            vm.selectedType == type
                            ? Color.orange
                            : Color.clear
                        )
                        .cornerRadius(20)
                }
            }
        }
        .padding(5)
        .overlay(
            Capsule()
                .stroke(
                    Color.white.opacity(0.2),
                    lineWidth: 1
                )
        )
    }
    
    private var profitCard: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Text("Estimated Net Profit")
                .foregroundColor(.white)

            Text(
                "$\(Int(vm.result.estimatedProfit))"
            )
            .font(
                .system(
                    size: 52,
                    weight: .bold
                )
            )
            .foregroundColor(.green)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(20)
        .background(
            RoundedRectangle(
                cornerRadius: 22
            )
            .fill(
                Color(
                    red: 17/255,
                    green: 49/255,
                    blue: 109/255
                )
            )
        )
        .overlay(
            RoundedRectangle(
                cornerRadius: 22
            )
            .stroke(
                Color.white.opacity(0.15),
                lineWidth: 1
            )
        )
    }
    
    private var cardBackground: some View {
        
        RoundedRectangle(
            cornerRadius: 20
        )
        .fill(
            Color(
                red: 17/255,
                green: 49/255,
                blue: 109/255
            )
        )
    }
    
    private var metricsGrid: some View {
        
        VStack(spacing: 16) {
            
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 16
            ) {
                
                ResultMetricCard(
                    title: "Net Return",
                    value: "\(vm.result.netReturn)%"
                )
                
                ResultMetricCard(
                    title: "Cash Net Return",
                    value: "\(vm.result.cashNetReturn)%"
                )
            }
            
            ResultMetricCard(
                title: "Annual APY",
                value: "\(vm.result.annualAPY)%"
            )
            
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 12
            ) {
                
                ResultMetricCard(
                    title: "After Repair Value",
                    value: "$\(Int(vm.result.arv))"
                )
                
                ResultMetricCard(
                    title: "Loan Amount",
                    value: "$\(Int(vm.result.loanAmount))"
                )
                
                ResultMetricCard(
                    title: "Cash Required",
                    value: "$\(Int(vm.result.cashRequired))"
                )
            }
        }
    }
    
    private var costSections: some View {
        
        VStack(spacing: 16) {
            
            CostBreakdownSection(
                title: "BUYING COSTS",
                total: vm.result.buyingCosts.reduce(
                    0
                ) { $0 + $1.amount },
                items: vm.result.buyingCosts,
                isExpanded: $vm.buyingExpanded
            )
            
            CostBreakdownSection(
                title: "HOLDING COSTS",
                total: vm.result.holdingCosts.reduce(
                    0
                ) { $0 + $1.amount },
                items: vm.result.holdingCosts,
                isExpanded: $vm.holdingExpanded
            )
            
            CostBreakdownSection(
                title: "SELLING COSTS",
                total: vm.result.sellingCosts.reduce(
                    0
                ) { $0 + $1.amount },
                items: vm.result.sellingCosts,
                isExpanded: $vm.sellingExpanded
            )
        }
    }
    
    
    private var totalCostCard: some View {
        
        let totalCost =
        vm.result.buyingCosts.reduce(
            0
        ) { $0 + $1.amount }
        +
        vm.result.holdingCosts.reduce(
            0
        ) { $0 + $1.amount }
        +
        vm.result.sellingCosts.reduce(
            0
        ) { $0 + $1.amount }
        
        return HStack {
            
            Text("TOTAL ALL COSTS")
                .font(
                    .system(
                        size: 20,
                        weight: .bold
                    )
                )
                .foregroundColor(.white)
            
            Spacer()
            
            Text("$\(Int(totalCost))")
                .font(
                    .system(
                        size: 28,
                        weight: .bold
                    )
                )
                .foregroundColor(.white)
        }
        .padding()
        .background(
            RoundedRectangle(
                cornerRadius: 20
            )
            .fill(
                Color(
                    red: 17/255,
                    green: 49/255,
                    blue: 109/255
                )
            )
        )
//        .overlay(
//            RoundedRectangle(
//                cornerRadius: 24
//            )
//            .stroke(
//                Color.green,
//                lineWidth: 3
//            )
//        )
    }
    
}


struct ResultMetricCard: View {

    let title: String
    let value: String

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.white)

            Text(value)
                .font(
                    .system(
                        size: 22,
                        weight: .bold
                    )
                )
                .foregroundColor(.green)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(16)
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
        .overlay(
            RoundedRectangle(
                cornerRadius: 18
            )
            .stroke(
                Color.white.opacity(0.15),
                lineWidth: 1
            )
        )
    }
}
