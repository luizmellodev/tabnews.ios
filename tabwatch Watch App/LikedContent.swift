//
//  LikedContent.swift
//  tabwatch Watch App
//
//  Created by Luiz Eduardo Mello dos Reis on 01/01/23.
//

import SwiftUI

struct LikedContent: View {
    @ObservedObject var connectivityManager: WatchConnectivityManager
    @ObservedObject var viewModel: ListViewModel

    var body: some View {
        ZStack {
            if viewModel.likedList.isEmpty {
                VStack {
                    Text("Ops! Você ainda não curtiu nenhum conteúdo")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .bold()
                        .foregroundColor(.gray)
                    
                    Image(systemName: "trash")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .foregroundColor(.gray)
                    
                }
            } else {
                List {
                    ForEach(Array(zip(viewModel.likedList.indices, viewModel.likedList)), id: \.0) { index, content in
                        Text(String(content.title.prefix(52) + "..."))
                            .font(.footnote)
                    }
                    .onDelete(perform: removeRows)
                }
                .refreshable {
                    viewModel.getRecentContent()
                }
            }
        }
        .onAppear {
            viewModel.getLikedContent()
        }
    }
    func removeRows(at offsets: IndexSet) {
        viewModel.likedList.remove(atOffsets: offsets)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(viewModel.likedList) {
            viewModel.defaults.set(encoded, forKey: "LikedContent")
        }
        
    }
}

struct LikedContent_Previews: PreviewProvider {
    static var connectivityManager: WatchConnectivityManager = WatchConnectivityManager.shared
    static var viewModel: ListViewModel = ListViewModel()
    static var previews: some View {
        LikedContent(connectivityManager: connectivityManager, viewModel: viewModel)
    }
}
