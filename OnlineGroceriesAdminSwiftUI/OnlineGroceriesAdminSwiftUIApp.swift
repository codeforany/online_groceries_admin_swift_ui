//
//  OnlineGroceriesAdminSwiftUIApp.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 09/05/24.
//

import SwiftUI

@main
struct OnlineGroceriesAdminSwiftUIApp: App {
    @StateObject var mainVM = MainViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            
            NavigationView {
                
                if mainVM.isUserLogin {
                    MainTabView()
                }else{
                    WelcomeView()
                }
            }
            
        }
    }
}
