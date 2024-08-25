//
//  AttendanceView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/29/24.
//

import Foundation
import SwiftUI

struct AttendanceView: View {
    @ObservedObject var rootViewModel: RootViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var mapViewModel: MapViewModel
    @State private var dates: [Date] = []
    
    private let soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            Image(.homeBackground)
                .resizable()
                .ignoresSafeArea(.all)
            
            Color.black.opacity(0.2).ignoresSafeArea()
            
            VStack {
                Spacer()
                Image(.attendanceBackground)
                    .padding()
                    .overlay {
                        VStack {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 1), count: 7), spacing: 14) {
                                ForEach(dates, id: \.self) { date in
                                    if date.isToday() {
                                        // 오늘
                                        ZStack {
                                            if checkAttended(date) {
                                                Image(.calendarBox)
                                                    .resizable()
                                                    .frame(width: 34, height: 34)
                                                Text(date.toCalendarString())
                                                    .font(.pretendard17R)
                                                    .foregroundColor(.kuText)
                                                    .fontWeight(.medium)
                                                    .kerning(-0.41)
                                            } else {
                                                Image(.calendarTodayBox)
                                                    .resizable()
                                                    .frame(width: 34, height: 34)
                                                Text(date.toCalendarString())
                                                    .font(.pretendard17R)
                                                    .foregroundColor(.kuText)
                                                    .fontWeight(.medium)
                                                    .kerning(-0.41)
                                            }
                                        }
                                        .frame(width: 34, height: 34)
                                    } else {
                                        // 과거
                                        ZStack {
                                            if checkAttended(date) {
                                                Image(.calendarBox)
                                                    .resizable()
                                                    .frame(width: 34, height: 34)
                                                Text(date.toCalendarString())
                                                    .font(.pretendard17R)
                                                    .foregroundColor(.white)
                                                    .fontWeight(.medium)
                                                    .kerning(-0.41)
                                            } else {
                                                Text(date.toCalendarString())
                                                    .font(.pretendard17R)
                                                    .foregroundColor(.kuGray2)
                                                    .fontWeight(.medium)
                                                    .kerning(-0.41)
                                            }
                                        }
                                        .frame(width: 34, height: 34)
                                    }
                                }
                            }
                            .padding(.bottom, 32)
                            
                            let isTodayAttended = checkAttended(Date())
                            
                            Button {
                                homeViewModel.attendance(latitude: mapViewModel.userLatitude, longitude: mapViewModel.userLongitude)
                                soundManager.playSound(sound: .buttonClicked)
                            } label: {
                                Image(isTodayAttended ? .shortButtonGray : .shortButtonBlue)
                                    .overlay {
                                        Text(isTodayAttended ? StringLiterals.Home.Attendance.attenanceDone : StringLiterals.Home.Attendance.attendance)
                                            .font(.neo18)
                                            .kerning(-0.41)
                                            .foregroundStyle(.kuText)
                                    }
                            }
                            .disabled(isTodayAttended)
                        }
                        .offset(y: 24)
                        .padding(50)
                    }
                
                Spacer()
            }
            .padding(.bottom, 67)
            .customNavigationBar(centerView: {
                Text(StringLiterals.Home.Attendance.attendanceTitle)
                    .font(.neo22)
                    .kerning(-0.41)
                    .foregroundStyle(.white)
            }, leftView: {
                Button {
                    homeViewModel.transition(to: .home)
                    soundManager.playSound(sound: .buttonClicked)
                } label: {
                    Image(.leftWhiteArrow)
                }
            }, height: 67)
        }
        .onAppear {
            dates = generateDates()
            GAManager.shared.logScreenEvent(.AttendanceView)
        }
    }
    
    private func generateDates() -> [Date] {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        
        let today = Date()
        let startOfToday = calendar.startOfDay(for: today)
        
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: startOfToday))!
        guard let fiveWeeksAgo = calendar.date(byAdding: .weekOfYear, value: -4, to: startOfWeek) else { return [] }
        
        var dates = [Date]()
        var currentDate = fiveWeeksAgo
        while currentDate <= startOfToday {
            dates.append(currentDate)
            guard let newDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else { break }
            currentDate = newDate
        }
        
        return dates
    }
    
    private func checkAttended(_ date: Date) -> Bool {
        guard let dateString = date.toFormattedString("yyyy-MM-dd") else { return false }
        
        if homeViewModel.attendanceList.contains(dateString) {
            return true
        } else {
            return false
        }
    }
}

#Preview {
    AttendanceView(rootViewModel: RootViewModel(), homeViewModel: HomeViewModel(rootViewModel: RootViewModel()), mapViewModel: MapViewModel(rootViewModel: RootViewModel()))
}
