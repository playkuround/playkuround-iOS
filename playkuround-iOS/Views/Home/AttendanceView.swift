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
    @State private var dates: [Date] = []
    
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
                                            // TODO: 출석 하기 전 빈 박스, 출석 후 박스
                                            Image(.calendarTodayBox)
                                                .resizable()
                                                .frame(width: 34, height: 34)
                                            Text(date.toCalendarString())
                                                .font(.pretendard17R)
                                                .foregroundColor(.kuText)
                                                .kerning(-0.41)
                                        }
                                        .frame(width: 34, height: 34)
                                    } else {
                                        // 과거
                                        ZStack {
                                            // TODO: if 출석 했다면 박스 흰색글씨, 안했다면 박스X 회색글씨
                                            Text(date.toCalendarString())
                                                .font(.pretendard17R)
                                                .foregroundColor(.kuGray2)
                                                .kerning(-0.41)
                                        }
                                        .frame(width: 34, height: 34)
                                    }
                                }
                            }
                            .padding(.bottom, 32)
                            
                            Button {
                                // TODO: 출석 처리
                            } label: {
                                // TODO: 출석 완료 시 회색 버튼
                                Image(.shortButtonBlue)
                                    .overlay {
                                        Text(StringLiterals.Home.Attendance.attendance)
                                            .font(.neo18)
                                            .kerning(-0.41)
                                            .foregroundStyle(.kuText)
                                    }
                            }
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
                    rootViewModel.transition(to: .home)
                } label: {
                    Image(.leftWhiteArrow)
                }
            }, height: 67)
        }
        .onAppear {
            dates = generateDates()
            // TODO: 출석 확인 API 호출하여 날짜별 출석 여부 표시
        }
    }
    
    // TODO: ViewModel 만들면 VM내로 옮기기
    func generateDates() -> [Date] {
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
}

#Preview {
    AttendanceView(rootViewModel: RootViewModel())
}
