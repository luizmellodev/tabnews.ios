//
//  ContentList.swift
//  tabwatch Watch App
//
//  Created by Luiz Eduardo Mello dos Reis on 01/01/23.
//

import SwiftUI

struct ContentList: View {
    @ObservedObject var connectivityManager: WatchConnectivityManager
    @StateObject var viewModel: ListViewModel
    var body: some View {
        List {
            ForEach(Array(zip(viewModel.relevantContentList.indices, viewModel.relevantContentList)), id: \.0) { index, content in
                NavigationLink(destination: ListDetailWatch(viewModel: viewModel, content: content)) {
                    Text(String(content.title.prefix(52) + "..."))
                        .font(.footnote)
                }
            }
        }    }
}

struct ContentList_Previews: PreviewProvider {
    static var connectivityManager: WatchConnectivityManager = WatchConnectivityManager.shared
    static var viewModel: ListViewModel = ListViewModel()
    static var previews: some View {
        ContentList(connectivityManager: connectivityManager, viewModel: viewModel)
    }
}
