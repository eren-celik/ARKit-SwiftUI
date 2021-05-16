//
//  CustomARView.swift
//  SwiftUIArkit
//
//  Created by Eren  Çelik on 8.05.2021.
//

import RealityKit
import ARKit
import FocusEntity
import SwiftUI
import Combine

class CustomArView : ARView{
    
    var focusEntity : FocusEntity?
    var sessionSettings : SessionSettings
    
    private var peopleOcculisonCancellable : AnyCancellable?
    private var objectOcculisonCancellable : AnyCancellable?
    private var lidarDebugOcculisonCancellable : AnyCancellable?
    private var multiUserOcculisonCancellable : AnyCancellable?
    
    required init(frame frameRect: CGRect , sessionSettings : SessionSettings) {
        
        self.sessionSettings = sessionSettings
        
        super.init(frame: frameRect)
        
        focusEntity = FocusEntity(on: self, focus: .classic)
        configure()
        
        self.initilazeSettings()
        
        self.setupSubsricber()
    }
    
    required init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal , .vertical]
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh){
            //Supported device Lidar Sensor open
            config.sceneReconstruction = .mesh
        }
        
        session.run(config)
    }
    
    private func setupSubsricber(){
        self.peopleOcculisonCancellable = sessionSettings.$isPeopleOcculisionEnabled.sink { [weak self] isEnabled in
            self?.updatePeopleOcculison(isEnabled: isEnabled)
        }
        self.objectOcculisonCancellable = sessionSettings.$isObjectOcculisionEnabled.sink { [weak self] isEnabled in
            self?.updateObjectOcculison(isEnabled: isEnabled)
        }
        self.lidarDebugOcculisonCancellable = sessionSettings.$isLidarDebugEnabled.sink { [weak self] isEnabled in
            self?.updateLidarDebug(isEnabled: isEnabled)
        }
        self.multiUserOcculisonCancellable = sessionSettings.$isMultiUserEnabled.sink { [weak self] isEnabled in
            self?.updateMultiUser(isEnabled: isEnabled)
        }
        
    }
    
    private func updatePeopleOcculison(isEnabled : Bool){
        print("\(#file) isPeopleOcculisonEnabled is now \(isEnabled)")
        
        guard ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) else {
            return
        }
        
        guard let configuration = self.session.configuration as? ARWorldTrackingConfiguration else {
            return
        }
        
        if configuration.frameSemantics.contains(.personSegmentationWithDepth){
            configuration.frameSemantics.remove(.personSegmentationWithDepth)
        }else{
            configuration.frameSemantics.insert(.personSegmentationWithDepth)
        }
        
        self.session.run(configuration)
    }
    
    private func initilazeSettings(){
        self.updatePeopleOcculison(isEnabled: sessionSettings.isPeopleOcculisionEnabled)
        self.updateObjectOcculison(isEnabled: sessionSettings.isObjectOcculisionEnabled)
        self.updateLidarDebug(isEnabled: sessionSettings.isLidarDebugEnabled)
        self.updateMultiUser(isEnabled: sessionSettings.isMultiUserEnabled)
    }
    
    private func updateObjectOcculison(isEnabled : Bool){
        print("\(#file) isPeopleOcculisonEnabled is now \(isEnabled)")
        
        if self.environment.sceneUnderstanding.options.contains(.occlusion){
            self.environment.sceneUnderstanding.options.remove(.occlusion)
        }else{
            self.environment.sceneUnderstanding.options.insert(.occlusion)
        }
    }
    
    private func updateLidarDebug(isEnabled : Bool){
        print("\(#file) isPeopleOcculisonEnabled is now \(isEnabled)")
        
        if self.debugOptions.contains(.showSceneUnderstanding) {
            self.debugOptions.remove(.showSceneUnderstanding)
        }else{
            self.debugOptions.insert(.showSceneUnderstanding)
        }
    }
    
    private func updateMultiUser(isEnabled : Bool){
        print("\(#file) isPeopleOcculisonEnabled is now \(isEnabled)")
    }
    
}
