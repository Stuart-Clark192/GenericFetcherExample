//
//  showView.swift
//  GenericFetcherExample
//
//  Created by Stuart on 24/10/2020.
//

import SwiftUI

struct ShowView: ViewModifier {
    
    var isVisible: Bool
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if isVisible {
            content
        } else {
            content.hidden()
        }
    }
}
