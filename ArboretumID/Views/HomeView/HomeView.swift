//
//  HomeView.swift
//  ArborID
//
//  Created by Taylan Unal on 11/20/20.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
            VStack(spacing:20){
                Image("ArborIDIcon").resizable().frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("ArborID").font(.largeTitle)
                Text("The Arboretum at Penn State is home to more than 28,000 individual plants, in more than 100 families, representing over 1,100 species.")
                    .frame(width: 300, height: nil, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).font(.body)
                Text("ArborID provides visitors to The Penn State Arboretum a brand new way to interact and learn more about the incredible living collections on display at its gardens.")
                    .frame(width: 300, height: nil, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).font(.body)
            }
        }
        } //.navigationBarTitle("Home").navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
