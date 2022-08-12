//
//  ContentView.swift
//  UI-641
//
//  Created by nyannyan0328 on 2022/08/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            
            Home()
                  .navigationTitle("Tool Postion")
                  .toolbarBackground(Color.red, for: .navigationBar)
                  .toolbarBackground(.visible, for: .navigationBar)
                

            
            
        }    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
