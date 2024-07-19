//
//  TypeView.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 23/05/24.
//

import SwiftUI

struct TypeView: View {
    @StateObject var tVM = TypeViewModel.shared
    
    
    var colums =  [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    
    var body: some View {
        ZStack{
            
            VStack{
                HStack{
                    
                    EmptyView()
                        .frame(width: 40, height: 40)
                    
                    Spacer()
                    
                    Text("Product Type")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                    
                    Button(action: {
                        tVM.actionOpenAdd()
                    }, label: {
                        Image("add_green")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    })
                    .frame(width: 40, height: 40)
                    
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                
                
                
                ScrollView {
                    LazyVGrid(columns: colums, spacing: 20) {
                        ForEach(tVM.listArr, id: \.id) {
                            tObj in
                            
                            ProductTypeCell(tObj: tObj, onEdit: {
                                tVM.actionEdit(obj: tObj)
                            }, onDelete: {
                                tVM.actionDelete(obj: tObj)
                            })
                                    .aspectRatio( 0.95, contentMode: .fill)

                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .padding(.bottom, .bottomInsets + 60)
                }
                
            }
            
        }
        .background( NavigationLink(destination: TypeAddView(), isActive: $tVM.showAddEdit, label: {
            EmptyView()
        }) )
        .alert(isPresented: $tVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text( tVM.errorMessage ), dismissButton: .default(Text("OK")))
        })
        .onAppear(){
            tVM.apiList()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    TypeView()
}
