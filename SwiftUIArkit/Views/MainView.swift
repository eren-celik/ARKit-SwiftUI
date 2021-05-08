//
//  ContentView.swift
//  SwiftUIArkit
//
//  Created by Eren  Çelik on 6.05.2021.
//

import SwiftUI
import RealityKit
import SceneKit

struct MainView : View {
    @EnvironmentObject var placementSettings : PlaceMentSetting
    @State private var isControlsVisible : Bool = true
    @State private var showBrowse : Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer()
            if self.placementSettings.selectedModel == nil {
                ControlView(isControlsVisible: $isControlsVisible, showBrowse: $showBrowse)
            }else{
                PlacementView()
            }
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var placementSetting : PlaceMentSetting
    
    func makeUIView(context: Context) -> CustomArView {
        let arView = CustomArView(frame: .zero)
        self.placementSetting.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self, { event in
            self.updateScene(for: arView)
        })
        return arView
    }
    
    func updateUIView(_ uiView: CustomArView, context: Context) {}
    
    private func updateScene(for arView : CustomArView){
        arView.focusEntity?.isEnabled = self.placementSetting.selectedModel != nil
        
        if let confirmedModel = self.placementSetting.confirmedModel , let modelEntity = confirmedModel.modelEntity {
            self.place(modelEntity, in: arView)
            self.placementSetting.confirmedModel = nil
        }
    }
    private func place(_ modelEntity : ModelEntity , in arView : ARView){
        let clonedEntity = modelEntity.clone(recursive: true)
        
        clonedEntity.generateCollisionShapes(recursive: true)
        arView.installGestures([.all], for: clonedEntity)
        
        let anchorEntity = AnchorEntity(plane: .any)
        anchorEntity.addChild(clonedEntity)
        arView.scene.addAnchor(anchorEntity)
    }
}

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(PlaceMentSetting())
    }
}
