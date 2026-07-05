//
//  MasterSettingView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//
import SwiftUI
import Foundation


struct MasterSettingsView: View {
    
    @StateObject private var vm =
    MasterSettingsViewModel()
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        
        ZStack {
            
            Image(.loginBg)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                CustomNavigationBar(
                    title: "Master Settings",
                    subtitle: nil
                ) {
                    router.pop()
                }
                
                CustomScreen {
                    
                    VStack(
                        spacing: 24
                    ) {
                        
                        hardMoneySection
                        
                        privateCapitalSection
                        
                        generalCostSection
                        
                        saveButton
                    }
                    .padding()
                }
                .keyboardManager()
            }
        }
        .navigationBarBackButtonHidden(true)
        
        .task {
            do {
                try await vm.loadSettings()
            } catch {
                vm.showApiError(error)
            }
        }
    }
    
    private var cardBackground: some View {
        
        RoundedRectangle(
            cornerRadius: 30
        )
        .fill(
            Color(
                red: 12/255,
                green: 41/255,
                blue: 96/255
            )
        )
    }
    
    private var hardMoneySection: some View {
        
        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            
            SectionHeader(
                title: "HARD MONEY",
                color: .green
            )
            
            HStack {
                
                InquiryField(
                    title: "Rate %",
                    placeholder: "0",
                    text: $vm.settings.hardMoneyRate
                )
                
                InquiryField(
                    title: "Points %",
                    placeholder: "0",
                    text: $vm.settings.hardMoneyPoints
                )
            }
            
            HStack {
                
                InquiryField(
                    title: "Fees $",
                    placeholder: "0",
                    text: $vm.settings.hardMoneyFees
                )
                
                InquiryField(
                    title: "Finance %",
                    placeholder: "0",
                    text: $vm.settings.hardMoneyFinance
                )
            }
        }
    }
    
    private var privateCapitalSection: some View {
        
        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            
            Divider()
                .background(.white.opacity(0.2))
            
            SectionHeader(
                title: "PRIVATE CAPITAL",
                color: .cyan
            )
            
            HStack(spacing: 16) {
                
                InquiryField(
                    title: "Rate %",
                    placeholder: "0",
                    text: $vm.settings.privateCapitalRate,
                    keyboardType: .decimalPad
                )
                
                InquiryField(
                    title: "Points %",
                    placeholder: "0",
                    text: $vm.settings.privateCapitalPoints,
                    keyboardType: .decimalPad
                )
            }
            
            HStack(spacing: 16) {
                
                InquiryField(
                    title: "Fees $",
                    placeholder: "0",
                    text: $vm.settings.privateCapitalFees,
                    keyboardType: .decimalPad
                )
                
                InquiryField(
                    title: "Finance %",
                    placeholder: "0",
                    text: $vm.settings.privateCapitalFinance,
                    keyboardType: .decimalPad
                )
            }
        }
    }
    
    private var generalCostSection: some View {
        
        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            
            Divider()
                .background(.white.opacity(0.2))
            
            SectionHeader(
                title: "GENERAL COSTS",
                color: .purple
            )
            
            HStack(spacing: 16) {
                
                InquiryField(
                    title: "Title Costs Purchase %",
                    placeholder: "0",
                    text: $vm.settings.titleCostsPurchasePercent,
                    keyboardType: .decimalPad
                )
                
                InquiryField(
                    title: "Title Costs Sale %",
                    placeholder: "0",
                    text: $vm.settings.titleCostsSalePercent,
                    keyboardType: .decimalPad
                )
            }
            
            HStack(spacing: 16) {
                
                InquiryField(
                    title: "Utilities / Mo $",
                    placeholder: "0",
                    text: $vm.settings.utilitiesPerMonth,
                    keyboardType: .decimalPad
                )
                
                InquiryField(
                    title: "Insurance / Mo $",
                    placeholder: "0",
                    text: $vm.settings.insurancePerMonth,
                    keyboardType: .decimalPad
                )
            }
            
            HStack(spacing: 16) {
                
                InquiryField(
                    title: "Property Tax Rate %",
                    placeholder: "0",
                    text: $vm.settings.propertyTaxRate,
                    keyboardType: .decimalPad
                )
                
                InquiryField(
                    title: "Realtor Fees %",
                    placeholder: "0",
                    text: $vm.settings.realtorFeesPercent,
                    keyboardType: .decimalPad
                )
            }
        }
    }
    
    private var saveButton: some View {
        
        CustomButton(
            title: "SAVE"
        ) {
            
            Task {
                await vm.save()
            }
        }
        //.disabled(vm.isLoading)
        .padding(.top, 10)
        .padding(.bottom, 120)
    }
}
