//
//  OrderView.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 22/06/24.
//

import SwiftUI

struct OrderView: View {
    
    @StateObject var oVM = OrderViewModel.shared
    
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                
               
                HStack(spacing:0){
                    
                    OrderTabButton(title: "New",  isSelect: oVM.selectTab == 0) {
                        
                        print("Button Tab")
                        
                        DispatchQueue.main.async {
                             
                            withAnimation {
                                oVM.selectTab = 0
                            }
                        }
                        
                       
                    }
                    OrderTabButton(title: "Completed",  isSelect: oVM.selectTab == 1) {
                        DispatchQueue.main.async {
                             
                            withAnimation {
                                oVM.selectTab = 1
                            }
                        }
                    }
                    
                    OrderTabButton(title: "Cancel", isSelect: oVM.selectTab == 2) {
                        DispatchQueue.main.async {
                             
                            withAnimation {
                                oVM.selectTab = 2
                            }
                        }
                    }
                                    
                }
                .padding(.top, .topInsets + 8)
                
                .padding(.horizontal, 10)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: -2)
                
                if(oVM.selectTab == 0) {
                    NewOrdersView()
                }else if(oVM.selectTab == 1) {
                    CompletedOrdersView()
                }else if(oVM.selectTab == 2) {
                    CancelOrdersView()
                }
            }
        }
        .background( NavigationLink(destination: OrderDetailView(), isActive: $oVM.showDetail , label: {
            EmptyView()
        }) )
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    OrderView()
}
