//
//  AuthenticationTimerView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/18/24.
//

import SwiftUI

struct AuthenticationTimerView: View {
    @State var timeRemaining : Int = 300
    private let date = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text(convertSecondsToTime(timeInSeconds:timeRemaining))
            .font(.pretendard15R)
            .foregroundStyle(.kuGray2)
            .onReceive(timer) { _ in
                timeRemaining -= 1
            }
            .onAppear {
                calculateTimeRemaining()
            }
    }
    
    private func calculateTimeRemaining() {
        let calendar = Calendar.current
        let targetTime : Date = calendar.date(byAdding: .second, value: 300, to: date, wrappingComponents: false) ?? Date()
        let remainSeconds = Int(targetTime.timeIntervalSince(date))
        self.timeRemaining = remainSeconds
    }
}

private func convertSecondsToTime(timeInSeconds: Int) -> String {
    let minutes = timeInSeconds / 60
    let seconds = timeInSeconds % 60
    return String(format: "%02i:%02i", minutes,seconds)
}

#Preview {
    AuthenticationTimerView()
}
