//
//  OfferAddView.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 13/06/24.
//

import SwiftUI

struct OfferAddView: View {
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    @StateObject var pVM = ProductViewModel.shared
    @StateObject var oVM = OfferViewModel.shared
    var body: some View {
        ZStack{
            VStack{
                
                HStack{
                    
                    Button(action: {
                        
                        mode.wrappedValue.dismiss()
                    }, label: {
                            
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                    })
                    .frame(width: 40, height: 40)
                    
                    Text( "Add Product Offer")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    EmptyView()
                    .frame(width: 40, height: 40)
                    
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 8)
                .background( Color.white )
                .shadow(radius: 2)
                
                ScrollView{
                    
                    VStack(spacing: 15){
                        
                     
                        
                        VStack {
                            Text("Select Start Date")
                                .font(.customfont(.semibold, fontSize: 16))
                                .foregroundColor(.textTitle)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            DatePicker("Select Date", selection: $oVM.selectStateDate, in: Date()..., displayedComponents: .date )
                                .datePickerStyle(.automatic)
                            
                            
                            Divider()
                            
                        }
                        
                        VStack {
                            Text("Select End Date")
                                .font(.customfont(.semibold, fontSize: 16))
                                .foregroundColor(.textTitle)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                           
                            DatePicker("Select Date", selection: $oVM.selectEndDate, in: Date()..., displayedComponents: .date )
                                .datePickerStyle(.automatic)
                            
                            Divider()
                            
                        }
                        
                        
                        LineTextField(title: "Offer Price", placholder: "Enter Offer Price" , txt: $oVM.txtOfferPrice, keyboardType: .numberPad)
                        
                     
                       
                        
                        RoundButton(title:  "Add") {
                            
                            oVM.actionAdd(obj: pVM.selectOfferProduct ?? ProductModel(dict: [:])) {
                                    mode.wrappedValue.dismiss()
                                }
                            
                        }
                    }
                    .padding(20)
                    
                }
            }
            
        }
        .onAppear(){
            oVM.actionOpenAdd()
        }
        .alert(isPresented: $pVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text( pVM.errorMessage ), dismissButton: .default(Text("OK")))
        })
        .background( Color.white )
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    OfferAddView()
}
