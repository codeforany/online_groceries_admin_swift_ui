//
//  AreaView.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 17/05/24.
//

import SwiftUI

struct AreaView: View {
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    @StateObject var aVM = AreaViewModel.shared
    var body: some View {
        ZStack{
            
            if(aVM.listArr.isEmpty) {
                Text("Area is Empty")
                    .font(.customfont(.bold, fontSize: 20))
            }
            
            ScrollView{
                
                LazyVStack(spacing: 8, content: {
                    ForEach( aVM.listArr , id: \.id) { aObj in
                        
                        HStack{
                            
                            Text(aObj.areaName)
                                .font(.customfont(.medium, fontSize: 17))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Button(action: {
                                aVM.actionEdit(obj: aObj)
                            }, label: {
                                Image(systemName: "pencil.line")
                                    .foregroundColor(.primaryApp)
                            })
                            Button(action: {
                                aVM.actionDelete(obj: aObj)
                            }, label: {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(.red)
                            })
                        }
                    }
                    .frame(height: 50)
                    .padding(.horizontal, 15)
                    .background( Color.white )
                    .cornerRadius(5)
                    .shadow(radius: 2)
                })
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets )
                
            }
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
                    
                    Text("Area")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    Button(action: {
                        aVM.actionOpenAdd()
                        
                    }, label: {
                            
                        Image("add_green")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                    })
                    .frame(width: 40, height: 40)
                    
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 8)
                .background( Color.white )
                .shadow(radius: 2)
                
                Spacer()
            }
            
        }
        .onAppear(){
            aVM.apiList()
        }
        .background( NavigationLink(destination: AreaAddView(), isActive: $aVM.showAddEdit, label: {
            EmptyView()
        }) )
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
    AreaView()
}
