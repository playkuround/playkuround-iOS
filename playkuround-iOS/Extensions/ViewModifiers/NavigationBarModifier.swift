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
    let height: CGFloat
    
    init(centerView: (() -> C)? = nil, leftView: (() -> L)? = nil, rightView: (() -> R)? = nil, height: CGFloat) {
        self.centerView = centerView
        self.leftView = leftView
        self.rightView = rightView
        self.height = height
    }
    
    func body(content: Content) -> some View {
        VStack {
            ZStack {
                HStack {
                    self.leftView?()
                    
                    Spacer()
                    
                    self.rightView?()
                }
                .frame(height: height)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                
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
        .navigationBarHidden(true)
    }
}
