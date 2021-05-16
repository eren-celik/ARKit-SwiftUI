//
//  PlacementView.swift
//  SwiftUIArkit
//
//  Created by Eren  Çelik on 8.05.2021.
//

import SwiftUI


struct PlacementView : View {
    @EnvironmentObject var placementSettings : PlacementSettings
    var body: some View{
        
        HStack{
            Spacer()
            PlacementButton(systemIconName: "xmark.circle.fill") {
                print("cancel perress")
                self.placementSettings.selectedModel = nil
            }
            
            PlacementButton(systemIconName: "checkmark.circle.fill") {
                print("confirm press")
                self.placementSettings.confirmedModel = self.placementSettings.selectedModel
                self.placementSettings.selectedModel = nil
            }
            Spacer()
        }
        .padding(.bottom , 30)
    }
}


struct PlacementButton : View {
    let systemIconName : String
    let action : () -> Void
    
    var body: some View{
        Button(action: {
            self.action()
        }, label: {
            Image(systemName: systemIconName)
                .font(.system(size: 50, weight: .light, design: .rounded))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        })
        .frame(width: 75, height: 75)
    }
}
