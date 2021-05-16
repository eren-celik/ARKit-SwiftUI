//
//  ControlView.swift
//  SwiftUIArkit
//
//  Created by Eren  Çelik on 8.05.2021.
//

import SwiftUI


struct ControlView : View {
    @Binding var isControlsVisible : Bool
    @Binding var showBrowse : Bool
    
    var body : some View{
        VStack {
            ControlVisibilityToggleButton(isControlsVisible: $isControlsVisible)
            
            Spacer()
            
            if isControlsVisible {
                ControlButtonBar(showBrowse: $showBrowse)
            }
            
        }
    }
}

struct ControlVisibilityToggleButton : View {
    
    @Binding var isControlsVisible : Bool
    
    var body: some View{
        HStack{
            Spacer()
            
            ZStack{
                Color.black.opacity(0.25)
                Button(action: {
                    self.isControlsVisible.toggle()
                }, label: {
                    Image(systemName: self.isControlsVisible ? "rectangle" : "slider.horizontal.below.rectangle")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .buttonStyle(PlainButtonStyle())
                })
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8)
        }
        .padding(.top,45)
        .padding(.trailing,25)
        
    }
}

struct ControlButtonBar : View {
    @EnvironmentObject var placementSettings : PlaceMentSetting
    @Binding var showBrowse : Bool
    var body: some View{
        HStack{
            
            MostRecentltPlacedButton().self.hidden(self.placementSettings.recentlyPlaced.isEmpty)
            
            Spacer()
            
            ControlButton(systemIconName: "square.grid.2x2") {
                self.showBrowse.toggle()
            }
            .sheet(isPresented: $showBrowse, content: {
                BrowseView(showBrowse: $showBrowse)
            })
            
            Spacer()
            
            ControlButton(systemIconName: "slider.horizontal.3") {
                print("sli button pressed")
            }
        }
        .frame(maxWidth: 500)
        .padding(30)
        .background(Color.black.opacity(0.25))
    }
}

struct ControlButton: View {
    
    let systemIconName : String
    let action : () -> Void
    
    var body: some View{
        Button(action: self.action, label: {
            Image(systemName: self.systemIconName)
                .font(.system(size: 35))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        })
        .frame(width: 50, height: 50)
    }
}

struct MostRecentltPlacedButton : View {
    @EnvironmentObject var placementSettings : PlaceMentSetting
    var body: some View{
        Button {
            print("most recenlt pressed")
            self.placementSettings.selectedModel = self.placementSettings.recentlyPlaced.last
        } label: {
            if let mostRecentltyModel = self.placementSettings.recentlyPlaced.last{
                Text(mostRecentltyModel.name)
                //.aspectRatio(1/1 )
            }
        }
        .frame(width: 50, height: 50)
        .background(Color.white)
        .cornerRadius(8.0)
        
    }
}
