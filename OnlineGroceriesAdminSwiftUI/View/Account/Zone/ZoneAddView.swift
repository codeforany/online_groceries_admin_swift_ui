//
//  ZoneAddView.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 15/05/24.
//

import SwiftUI

struct ZoneAddView: View {
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    @StateObject var zVM = ZoneViewModel.shared
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
                    
                    Text( zVM.isEdit ? "Edit Zone" : "Add New Zone")
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
                        LineTextField(title: "Zone Name", placholder: "Enter Zone Name" , txt: $zVM.txtName)
                        
                        RoundButton(title: zVM.isEdit ? "Update" : "Add") {
                            if(zVM.isEdit) {
                                zVM.actionUpdate {
                                    mode.wrappedValue.dismiss()
                                }
                            }else{
                                zVM.actionAdd {
                                    mode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }
                    .padding(20)
                    
                }
            }
            
        }

        .alert(isPresented: $zVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text( zVM.errorMessage ), dismissButton: .default(Text("OK")))
        })
        .background( Color.white )
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    ZoneAddView()
}
