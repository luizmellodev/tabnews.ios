//
//  ContentModel.swift
//  tabnewsios
//
//  Created by Luiz Eduardo Mello dos Reis on 31/12/22.
//

import Foundation
import WidgetKit
import SwiftUI

struct ContentModel: Codable {
    var title: String
    var owner_username: String
    var owner_id: String
    var slug: String
    var published_at: String
}


struct ContentModelDetails: Codable {
    var content: String
}
