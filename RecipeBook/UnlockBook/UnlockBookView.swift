//
//  UnlockBookView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2021-01-27.
//

import SwiftUI
import StoreKit
import Combine

struct UnlockBookView: View {
    @State private var isUnlock: Bool = false
    var iapManager = IAPManager()
    @State private var isNotConnectedNoReason = false
    @State private var showingAlertNoConnection = false
    @State private var price = ""
    @State private var showAlertPurchased = false
    @ObservedObject var products = productsDB.shared
    let publisher = IAPManager.shared.purchasePublisher
    @State private var showAlerts = false
    let iNAPAlerts = INAPAlerts.showNotConnected
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Enter  all your recepies  for:")
                Text(self.price)
                Image("IconeRecipe")
                    .resizable()
                    .border(Color.black, width: 1)
                    .frame(width: geo.size.height * 0.2, height: geo.size.height * 0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding()
                Button(action: {
                    isUnlock = true
                    if self.isNotConnectedNoReason {
                        self.showingAlertNoConnection = true
                    }else{
                        _ = IAPManager.shared.purchaseV5(product: self.products.items[0])
                    }
                }) {
                    VStack {
                        Image(isUnlock ? "unlock" : "lock")
                            .resizable()
                            .frame(width: geo.size.height * 0.12, height: geo.size.height * 0.12, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(.top)
                        Text("Unlock")
                        
                    }
                    
                }
                .alert(isPresented: self.$showAlerts) {
                    Alert(title: Text("You are not connected to the internet"), message: Text("You cannot make a purchase"), dismissButton: .default(Text("OK")){
                        })
                }
//                .alert(isPresented: self.$showAlertPurchased) {
//                    Alert(title: Text("Your recipe book is unlocked"), message: Text(""), dismissButton: .default(Text("OK")){
//                        })
//                }
                
                .padding(.bottom)
                Text("Already purchased unlocked?")
    //                .alert(isPresented: $showAlerts) {
    //                    switch iNAPAlerts {
    //                    case .showNotConnected:
    //                        return Alert(title: Text("You are not connected to the internet"), message: Text("You cannot make a purchase"), dismissButton: .default(Text("OK")){
    //                            })
    //                    case .showPurchaseCompleted:
    //                        return                     Alert(title: Text("Your recipe book is unlocked"), message: Text(""), dismissButton: .default(Text("OK")){
    //                        })
    //                    case .payementCanceled:
    //                        return Alert(title: Text(""))
    //                    case .showPurchaseRestored:
    //                        return Alert(title: Text(""))
    //                    case .showNoPurchaseToResore:
    //                        return Alert(title: Text(""))
    //
    //                    }
    //                }
                Button(action: {
                    IAPManager.shared.restorePurchasesV5()
                }) {
                    VStack {
                        Image("RestorePurchase")
                            .resizable()
                            .frame(width: geo.size.height * 0.10, height: geo.size.height * 0.10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Text("Restore")
                    }
                }
                .onReceive(publisher, perform: {value in
                    print("in")
                    showAlerts = true
                    print(value.0)
                    

                })
                

                
            }

            .navigationBarTitle("Unlock Book", displayMode: .inline)
            .navigationBarColor(UIColorReference.specialGreen)
            .background(ColorReference.specialSand)
            .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
            
        }
        .onAppear{
            self.price = IAPManager.shared.getPriceFormatted(for: self.products.items[0]) ?? ""
            let reachability = Reachability()
            let isConnected = reachability.isConnectedToNetwork()
            IAPManager.shared.getProductsV5()
            self.isNotConnectedNoReason = false
            if !isConnected{
                self.isNotConnectedNoReason = true
                print("not connected")
            }
            
        }
    }
    
}

struct UnlockBookView_Previews: PreviewProvider {
    static var previews: some View {
        UnlockBookView()
    }
}
