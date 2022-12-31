//
//  SearchBar.swift
//  tabnewsios
//
//  Created by Luiz Eduardo Mello dos Reis on 31/12/22.
//
import SwiftUI

struct SearchBar: View {

    // MARK: - PROPERTY WRAPPERS
    @Binding var searchText: String
    @Binding var isSearching: Bool

    // MARK: - VARIABLES
    var searchPlaceHolder: String
    var searchCancel: String

    var body: some View {
        HStack(spacing: 0) {
            HStack {
                TextField(searchPlaceHolder, text: $searchText)
                    .padding(.leading, 30)
                    .foregroundColor(Color.primary)
            }
            .padding(5)
            .onTapGesture(perform: {
                withAnimation {
                    isSearching = true
                }
            })
            .background(RoundedRectangle(cornerRadius: 10).fill(Color("CardColor")).frame( height: 50))
            .padding(.horizontal)
            .overlay(
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("CardColor"), lineWidth: 1)
                        .frame( height: 35)
                        .padding(.horizontal)
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Spacer()

                        if isSearching {
                            Button(action: { searchText = "" }, label: {
                                Image(systemName: "xmark.circle.fill")
                                    .padding(.vertical)
                            })

                        }

                    }.padding(.horizontal, 25)
                    .foregroundColor(Color(.gray))
                }

            ).transition(.move(edge: .trailing))

            if isSearching {
                Button(action: {

                    withAnimation {
                        isSearching = false
                        searchText = ""

                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }

                }, label: {
                    Text(searchCancel)
                        .font(.body)
                        .padding(.trailing)
                        .padding(.leading, 0)
                })
                .transition(.move(edge: .trailing))
            }

        }
    }
    struct SearchBar_Preview: PreviewProvider {
        static var previews: some View {
            SearchBar(searchText: .constant(""), isSearching: .constant(true), searchPlaceHolder: "Pesquisar", searchCancel: "Cancelar")
        }
    }
}
