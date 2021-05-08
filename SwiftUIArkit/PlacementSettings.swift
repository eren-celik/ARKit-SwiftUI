//
//  PlacementSettings.swift
//  SwiftUIArkit
//
//  Created by Eren  Çelik on 8.05.2021.
//

import SwiftUI
import RealityKit
import Combine

class PlaceMentSetting : ObservableObject{
    
    @Published var selectedModel : Model?{
        willSet(newValue){
            print("Setting Selectec \(String(describing: newValue?.name))")
        }
    }
    @Published var confirmedModel : Model?{
        willSet(newValue){
            guard let model = newValue else {
                print("Clearing Model")
                return
            }
            print("Setting confirmed Model \(model.name)")
        }
    }
    
    var sceneObserver : Cancellable?
    
}
