//
//  ContentView.swift
//  tabnewsios
//
//  Created by Luiz Eduardo Mello dos Reis on 30/12/22.
//

import SwiftUI
import SwiftUISnackbar
import Foundation
import WatchConnectivity

struct ContentView: View {
    @StateObject var viewModel: ListViewModel = ListViewModel()
    @State var searchText: String
    @State var showSnack: Bool = false
    @State var isSearching = false
    @State var isViewInApp: Bool = true
    @AppStorage("current_theme") var currentTheme: Theme = .light
    var body: some View {
        TabView {
            ListView(viewModel: viewModel, searchText: $searchText, showSnack: $showSnack, isSearching: $isSearching, isViewInApp: $isViewInApp)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            
            LikedList(viewModel: viewModel, isViewInApp: $isViewInApp, showSnack: $showSnack)
                .tabItem {
                    Label("Curtidas", systemImage: "heart.fill")
                }
            
            SettingsView(isViewInApp: $isViewInApp, viewModel: viewModel, currentTheme: $currentTheme)
                .tabItem {
                    Label("Configurações", systemImage: "gearshape.fill")
                }
        }
        .onAppear {
            viewModel.saveInAppSettings(viewInApp: isViewInApp)
        }
        .preferredColorScheme(currentTheme.colorScheme)
        .snackbar(isShowing: $showSnack, title: "Adicionado a sua lista de favoritos!", style: .default)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(searchText: "")
    }
}
