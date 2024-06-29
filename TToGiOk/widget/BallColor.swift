//
//  BallColor.swift
//  TToGiOk
//
//  Created by Jihaha kim on 6/29/24.
//

import SwiftUI

enum BallColor: String, CaseIterable, Identifiable {
    case lilac
    case lotus
    case clay
    case moss
    case peri
    case cranite
    case hawthron
    case elderberry
    
    var id: UUID { UUID() }
    
    var color: Color {
        switch self {
        case .lilac:
                .init(red: 197/255, green: 172/255, blue: 175/255)
        case .lotus:
                .init(red: 174/255, green: 125/255, blue: 158/255)
        case .clay:
                .init(red: 210/255, green: 146/255, blue: 125/255)
        case .moss:
                .init(red: 205/255, green: 183/255, blue: 125/255)
        case .peri:
                .init(red: 103/255, green: 104/255, blue: 172/255)
        case .cranite:
                .init(red: 133/255, green: 159/255, blue: 146/255)
        case .hawthron:
                .init(red: 139/255, green: 75/255, blue: 94/255)
        case .elderberry:
                .init(red: 159/255, green: 130/255, blue: 149/255)
        }
    }
}
