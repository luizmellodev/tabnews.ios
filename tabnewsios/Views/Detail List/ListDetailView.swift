//
//  ListDetailView.swift
//  tabnewsios
//
//  Created by Luiz Eduardo Mello dos Reis on 31/12/22.
//

import SwiftUI

struct ListDetailView: View {
    @State var bodyContent = ""
    @ObservedObject var viewModel: ListViewModel
    @State private var showingTabNews = false
    @Binding var showSnack: Bool
    @Environment(\.presentationMode) var presentationMode
    var content: ContentModel
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text(content.title)
                            .padding(.top, 30)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.bottom, 10)
                        Spacer()
                        Button {
                            let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                            impactHeavy.impactOccurred()
                            if viewModel.likedList.contains(where: { $0.title == content.title }) {
                                viewModel.removeContentList(content: content)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            else {
                                self.showSnack.toggle()
                                WatchConnectivityManager.shared.send(content.title)
                                viewModel.likeContentList(content: content)
                            }
                        } label: {
                            if viewModel.likedList.contains { $0.title == content.title } {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.red)
                            } else {
                                Image(systemName: "heart")
                                    .font(.system(size: 20))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    HStack {
                        Text(content.owner_username)
                            .font(.footnote)
                        Spacer()
                        Text(getFormattedDate(value: content.published_at))
                            .font(.footnote)
                            .italic()
                    }
                    .foregroundColor(.gray)
                    Divider()
                    MDText(markdown: viewModel.bodyText)
                }
                .padding(.horizontal, 30)
            }
            .sheet(isPresented: $showingTabNews) {
                ContentDetailView(content: content)
                    .presentationDetents([.large, .large])
                    .presentationDragIndicator(.hidden)
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.showingTabNews = true
                    }, label: {
                        Text("Ler no Tab News")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(Color.blue)
                            }
                            .padding(.trailing, 30)
                            .padding(.bottom, 20)
                    })
                }
            }
        }
    }
}

struct ListDetailView_Previews: PreviewProvider {
    static var viewModel = ListViewModel()
    static var content: ContentModel = ContentModel(title: "Please Start Writing Better Git Commits", owner_username: "luizmello.dev", owner_id: "asdadassd", slug: "asdadasdasS", published_at: "Jul 19, 2022")
    
    static var previews: some View {
        ListDetailView(viewModel: viewModel, showSnack: .constant(true), content: content)
    }
}
