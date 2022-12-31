//
//  ListComponent.swift
//  tabnewsios
//
//  Created by Luiz Eduardo Mello dos Reis on 31/12/22.
//

import SwiftUI

struct ListComponent: View {
    @ObservedObject var viewModel: ListViewModel
    @Binding var searchText: String
    @Binding var showSnack: Bool
    @Binding var isViewInApp: Bool
    @Binding var isSearching: Bool
    
    var body: some View {
        ScrollView {
            ForEach(Array(zip(viewModel.relevantContentList.indices, searchText.isEmpty || !isSearching ? viewModel.relevantContentList : viewModel.relevantContentList.filter { $0.title.contains(searchText.lowercased())})), id: \.0) { index, content in
                NavigationLink { isViewInApp ?
                    AnyView(
                        ListDetailView(viewModel: viewModel, showSnack: $showSnack, content: content)) : AnyView(ContentDetailView(bodyContent: "", viewModel: viewModel, content: content))
                } label: {
                    CardView(title: content.title, user: content.owner_username, date: getFormattedDate(value: content.published_at), bodyContent: viewModel.bodyText, content: content)
                        .padding(.bottom, 30)
                }
                .contextMenu {
                    Button {
                        self.showSnack.toggle()
                        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                        impactHeavy.impactOccurred()
                        viewModel.likeContentList(content: content)
                    } label: {
                        Text("Curtir")
                    }
                }
            }
            .padding(.top, 20)
        }
    }
    @ViewBuilder
    func CardView(title: String, user: String, date: String, bodyContent: String, content: ContentModel?) -> some View {
        if let content {
            VStack (alignment: .leading) {
                Text(title)
                    .multilineTextAlignment(.leading)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .padding(.bottom, 5)
                    .padding(.top, 20)
                HStack {
                    Text(user)
                        .font(.footnote)
                    Spacer()
                    Text(date)
                        .font(.footnote)
                        .italic()
                }
                .foregroundColor(.gray)
                Divider()
                MDText(markdown: String(bodyContent.prefix(300)))
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                    .padding(.bottom, 20)
                NavigationLink {
                    ListDetailView(viewModel: viewModel, showSnack: $showSnack, content: content)
                } label: {
                    HStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(height: 40)
                            .foregroundColor(.black)
                            .overlay {
                                Text("Ler mais")
                                    .foregroundColor(.white)
                            }
                    }
                    .padding(.bottom, 10)
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .padding(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color("CardColor"))
            }
            .frame(height: 300)
            .padding(.horizontal)
        }
    }
}

struct ListComponent_Previews: PreviewProvider {
    static var viewModel: ListViewModel = ListViewModel()
    static var press: Bool = false
    static var searchText: String = ""
    static var showsnack = false
    static var previews: some View {
        ListComponent(viewModel: viewModel, searchText: .constant(searchText), showSnack: .constant(true), isViewInApp: .constant(true), isSearching: .constant(true))
    }
}
