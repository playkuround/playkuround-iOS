//
//  Major.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/16/24.
//

import Foundation
import SwiftUI

/// 단과대 struct
struct College: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let majors: [Major]
}

/// 학과/부 struct
struct Major: Identifiable, Hashable {
    let id = UUID()
    let name: String
}

/// 단과대학별 학과/부 리스트
let majorList: [College] = [
    College(name: "문과대학", majors: [
        Major(name: "국어국문학과"),
        Major(name: "영어영문학과"),
        Major(name: "중어중문학과"),
        Major(name: "철학과"),
        Major(name: "사학과"),
        Major(name: "지리학과"),
        Major(name: "미디어커뮤니케이션학과"),
        Major(name: "문화콘텐츠학과")
    ]),
    College(name: "이과대학", majors: [
        Major(name: "수학과"),
        Major(name: "물리학과"),
        Major(name: "화학과")
    ]),
    College(name: "건축대학", majors: [
        Major(name: "건축학부")
    ]),
    College(name: "공과대학", majors: [
        Major(name: "사회환경공학부"),
        Major(name: "기계항공공학부"),
        Major(name: "전기전자공학부"),
        Major(name: "화학공학부"),
        Major(name: "컴퓨터공학부"),
        Major(name: "산업경영공학부 산업공학과"),
        Major(name: "산업경영공학부 신산업융합학과"),
        Major(name: "생물공학과"),
        Major(name: "K뷰티산업융합학과")
    ]),
    College(name: "사회과학대학", majors: [
        Major(name: "정치외교학과"),
        Major(name: "경제학과"),
        Major(name: "행정학과"),
        Major(name: "국제무역학과"),
        Major(name: "응용통계학과"),
        Major(name: "융합인재학과"),
        Major(name: "글로벌비즈니스학과")
    ]),
    College(name: "경영대학", majors: [
        Major(name: "경영학과"),
        Major(name: "기술경영학과")
    ]),
    College(name: "부동산과학원", majors: [
        Major(name: "부동산학과")
    ]),
    College(name: "KU융합과학기술원", majors: [
        Major(name: "미래에너지공학과"),
        Major(name: "스마트운행체공학과"),
        Major(name: "스마트ICT융합공학과"),
        Major(name: "화장품공학과"),
        Major(name: "줄기세포재생공학과"),
        Major(name: "의생명공학과"),
        Major(name: "시스템생명공학과"),
        Major(name: "융합생명공학과")
    ]),
    College(name: "상허생명과학대학", majors: [
        Major(name: "생명과학특성학과"),
        Major(name: "동물자원과학과"),
        Major(name: "식량자원과학과"),
        Major(name: "축산식품생명공학과"),
        Major(name: "식품유통공학과"),
        Major(name: "환경보건과학과"),
        Major(name: "산림조경학과")
    ]),
    College(name: "수의과대학", majors: [
        Major(name: "수의예과"),
        Major(name: "수의학과")
    ]),
    College(name: "예술디자인대학", majors: [
        Major(name: "커뮤니케이션디자인학과"),
        Major(name: "산업디자인학과"),
        Major(name: "의상디자인학과"),
        Major(name: "리빙디자인학과"),
        Major(name: "현대미술학과"),
        Major(name: "영상영화학과")
    ]),
    College(name: "사범대학", majors: [
        Major(name: "일어교육과"),
        Major(name: "수학교육과"),
        Major(name: "체육교육과"),
        Major(name: "음악교육과"),
        Major(name: "교육공학과"),
        Major(name: "영어교육과"),
        Major(name: "교직과")
    ]),
    College(name: "상허교양대학", majors: [
        Major(name: "국제학부")
    ]),
    College(name: "국제대학", majors: [
        Major(name: "국제통상학과"),
        Major(name: "문화미디어학과")
    ])
]

/// Major 테스트용 뷰
struct MajorTestView: View {
    var body: some View {
        // Menu로 단과대학 구분
        Menu {
            ForEach(majorList) { college in
                Menu(college.name) {
                    ForEach(college.majors) { major in
                        Text(major.name)
                    }
                }
            }
        } label: {
            Text("단과대학 및 학과 (Menu)")
                .font(.headline)
        }
        
        Spacer()
            .frame(height: 30)
        
        // Section으로 단과대학 구분
        Menu {
            ForEach(majorList) { college in
                Section(college.name) {
                    ForEach(college.majors) { major in
                        Text(major.name)
                    }
                }
            }
        } label: {
            Text("단과대학 및 학과 (Section)")
                .font(.headline)
        }
    }
}

#Preview {
    MajorTestView()
}
