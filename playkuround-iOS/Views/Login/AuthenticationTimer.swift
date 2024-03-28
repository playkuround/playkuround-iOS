//
//  AuthenticationTimer.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/18/24.
//

import SwiftUI

struct AuthenticationTimer: View {
    @State var timeRemained : Int = 300
    @Binding var isTimerFinished: Bool
    @Binding var authButtonClicked: Bool
    
    private let date = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text(convertSecondsToTime(timeInSeconds: timeRemained))
            .font(.pretendard15R)
            .foregroundStyle(.kuGray2)
            .onReceive(timer) { _ in
                if timeRemained > 0 {
                    timeRemained -= 1
                }
                else {
                    timer.upstream.connect().cancel()
                    withAnimation(.spring) {
                        isTimerFinished = true
                    }
                }
            }
            .onAppear {
                calculateTimeRemaining()
            }
            .onChange(of: authButtonClicked) { _ in
                timeRemained = 300
            }
    }
    
    private func calculateTimeRemaining() {
        let calendar = Calendar.current
        let targetTime : Date = calendar.date(byAdding: .second, value: 300, to: date, wrappingComponents: false) ?? Date()
        let remainSeconds = Int(targetTime.timeIntervalSince(date))
        self.timeRemained = remainSeconds
    }
}

private func convertSecondsToTime(timeInSeconds: Int) -> String {
    let minutes = timeInSeconds / 60
    let seconds = timeInSeconds % 60
    return String(format: "%02i:%02i", minutes,seconds)
}
