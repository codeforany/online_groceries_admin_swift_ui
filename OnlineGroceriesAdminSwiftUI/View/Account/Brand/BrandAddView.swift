//
//  BrandAddView.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 13/05/24.
//

import SwiftUI

struct BrandAddView: View {
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    @StateObject var bVM = BrandViewModel.shared
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
                    
                    Text( bVM.isEdit ? "Edit Brand" : "Add New Brand")
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
                        LineTextField(title: "Brand Name", placholder: "Enter Brand Name" , txt: $bVM.txtBrandName)
                        
                        RoundButton(title: bVM.isEdit ? "Update" : "Add") {
                            if(bVM.isEdit) {
                                bVM.actionUpdate {
                                    mode.wrappedValue.dismiss()
                                }
                            }else{
                                bVM.actionAdd {
                                    mode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }
                    .padding(20)
                    
                }
            }
            
        }

        .alert(isPresented: $bVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text( bVM.errorMessage ), dismissButton: .default(Text("OK")))
        })
        .background( Color.white )
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    BrandAddView()
}
