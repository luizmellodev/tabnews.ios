//
//  CustomOptionView.swift
//  tabnewsios
//
//  Created by Luiz Eduardo Mello dos Reis on 31/12/22.
//

import SwiftUI

struct CustomOptionView: View {
    
    var optionLeadingIcon: String
    var optionName: String
    var optionSubtitle: String?
    var destinationLinkURL: String?
    var destinationView: AnyView?
    var inlineView: AnyView?
    
    var body: some View {
        HStack {
            VStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.white))
                    .frame(width: 30, height: 30)
                    .overlay {
                        Image(systemName: optionLeadingIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 15)
                            .foregroundColor(.white)
                    }
                Divider()
                    .hidden()
                    .frame(width: 30)
            }
            VStack {
                if let inlineView {
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(optionName)
                                    .font(.body)
                                    .fontWeight(.regular)
                                if let optionSubtitle {
                                    Text(optionSubtitle)
                                        .font(.footnote)
                                        .fontWeight(.regular)
                                        .lineLimit(1)
                                }
                            }
                            Spacer()
                            inlineView
                                .frame(width: 70)
                        }
                        Divider()
                            .background(Color(.tertiaryLabel))
                    }
                } else if let destinationLinkURL {
                    Link(destination: URL(string: destinationLinkURL)!, label: {
                        VStack {
                            HStack {
                                Text(optionName)
                                    .font(.body)
                                    .fontWeight(.regular)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(.tertiaryLabel))
                                    .padding(.trailing)
                            }
                            Divider()
                                .background(Color(.tertiaryLabel))
                        }
                    })
                } else {
                    NavigationLink {
                        destinationView != nil ? destinationView : AnyView(EmptyView())
                    } label: {
                        VStack {
                            HStack {
                                Text(optionName)
                                    .font(.body)
                                    .fontWeight(.regular)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(.tertiaryLabel))
                                    .padding(.trailing)
                            }
                            Divider()
                                .background(Color(.tertiaryLabel))
                        }
                    }
                }
            }
        }
    }
}

struct CustomOptionView_Previews: PreviewProvider {
    static var previews: some View {
        CustomOptionView(optionLeadingIcon: "clock", optionName: "Option 1")
    }
}
