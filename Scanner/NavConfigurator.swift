//
//  NavConfigurator.swift
//  Scanner
//
//  Created by EgorM on 22.01.2022.
//

import Foundation
import SwiftUI
import UIKit
struct NavAppearanceModifier: ViewModifier {
    init(backgroundColor: UIColor, foregroundColor: UIColor, tintColor: UIColor?, hideSeparator: Bool) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: foregroundColor]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: foregroundColor]
        navBarAppearance.backgroundColor = backgroundColor
        if hideSeparator {
            navBarAppearance.shadowColor = .clear
        }
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        if let tintColor = tintColor {
            UINavigationBar.appearance().tintColor = tintColor
        }
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func navigationAppearance(backgroundColor: UIColor, foregroundColor: UIColor, tintColor: UIColor? = nil, hideSeparator: Bool = false) -> some View {
        self.modifier(NavAppearanceModifier(backgroundColor: backgroundColor, foregroundColor: foregroundColor, tintColor: tintColor, hideSeparator: hideSeparator))
        
    }
}
