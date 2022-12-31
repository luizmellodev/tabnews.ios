//
//  ContentDetailView.swift
//  tabnewsios
//
//  Created by Luiz Eduardo Mello dos Reis on 31/12/22.
//

import SwiftUI

struct ContentDetailView: View {
    @State var bodyContent = ""
    @ObservedObject var viewModel: ListViewModel = ListViewModel()
    var content: ContentModel
    var body: some View {
        VStack {
            HTMLView(request: URLRequest(url: URL(string: "https://www.tabnews.com.br/\(content.owner_username)/\(content.slug)")!)
)
            
        }
        .onAppear {
            viewModel.getContentDetail(username: content.owner_username, slug: content.slug)
        }
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView(content: ContentModel(title: "Text", owner_username: "adsoasdoksa", owner_id: "asdadsj", slug: "asdads", published_at: "asdasd"))
    }
}
