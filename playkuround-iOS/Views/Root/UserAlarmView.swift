//
//  UserAlarmView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 8/29/24.
//

import SwiftUI

struct UserAlarmView: View {
    @ObservedObject var rootViewModel: RootViewModel
    let alarmText: String
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    rootViewModel.closeAlarmMessageView()
                }
            Image(.toastAlert)
                .overlay {
                    VStack {
                        Text("Home.Alarm.Title")
                            .font(.neo22)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                            .padding(.top, 45)
                        
                        VStack(alignment: .center, spacing: 0) {
                            Spacer()
                            Text(alarmText)
                                .font(.pretendard15R)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.kuText)
                            Spacer()
                        }
                        .frame(width: 238, height: 100, alignment: .center)
                        
                        Spacer()
                    }
                }
        }
    }
}

#Preview {
    UserAlarmView(rootViewModel: RootViewModel(), alarmText: "1등입니다\n2등입니다\n3등입니다")
}
