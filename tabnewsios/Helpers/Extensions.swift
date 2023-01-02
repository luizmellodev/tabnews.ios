//
//  Extensions.swift
//  tabnewsios
//
//  Created by Luiz Eduardo Mello dos Reis on 31/12/22.
//

import SwiftUI

//
//  Extensions.swift
//  LauncScreen
//
//  Created by Balaji on 01/07/22.
//

import SwiftUI

extension View {
    // MARK: Safe Area Value
    #if os(iOS)
    func safeArea()->UIEdgeInsets {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        guard let safeArea = window.windows.first?.safeAreaInsets else { return .zero }
        
        return safeArea
    }
    #endif
}
public func getFormattedDate(value: String) -> String {
    let dateFormat = DateFormatter()
    dateFormat.locale = Locale(identifier: "pt_br")
    dateFormat.dateFormat = "EEEE, dd MMMM"
    let stringDate = dateFormat.string(from: Date())
    return stringDate
}

enum Theme: Int {
    case light
    case dark
    
    var colorScheme: ColorScheme {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
