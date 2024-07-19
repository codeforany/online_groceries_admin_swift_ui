//
//  AreaAddView.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 17/05/24.
//

import SwiftUI

struct AreaAddView: View {
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    @StateObject var aVM = AreaViewModel.shared
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
                    
                    Text( aVM.isEdit ? "Edit Area" : "Add New Area")
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
                        LineTextField(title: "Area Name", placholder: "Enter Area Name" , txt: $aVM.txtName)
                        
                        RoundButton(title: aVM.isEdit ? "Update" : "Add") {
                            if(aVM.isEdit) {
                                aVM.actionUpdate {
                                    mode.wrappedValue.dismiss()
                                }
                            }else{
                                aVM.actionAdd {
                                    mode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }
                    .padding(20)
                    
                }
            }
            
        }

        .alert(isPresented: $aVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text( aVM.errorMessage ), dismissButton: .default(Text("OK")))
        })
        .background( Color.white )
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    AreaAddView()
}
