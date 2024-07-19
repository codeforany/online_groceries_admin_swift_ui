//
//  OrderTabButton.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 22/06/24.
//

import SwiftUI

struct OrderTabButton: View {
    @State var title: String = "Title"
   
    var isSelect: Bool = false
    var didSelect: (()->())
    
    var body: some View {
        
        VStack{
            Button {
                didSelect()
            } label: {
                    Text(title)
                        .font(.customfont(.semibold, fontSize: 14))
                    
            }
            .foregroundColor(isSelect ? .primaryApp : .primaryText )
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 46)
            
            Rectangle()
                .fill( isSelect ?  Color.primaryApp : Color.clear )
                .frame(height: 2)
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    OrderTabButton(){
        
    }
}
