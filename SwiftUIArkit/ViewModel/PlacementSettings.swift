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
            self.recentlyPlaced.append(model)
        }
    }
    //This property retains a record of placed model in the scene. The last element in the array is the most recently placed model
    @Published var recentlyPlaced : [Model] = []
    
    var sceneObserver : Cancellable?
    
}
