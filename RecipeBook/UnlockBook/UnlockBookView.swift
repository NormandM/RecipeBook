//
//  UnlockBookView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2021-01-27.
//

import SwiftUI
import StoreKit
import Combine
import Network
struct UnlockBookView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isUnlock: Bool
    var iapManager = IAPManager()
    @State private var price = ""
    @State private var showAlertPurchased = false
    @ObservedObject var products = productsDB.shared
    let publisher = IAPManager.shared.purchasePublisher
    @State private var showAlerts = false
    @State private var alertMessage = ""
    @State private var alertDetail = ""
    let monitor = NWPathMonitor()
    @StateObject var internetMonitor = InternetMonitor()
    @State private var showAlertNoconnection = false
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Enter  all your recipes for:")
                    .font(.headline)
                    .foregroundColor(colorScheme == .light ? .black : .black)
                Text(self.price)
                    .font(.headline)
                    .foregroundColor(colorScheme == .light ? .black : .black)
                Image("IconeRecipe")
                    .resizable()
                    .border(Color.black, width: 1)
                    .frame(width: geo.size.height * 0.2, height: geo.size.height * 0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding()
                Button(action: {
                    if isInternetConnected() {
                    isUnlock = UserDefaults.standard.bool(forKey: "unlocked")
                    _ = IAPManager.shared.purchaseV5(product: self.products.items[0])
                    }else{
                        showAlerts = true
                        alertMessage = NSLocalizedStringFunc(key:"There is no internet connection")
                        alertDetail = NSLocalizedStringFunc(key:"To unlock you have to be connected")
                    }
                    
                    
                }){
                    VStack {
                        Image(isUnlock ? "unlock" : "lock")
                            .resizable()
                            .frame(width: geo.size.height * 0.12, height: geo.size.height * 0.12, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(.top)
                        Text("Unlock")
                    }
                }
                .padding(.bottom)
                Text("Already purchased unlock?")
                    .foregroundColor(colorScheme == .light ? .black : .black)
                    .alert(isPresented: $showAlerts) {
                        Alert(title: Text(alertMessage), message: Text(alertDetail), dismissButton: .default(Text("OK")){
                        })
                    }
                Button(action: {
                    if isInternetConnected() {
                    IAPManager.shared.restorePurchasesV5()
                    }else{
                        alertMessage = NSLocalizedStringFunc(key:"There is no internet connection")
                        alertDetail = NSLocalizedStringFunc(key:"To restore your  purchase you have to be connected")
                    }
                }) {
                    VStack {
                        Image("Restore")
                            .resizable()
                            .frame(width: geo.size.height * 0.10, height: geo.size.height * 0.10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Text("Restore")
                    }
                }
                .onReceive(publisher, perform: {value in
                    showAlerts = true
                    alertMessage = value.0
                    alertDetail = ""
                    if !UserDefaults.standard.bool(forKey: "unlocked"){
                        isUnlock = value.1
                        UserDefaults.standard.set(isUnlock, forKey: "unlocked")
                    }

                    
                })
            }
            .navigationBarTitle("Unlock Book", displayMode: .inline)
            .navigationBarColor(UIColorReference.specialGreen)
            .background(ColorReference.specialSand)
            .edgesIgnoringSafeArea([.leading, .trailing, .bottom])

            
        }
        
        .onAppear{
            
            _ = isInternetConnected()
            if products.items.count > 0 {
                self.price = IAPManager.shared.getPriceFormatted(for: self.products.items[0]) ?? ""
            }
            isUnlock = UserDefaults.standard.bool(forKey: "unlocked")
        }
    }
    func isInternetConnected() -> Bool {
        internetMonitor.check()
        return internetMonitor.isConnected
    }
    
}

//struct UnlockBookView_Previews: PreviewProvider {
//    static var previews: some View {
//        UnlockBookView()
//    }
//}
