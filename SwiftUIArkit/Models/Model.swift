//
//  Model.swift
//  SwiftUIArkit
//
//  Created by Eren  Çelik on 8.05.2021.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory : CaseIterable{
    case table
    case chair
    case decoration
    case light
    
    var label : String{
        get{
            switch self {
            case .table:
                return "Tables"
            case .chair:
                return "Chairs"
            case .decoration:
                return "Decorations"
            case .light:
                return "Lights"
            }
        }
    }
}


class Model {
    var name : String
    var category : ModelCategory
    var modelEntity : ModelEntity?
    var scaleCompenstation : Float
    private var cancel : AnyCancellable?
    
    
    init(name : String , category : ModelCategory , scaleCompenstation : Float = 1.0) {
        self.name = name
        self.category = category
        self.scaleCompenstation = scaleCompenstation
    }
    func asyncModel() {
        let filename = self.name + ".usdz"
        self.cancel = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { _ in}) { entity in
                self.modelEntity = entity
                self.modelEntity?.scale *= self.scaleCompenstation
                print("model loaded \(self.name)")
            }
    }
}
struct Models {
    var all : [Model] = []
    
    init() {
        let chair = Model(name: "chair_swan", category: .chair, scaleCompenstation: 38/100)
        self.all += [chair]
    }
    func get(category : ModelCategory) -> [Model] {
        return all.filter( { $0.category == category } )
    }
}
