//
//  CustomARView.swift
//  SwiftUIArkit
//
//  Created by Eren  Çelik on 8.05.2021.
//

import RealityKit
import ARKit
import  FocusEntity

class CustomArView : ARView{
    
    var focusEntity : FocusEntity?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        focusEntity = FocusEntity(on: self, focus: .classic)
        
        configure()
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal , .vertical]
        session.run(config)
    }
}
