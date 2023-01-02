//
//  ListDetailWatch.swift
//  tabwatch Watch App
//
//  Created by Luiz Eduardo Mello dos Reis on 01/01/23.
//

import SwiftUI

struct ListDetailWatch: View {
    @State var bodyContent = ""
    @ObservedObject var viewModel: ListViewModel
    var content: ContentModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text(content.title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.bottom, 5)
                    Spacer()
                }
                VStack(alignment: .leading){
                    Text(content.owner_username)
                        .font(.footnote)
                    Text(getFormattedDate(value: content.published_at))
                        .font(.footnote)
                        .italic()
                }
                .foregroundColor(.gray)
                Divider()
                MDText(markdown: String(viewModel.bodyText.prefix(600) + "...")).font(.footnote)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            Button {
                viewModel.likeContentList(content: content)
                WatchConnectivityManager.shared.send(content.title)
            } label: {
                Text("Curtir para ver depois")
                    .font(.footnote)
                    .foregroundColor(.white)
            }
        }
    }
}

struct ListDetailWatch_Previews: PreviewProvider {
    static var viewModel = ListViewModel()
    static var content: ContentModel = ContentModel(title: "Please Start Writing Better Git Commits", owner_username: "luizmello.dev", owner_id: "asdadassd", slug: "asdadasdasS", published_at: "Jul 19, 2022")
    
    static var previews: some View {
        ListDetailWatch(viewModel: viewModel, content: content)
    }
}
