//
//  NavigationBarModifier.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct NavigationBarModifier<C, L, R>: ViewModifier where C: View, L: View, R: View {
    let centerView: (() -> C)?
    let leftView: (() -> L)?
    let rightView: (() -> R)?
    
    init(centerView: (() -> C)? = nil, leftView: (() -> L)? = nil, rightView: (() -> R)? = nil) {
        self.centerView = centerView
        self.leftView = leftView
        self.rightView = rightView
    }
    
    func body(content: Content) -> some View {
        VStack {
            ZStack {
                HStack {
                    self.leftView?()
                    
                    Spacer()
                    
                    self.rightView?()
                }
                .frame(minWidth: .infinity)
                
                HStack {
                    Spacer()
                    
                    self.centerView?()
                    
                    Spacer()
                }
            }
            .background(Color(.kuBackground).ignoresSafeArea(.all, edges: .top))
            
            content
            
            Spacer()
        }
        .toolbar(.hidden)
    }
}
