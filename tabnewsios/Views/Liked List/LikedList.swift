//
//  LikedList.swift
//  tabnewsios
//
//  Created by Luiz Eduardo Mello dos Reis on 31/12/22.
//

import SwiftUI

struct LikedList: View {
    @ObservedObject var viewModel: ListViewModel
    @Binding var isViewInApp: Bool
    @Binding var showSnack: Bool

    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                Image("ruido")
                    .resizable()
                    .scaledToFill()
                    .blendMode(.overlay)
                    .ignoresSafeArea()
                if viewModel.likedList.isEmpty {
                    VStack {
                        Text("Ops! Você ainda não curtiu nenhum conteúdo")
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .bold()
                            .foregroundColor(.gray)
                        
                        Image(systemName: "trash")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60)
                            .foregroundColor(.gray)
                        
                    }
                } else {
                    List {
                        HStack {
                            Text("Seus favoritos")
                                .font(.title)
                                .fontWeight(.semibold)
                                .padding(.vertical, 10)
                            Spacer()
                        }
                        ForEach(Array(zip(viewModel.likedList.indices, viewModel.likedList)), id: \.0) {index, content in
                            NavigationLink(destination: isViewInApp ?
                                           AnyView(
                                            ListDetailView(viewModel: viewModel, showSnack: $showSnack, content: content)) : AnyView(ContentDetailView(bodyContent: "", viewModel: viewModel, content: content))) {
                                                HStack {
                                                    Text(content.title)
                                                }
                                            }
                        }
                        .onDelete(perform: removeRows)
//                        .onMove(perform: move)
                    }
                    .padding(.top, 60)
                    .refreshable {
                        viewModel.getRecentContent()
                    }
                }
            }
        }
        .onAppear {
            viewModel.getLikedContent()
        }
    }
//    func move(from source: IndexSet, to destination: Int) {
//        viewModel.recentContentList.move(fromOffsets: source, toOffset: destination)
//    }
    
    func removeRows(at offsets: IndexSet) {
        viewModel.likedList.remove(atOffsets: offsets)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(viewModel.likedList) {
            viewModel.defaults.set(encoded, forKey: "LikedContent")
        }
        
    }
}

struct LikedListView_Previews: PreviewProvider {
    static var viewModel: ListViewModel = ListViewModel()
    static var previews: some View {
        LikedList(viewModel: viewModel, isViewInApp: .constant(true), showSnack: .constant(true))
    }
}
