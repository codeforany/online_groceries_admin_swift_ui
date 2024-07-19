//
//  CategoryView.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 19/05/24.
//

import SwiftUI

struct CategoryView: View {
    @StateObject var catVM = CategoryViewModel.shared
    
    
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
                    
                    Text("Category")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                    
                    Button(action: {
                        catVM.actionOpenAdd()
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
                        ForEach(catVM.listArr, id: \.id) {
                            cObj in
                            
                            ExploreCategoryCell(cObj: cObj, onEdit: {
                                catVM.actionEdit(obj: cObj)
                            }, onDelete: {
                                catVM.actionDelete(obj: cObj)
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
        .background( NavigationLink(destination: CategoryAddView(), isActive: $catVM.showAddEdit, label: {
            EmptyView()
        }) )
        .alert(isPresented: $catVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text( catVM.errorMessage ), dismissButton: .default(Text("OK")))
        })
        .onAppear(){
            catVM.apiList()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CategoryView()
}
