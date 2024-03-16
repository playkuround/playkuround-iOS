//
//  AnimationCustomView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/16/24.
//

import Combine
import SwiftUI

struct AnimationCustomView: View {
    @State var imageArray: [String]
    @State var delayTime: Double
    @State private var currentIndex = 0
    private var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    init(imageArray: [String], delayTime: Double) {
        self.imageArray = imageArray
        self.delayTime = delayTime
        self.timer = Timer.publish(every: delayTime, on: .main, in: .common).autoconnect()
    }
    
    var body: some View {
        Image(imageArray[currentIndex])
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(minWidth: 0, maxWidth: .infinity)
            .ignoresSafeArea(.all)
            .onReceive(timer) { _ in
                self.currentIndex = (self.currentIndex + 1) % self.imageArray.count
            }
    }
}
