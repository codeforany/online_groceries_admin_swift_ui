//
//  PromoCodeAddView.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 27/05/24.
//

import SwiftUI

struct PromoCodeAddView: View {
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    @StateObject var pVM = PromoCodeViewModel.shared
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
                    
                    Text( pVM.isEdit ? "Edit Promo Code" : "Add New Promo Code")
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
                        
                        if(!pVM.isEdit) {
                            LineTextField(title: "Promo Code", placholder: "Enter Promo Code" , txt: $pVM.txtCode)
                        }
                        
                        
                        LineTextField(title: "Title", placholder: "Enter Promo Code Title" , txt: $pVM.txtTitle)
                        
                        LineTextField(title: "Description", placholder: "Enter Promo Code Description" , txt: $pVM.txtDescription)
                        
                        
                        
                        VStack {
                            Text("Select Start Date")
                                .font(.customfont(.semibold, fontSize: 16))
                                .foregroundColor(.textTitle)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            DatePicker("Select Date", selection: $pVM.selectStateDate, in: Date()..., displayedComponents: .date )
                                .datePickerStyle(.automatic)
                            
                            
                            Divider()
                            
                        }
                        
                        VStack {
                            Text("Select End Date")
                                .font(.customfont(.semibold, fontSize: 16))
                                .foregroundColor(.textTitle)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                           
                            DatePicker("Select Date", selection: $pVM.selectEndDate, in: Date()..., displayedComponents: .date )
                                .datePickerStyle(.automatic)
                            
                            Divider()
                            
                        }
                        VStack {
                            Text("Promo Code Type")
                                .font(.customfont(.semibold, fontSize: 16))
                                .foregroundColor(.textTitle)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                           
                            HStack{
                                
                                Button {
                                    pVM.selectType = 0
                                } label: {
                                    Image(systemName: pVM.selectType == 0 ? "record.circle" : "circle" )
                                        .foregroundColor(.primaryApp)
                                    
                                    Text("Fixed")
                                        .font(.customfont(.semibold, fontSize: 16))
                                        .foregroundColor(.textTitle)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                }
                                
                                Button {
                                    pVM.selectType = 1
                                } label: {
                                    Image(systemName: pVM.selectType == 1 ? "record.circle" : "circle" )
                                        .foregroundColor(.primaryApp)
                                    
                                    Text("Percentage(%)")
                                        .font(.customfont(.semibold, fontSize: 16))
                                        .foregroundColor(.textTitle)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                }

                                
                            }
                            .frame(height: 50)
                            
                            Divider()
                            
                        }
                        
                        LineTextField(title: "Offer Price", placholder: "Enter Offer Price" , txt: $pVM.txtOfferPrice, keyboardType: .numberPad)
                        
                        LineTextField(title: "Min Order Amount", placholder: "Enter Min Order Amount" , txt: $pVM.txtMinOrderAmount, keyboardType: .numberPad)
                        
                        LineTextField(title: "Max Discount Amount", placholder: "Enter Max Discount Amount" , txt: $pVM.txtMaxDiscount, keyboardType: .numberPad)
                        
                        
                       
                        
                        RoundButton(title: pVM.isEdit ? "Update" : "Add") {
                            if(pVM.isEdit) {
                                pVM.actionUpdate {
                                    mode.wrappedValue.dismiss()
                                }
                            }else{
                                pVM.actionAdd {
                                    mode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }
                    .padding(20)
                    
                }
            }
            
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
    PromoCodeAddView()
}
