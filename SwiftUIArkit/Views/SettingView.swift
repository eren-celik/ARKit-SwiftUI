//
//  SettingView.swift
//  SwiftUIArkit
//
//  Created by Eren  Çelik on 16.05.2021.
//

import SwiftUI

enum Settings {
    case peopleOcculison
    case objectOcculision
    case lidarDebug
    case multiUser
    
    var label : String{
        get{
            switch self{
            case .peopleOcculison, .objectOcculision:
                return "Occulison"
            case .lidarDebug:
                return "Lidar Debug"
            case .multiUser:
                return "Multi User"
            }
        }
    }
    
    var systemIconName : String{
        get{
            switch self{
            case .peopleOcculison:
                return "person"
            case .objectOcculision:
                return "cube.box.fill"
            case .lidarDebug:
                return "light.min"
            case .multiUser:
                return "person.2"
            }
        }
    }
}

struct SettingsView : View {
    @Binding var showSetting : Bool
    var body: some View{
        NavigationView{
            SettingGrid()
                .navigationBarTitle("Settings", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.showSetting.toggle()
                }, label: {
                    Text("Done")
                        .bold()
                }))
        }
    }
}

struct SettingGrid : View {
    
    @EnvironmentObject var sessionSetting : SessionSettings
    private var gridItemLayout = [GridItem(.adaptive(minimum: 100, maximum: 100),spacing: 25)]
    
    var body: some View{
        ScrollView{
            LazyVGrid(columns: gridItemLayout , spacing : 25){
                SettingToggleButton(setting: .peopleOcculison, isOn: $sessionSetting.isPeopleOcculisionEnabled)
                SettingToggleButton(setting: .objectOcculision, isOn: $sessionSetting.isObjectOcculisionEnabled)
                SettingToggleButton(setting: .lidarDebug, isOn: $sessionSetting.isLidarDebugEnabled)
                SettingToggleButton(setting: .multiUser, isOn: $sessionSetting.isMultiUserEnabled)
            }
        }
    }
}

struct SettingToggleButton : View {
    let setting : Settings
    @Binding var isOn : Bool
    
    var body: some View{
        Button(action: {
            self.isOn.toggle()
            print("\(#file) - \(setting) - \(self.isOn)")
        }, label: {
            VStack{
                Image(systemName: setting.systemIconName)
                    .font(.system(size: 35))
                    .foregroundColor(self.isOn ? .green : Color(UIColor.secondaryLabel))
                    .buttonStyle(PlainButtonStyle())
                
                Text(setting.label)
                    .font(.system(size: 17, weight: .medium, design: .rounded))
                    .foregroundColor(self.isOn ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
                    .padding(.top , 5)
            }
            .frame(width: 100, height: 100)
            .background(Color(UIColor.secondarySystemFill))
            .cornerRadius(20.0)
        })
    }
    
    
}
