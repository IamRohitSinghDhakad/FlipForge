//
//  PropertyInquiryView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//
import Foundation
import SwiftUI
import Combine

struct PropertyInquiryView: View {

    @StateObject private var vm =
    PropertyInquiryViewModel()

    @EnvironmentObject var router: Router
    
    let property: PropertyModel
    

    var body: some View {

        ZStack {

            Image(.loginBg)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()


                VStack(spacing: 0) {

                    CustomNavigationBar(
                        title: "Property Inquiry",
                        subtitle: nil
                    ) {
                        router.pop()
                    }

                    CustomScreen {

                        VStack(
                            spacing: 20
                        ) {

                            propertySection

                            financialSection

                            buyingSection

                            holdingSection

                            sellingSection

                            buttonsSection
                                .padding(.bottom, 20)
                        }
                        .padding()
                    }.keyboardManager()
                }
           // }
        }.navigationBarBackButtonHidden(true)
    }
        
    
    
    private var propertySection: some View {

        VStack(spacing: 16) {

            SectionHeader(
                title: "PROPERTY DETAILS",
                color: .green
            )

            InquiryField(
                title: "Property Address",
                placeholder: "123 Main St",
                text: $vm.propertyAddress
            )

            HStack {

                InquiryField(
                    title: "Total Sq. Feet",
                    placeholder: "1500",
                    text: $vm.totalSqFeet,
                    keyboardType: .numberPad
                )

                InquiryField(
                    title: "Bed / Bath",
                    placeholder: "3/2",
                    text: $vm.bedBath
                )
            }

            HStack {

                InquiryField(
                    title: "# of Units",
                    placeholder: "1",
                    text: $vm.numberOfUnits,
                    keyboardType: .numberPad
                )

                InquiryDateField(
                    title: "Date of Estimate",
                    date: $vm.estimateDate
                )
            }
        }
    }
    
    private var financialSection: some View {

        VStack(spacing: 16) {

            SectionHeader(
                title: "$ KEY FINANCIALS",
                color: .green
            )

            HStack {

                InquiryField(
                    title: "After Repair Value (ARV)",
                    placeholder: "$300000",
                    text: $vm.arv,
                    keyboardType: .decimalPad
                )

                InquiryField(
                    title: "Estimated Repair Costs",
                    placeholder: "$50000",
                    text: $vm.repairCosts,
                    keyboardType: .decimalPad
                )
            }

            HStack {

                InquiryField(
                    title: "Estimated Purchase Price",
                    placeholder: "$200000",
                    text: $vm.purchasePrice,
                    keyboardType: .decimalPad
                )

                InquiryField(
                    title: "Holding Time (Months)",
                    placeholder: "6",
                    text: $vm.holdingMonths,
                    keyboardType: .numberPad
                )
            }
        }
    }
    
    private var buyingSection: some View {

        VStack(spacing: 16) {

            SectionHeader(
                title: "$ BUYING COSTS",
                color: .cyan
            )

            HStack {

                InquiryField(
                    title: "Inspections",
                    placeholder: "$500",
                    text: $vm.inspectionCost
                )

                InquiryField(
                    title: "CFK / Misc Costs",
                    placeholder: "$1000",
                    text: $vm.miscCost
                )
            }
        }
    }
    
    private var holdingSection: some View {

        VStack(spacing: 16) {

            SectionHeader(
                title: "MONTHLY HOLDING COSTS",
                color: .purple
            )

            HStack {

                InquiryField(
                    title: "HOA / Condo Fees",
                    placeholder: "$0",
                    text: $vm.hoaFees
                )

                InquiryField(
                    title: "Misc Holding Costs",
                    placeholder: "$0",
                    text: $vm.monthlyMiscCost
                )
            }
        }
    }
    
    private var sellingSection: some View {

        VStack(spacing: 16) {

            SectionHeader(
                title: "SELLING COSTS",
                color: .orange
            )

            HStack {

                InquiryField(
                    title: "Staging Costs",
                    placeholder: "$0",
                    text: $vm.stagingCost
                )

                InquiryField(
                    title: "Photos / Inspections",
                    placeholder: "$0",
                    text: $vm.photosInspectionCost
                )
            }
        }
    }
    
    private var buttonsSection: some View {

        HStack(spacing: 16) {

            CustomButton(
                title: "SAVE"
            ) {

                vm.save()
            }
            
            CustomButton(title: "SEE RESULT") {
                vm.calculate()
            }
        }
    }
    
}
