//
//  ContentView.swift
//  tabwatch Watch App
//
//  Created by Luiz Eduardo Mello dos Reis on 30/12/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModelWatch: ListViewModel = ListViewModel()
    @ObservedObject var connectivityManager: WatchConnectivityManager = ListViewModel().connectivityManager
    var body: some View {
        NavigationStack {
            VStack {
                Text("Bem vindo(a) ao TabNews para Watch!")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
            }
            List {
                NavigationLink(destination: ContentList(connectivityManager: connectivityManager, viewModel: viewModelWatch)) {
                    Text("Ver últimas notícias")
                }
                
                NavigationLink(destination: LikedContent(connectivityManager: connectivityManager, viewModel: viewModelWatch)) {
                    Text("Ver notícias curtidas")
                }
            }
        }
            //            Button("Hello World!", action: {
            //                WatchConnectivityManager.shared.send("Hello World!\n\(Date().ISO8601Format())")
            //            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
