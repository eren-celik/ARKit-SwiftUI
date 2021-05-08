//
//  BrowseView.swift
//  SwiftUIArkit
//
//  Created by Eren  Çelik on 8.05.2021.
//

import SwiftUI

struct BrowseView : View {
    
    @Binding var showBrowse : Bool
    
    var body: some View{
        NavigationView{
            ScrollView(showsIndicators: false){
                ModelsByCategoryGrid(showBrowse: $showBrowse)
            }
            .navigationBarTitle("Browse", displayMode: .large)
            .navigationBarItems(trailing: Button(action: {
                self.showBrowse.toggle()
            }, label: {
                Text("Done")
                    .bold()
            }))
        }
    }
}

struct ModelsByCategoryGrid : View{
    @Binding var showBrowse : Bool
    let models = Models()
    
    var body: some View{
        VStack{
            ForEach(ModelCategory.allCases, id: \.self) { category in
                if let modelsBYCAtegory = models.get(category: category) {
                    HorizontalGrid(showBrowse: $showBrowse, title: category.label, items: modelsBYCAtegory)
                }
            }
        }
    }
}

struct HorizontalGrid : View {
    @EnvironmentObject var placementSetting : PlaceMentSetting
    @Binding var showBrowse : Bool
    var title : String
    var items : [Model]
    private let gridItemLayout = [GridItem(.fixed(150))]
    
    var body: some View {
        VStack(alignment: .leading){
            Divider()
                .padding()
            
            Text(title)
                .font(.title)
                .bold()
                .padding(.leading , 22)
                .padding(.top,10)
            ScrollView(.horizontal, showsIndicators: false){
                LazyHGrid(rows: gridItemLayout,spacing: 30){
                    ForEach(0..<items.count, id : \.self) { index in
                        let model = items[index]
                        Button(action: {
                            self.showBrowse = false
                            model.asyncModel()
                            self.placementSetting.selectedModel = model
                        }, label: {
                            Text(model.name)
                        })
                    }
                }
                .padding(.horizontal , 22)
                .padding(.vertical , 10)
            }
        }
    }
}
