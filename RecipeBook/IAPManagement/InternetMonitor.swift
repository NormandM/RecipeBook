//
//  InternetMonitor.swift
//  RecipeBook
//
//  Created by NORMAND MARTIN on 2021-02-02.
//

import SwiftUI
import Network

class InternetMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    @Published var isConnected: Bool = false
    func check() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self.isConnected = true
                } else {
                    self.isConnected = false
                }
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
