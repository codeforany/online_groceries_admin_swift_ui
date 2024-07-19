//
//  ZoneView.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 15/05/24.
//

import SwiftUI

struct ZoneView: View {
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    @StateObject var zVM = ZoneViewModel.shared
    
    var body: some View {
        ZStack{
            
            if(zVM.listArr.isEmpty) {
                Text("Zone is Empty")
                    .font(.customfont(.bold, fontSize: 20))
            }
            
            ScrollView{
                
                LazyVStack(spacing: 8, content: {
                    ForEach( zVM.listArr , id: \.id) { zObj in
                        
                        HStack{
                            
                            Text(zObj.zoneName)
                                .font(.customfont(.medium, fontSize: 17))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Button(action: {
                                zVM.actionEdit(obj: zObj)
                            }, label: {
                                Image(systemName: "pencil.line")
                                    .foregroundColor(.primaryApp)
                            })
                            Button(action: {
                                zVM.actionDelete(obj: zObj)
                            }, label: {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(.red)
                            })
                        }
                        .background( Color.white )
                        .onTapGesture {
                            
                            AreaViewModel.shared.setZoneObj(zObj: zObj)
                            zVM.showArea = true
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
                    
                    Text("Zone")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    Button(action: {
                        zVM.actionOpenAdd()
                        
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
            zVM.apiList()
        }
        .background( NavigationLink(destination: ZoneAddView(), isActive: $zVM.showAddEdit, label: {
            EmptyView()
        }) )
        .background( NavigationLink(destination: AreaView(), isActive: $zVM.showArea, label: {
            EmptyView()
        }) )
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
    ZoneView()
}
