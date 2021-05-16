//
//  SessionSettings.swift
//  SwiftUIArkit
//
//  Created by Eren  Çelik on 16.05.2021.
//

import Foundation

class SessionSettings: ObservableObject {
    @Published var isPeopleOcculisionEnabled : Bool = true
    @Published var isObjectOcculisionEnabled : Bool = true
    @Published var isLidarDebugEnabled : Bool = true
    @Published var isMultiUserEnabled : Bool = true
}
