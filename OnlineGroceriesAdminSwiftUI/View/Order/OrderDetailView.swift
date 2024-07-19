//
//  OrderDetailView.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 22/06/24.
//

import SwiftUI

struct OrderDetailView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var detailVM = OrderViewModel.shared
    
    var body: some View {
        ZStack{
            
            ScrollView {
                
                if let orderObj = detailVM.orderDic {
                    VStack{
                        HStack{
                            Text("Order ID: # \( orderObj.id )")
                                .font(.customfont(.bold, fontSize: 20))
                                .foregroundColor(.primaryText)
                            
                            Spacer()
                            
                            Text( getPaymentStatus(mObj: orderObj )  )
                                .font(.customfont(.bold, fontSize: 18))
                                .foregroundColor( getPaymentStatusColor(mObj: orderObj))
                        }
                        
                        
                        HStack{
                            Text(orderObj.createdDate.displayDate(format: "yyyy-MM-dd hh:mm a"))
                                .font(.customfont(.regular, fontSize: 12))
                                .foregroundColor(.secondaryText)
                            
                            Spacer()
                            
                            Text( getOrderStatus(mObj: orderObj )  )
                                .font(.customfont(.bold, fontSize: 18))
                                .foregroundColor( getOrderStatusColor(mObj: orderObj))
                        }
                        .padding(.bottom, 8)
                        
                        Text("\(orderObj.address),\(orderObj.city), \(orderObj.state), \(orderObj.postalCode) ")
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(.secondaryText)
                            .multilineTextAlignment( .leading)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 8)
                        
                        HStack{
                            Text("Delivery Type:")
                                .font(.customfont(.medium, fontSize: 16))
                                .foregroundColor(.primaryText)
                            
                            Spacer()
                            
                            Text( getDeliveryType(mObj: orderObj )  )
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor( .primaryText )
                        }
                        .padding(.bottom, 4)
                        
                        HStack{
                            Text("Payment Type:")
                                .font(.customfont(.medium, fontSize: 16))
                                .foregroundColor(.primaryText)
                            
                            Spacer()
                            
                            Text( getPaymentType(mObj: orderObj )  )
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor( .primaryText )
                        }
                        
                        
                    }
                    .padding(15)
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.15), radius: 2)
                    .padding(.horizontal, 20)
                    .padding(.top, .topInsets + 46)
                    
                    LazyVStack {
                        ForEach(detailVM.cartArr, id: \.id) { pObj in
                            OrderItemRow(pObj: pObj)
                        }
                    }
                    
                    VStack{
                        
                        HStack{
                            Text("Amount:")
                                .font(.customfont(.bold, fontSize: 18))
                                .foregroundColor(.primaryText)
                            
                            Spacer()
                            
                            Text( "$\( orderObj.totalPrice, specifier: "%.2f" )"  )
                                .font(.customfont(.medium, fontSize: 18))
                                .foregroundColor( .primaryText )
                        }
                        .padding(.bottom, 4)
                        
                        HStack{
                            Text("Delivery Cost:")
                                .font(.customfont(.bold, fontSize: 18))
                                .foregroundColor(.primaryText)
                            
                            Spacer()
                            
                            Text( "+ $\( orderObj.deliverPrice ?? 0.0, specifier: "%.2f" )"  )
                                .font(.customfont(.medium, fontSize: 18))
                                .foregroundColor( .primaryText )
                        }
                        .padding(.bottom, 4)
                        
                        HStack{
                            Text("Discount Cost:")
                                .font(.customfont(.bold, fontSize: 18))
                                .foregroundColor(.primaryText)
                            
                            Spacer()
                            
                            Text( "- $\( orderObj.discountPrice ?? 0.0, specifier: "%.2f" )"  )
                                .font(.customfont(.medium, fontSize: 18))
                                .foregroundColor( .red )
                        }
                        .padding(.bottom, 4)
                        
                        Divider()
                        
                        HStack{
                            Text("Total:")
                                .font(.customfont(.bold, fontSize: 22))
                                .foregroundColor(.primaryText)
                            
                            Spacer()
                            
                            Text( "$\( orderObj.userPayPrice ?? 0.0, specifier: "%.2f" )"  )
                                .font(.customfont(.bold, fontSize: 22))
                                .foregroundColor( .primaryText )
                        }
                        .padding(.bottom, 4)
                        
                        
                    }
                    .padding(15)
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.15), radius: 2)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 4)
                    
                        
                    
                    if orderObj.orderStatus == 1 {
                        HStack{
                                
                            RoundButton(title: "Accept") {
                                
                                detailVM.apiOrderStatusChange(orderId: orderObj.id, userId: orderObj.userId, orderStatus: 2) {
                                    
                                    detailVM.apiNewOrderList()
                                    mode.wrappedValue.dismiss()
                                }
                            }
                            
                            Button {
                                detailVM.apiOrderStatusChange(orderId: orderObj.id, userId: orderObj.userId, orderStatus: 5) {
                                    
                                    detailVM.apiNewOrderList()
                                    detailVM.apiCancelOrderList()
                                    mode.wrappedValue.dismiss()
                                }
                            } label: {
                                Text("Reject")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }
                            .frame( minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
                            .background( Color.red)
                            .cornerRadius(20)

                            
                            
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    if orderObj.orderStatus == 2 {
                        HStack{
                                
                            RoundButton(title: "Deliverd") {
                                
                                detailVM.apiOrderStatusChange(orderId: orderObj.id, userId: orderObj.userId, orderStatus: 3) {
                                    
                                    detailVM.apiNewOrderList()
                                    detailVM.apiCompletedOrderList()
                                    mode.wrappedValue.dismiss()
                                }
                            }
                            
                            Button {
                                detailVM.apiOrderStatusChange(orderId: orderObj.id, userId: orderObj.userId, orderStatus: 4) {
                                    
                                    detailVM.apiNewOrderList()
                                    
                                    detailVM.apiCancelOrderList()
                                    mode.wrappedValue.dismiss()
                                }
                            } label: {
                                Text("Order Cancel")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }
                            .frame( minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
                            .background( Color.red)
                            .cornerRadius(20)
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    
                }
                
                
                    
                }
                
            VStack {
                
                HStack{
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    
                    Spacer()
                    
                    Text("Order Detail")
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.primaryText)
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
            
        }
        .alert(isPresented: $detailVM.showError, content: {
            
            Alert(title: Text(Globs.AppName), message: Text(detailVM.errorMessage)  , dismissButton: .default(Text("Ok"))  )
        })
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
    
    func getOrderStatus(mObj: MyOrderModel) -> String {
        switch mObj.orderStatus {
        case 1:
            return "New"
        case 2:
            return "Accepted";
        case 3:
            return "Delivered";
        case 4:
            return "Cancel";
        case 5:
            return "Declined";
        default:
            return "";
        }
    }
    
    func getDeliveryType(mObj: MyOrderModel) -> String {
        switch mObj.deliverType {
        case 1:
              return "Delivery";
            case 2:
              return "Collection";
        default:
            return "";
        }
    }
    
    func getPaymentType(mObj: MyOrderModel) -> String {
        switch mObj.paymentType {
        case 1:
            return "Cash On Delivery";
        case 2:
            return "Online Card Payment";
        default:
            return "";
        }
    }
    
    func getPaymentStatus(mObj: MyOrderModel) -> String {
        switch mObj.paymentStatus {
        case 1:
            return "Processing";
        case 2:
            return "Success";
        case 3:
            return "Fail";
        case 4:
            return "Refunded";
        default:
            return "";
        }
    }
    
    func getPaymentStatusColor(mObj: MyOrderModel) -> Color {
        
        if (mObj.paymentType == 1) {
            return Color.orange;
        }
        
        switch mObj.paymentStatus {
        case 1:
            return Color.blue;
        case 2:
            return Color.green;
        case 3:
            return Color.red;
        case 4:
            return Color.green;
        default:
            return Color.white;
        }
    }
    
    func getOrderStatusColor(mObj: MyOrderModel) -> Color {
        
     
        
        switch mObj.orderStatus {
        case 1:
              return Color.blue;
            case 2:
              return Color.green;
            case 3:
              return Color.green;
            case 4:
              return Color.red;
            case 5:
              return Color.red;
            default:
              return Color.primaryApp;        }
    }
}

#Preview {
    OrderDetailView()
}
