//
//  View+.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

extension View {
    // center, left, right
    func customNavigationBar<C, L, R>(
        centerView: @escaping (() -> C),
        leftView: @escaping (() -> L),
        rightView: @escaping (() -> R),
        height: CGFloat
    ) -> some View where C: View, L: View, R: View {
        modifier(
            NavigationBarModifier(centerView: centerView,
                                  leftView: leftView,
                                  rightView: rightView,
                                  height: height)
        )
    }
    
    // center, left
    func customNavigationBar<C, L>(
        centerView: @escaping (() -> C),
        leftView: @escaping (() -> L),
        height: CGFloat
    ) -> some View where C: View, L: View {
        modifier(
            NavigationBarModifier(centerView: centerView,
                                  leftView: leftView,
                                  rightView: {
                                      EmptyView()
                                  },
                                  height: height)
        )
    }
    
    // center, right
    func customNavigationBar<C, R>(
        centerView: @escaping (() -> C),
        rightView: @escaping (() -> R),
        height: CGFloat
    ) -> some View where C: View, R: View {
        modifier(
            NavigationBarModifier(centerView: centerView,
                                  leftView: {
                                      EmptyView()
                                  },
                                  rightView: rightView,
                                  height: height)
        )
    }
}
