//
//  ListView.swift
//  tabnewsios
//
//  Created by Luiz Eduardo Mello dos Reis on 31/12/22.
//
//
//  ListView.swift
//  tabnews-ios
//
//  Created by Luiz Eduardo Mello dos Reis on 24/11/22.
//

import SwiftUI


//ForEach(Array(zip(contentList.indices, searchText.isEmpty ? contentList : contentList.filter { $0.title.contains(searchText) })), id: \.0) {index, content in

struct ListView: View {
    @ObservedObject var viewModel: ListViewModel
    @GestureState var press = false
    @Binding var searchText: String
    @Binding var showSnack: Bool
    @Binding var isSearching: Bool
    @Binding var isViewInApp: Bool
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                Image("ruido")
                    .resizable()
                    .scaledToFill()
                    .blendMode(.overlay)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                VStack {
                    Text("Tab News")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 120)
                    
                    SearchBar(searchText: $searchText, isSearching: $isSearching, searchPlaceHolder: "Pesquisar", searchCancel: "Cancelar")
                        .padding(.bottom, 10)
                    ListComponent(viewModel: viewModel, searchText: $searchText, showSnack: $showSnack, isViewInApp: $isViewInApp, isSearching: $isSearching)
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var viewModel: ListViewModel = ListViewModel()
    static var previews: some View {
        ListView(viewModel: viewModel, searchText: .constant(""), showSnack: .constant(true), isSearching: .constant(true), isViewInApp: .constant(true))
    }
}
