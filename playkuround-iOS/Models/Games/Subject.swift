//
//  Subject.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 5/30/24.
//

import Foundation

struct Subject {
    let type: SubjectType
    let title: String
    var xOffset: CGFloat = 0
    var yOffset: CGFloat = 0
}

enum SubjectType {
    case basic // 기본교양
    case advanced // 심화교양
    case department // 학과교양
}

/// 수강신청 ALL 클릭 과목 리스트
let subjectList: [Subject] = [
    // 기초교양-10개
    Subject(type: .basic, title: "대학영어"),
    Subject(type: .basic, title: "대학일본어"),
    Subject(type: .basic, title: "비판적사고와토론"),
    Subject(type: .basic, title: "창조적사고와표현"),
    Subject(type: .basic, title: "인문사회글쓰기"),
    Subject(type: .basic, title: "사회봉사"),
    Subject(type: .basic, title: "컴퓨팅적사고"),
    Subject(type: .basic, title: "실전취업특강"),
    Subject(type: .basic, title: "외국인글쓰기"),
    Subject(type: .basic, title: "벤처창업및경영"),
    
    // 심화교양-29개
    Subject(type: .advanced, title: "논리와사고"),
    Subject(type: .advanced, title: "야외스포츠"),
    Subject(type: .advanced, title: "생활건강"),
    Subject(type: .advanced, title: "과학사"),
    Subject(type: .advanced, title: "요가와명상"),
    Subject(type: .advanced, title: "하모니인건국"),
    Subject(type: .advanced, title: "교육과인간"),
    Subject(type: .advanced, title: "영화영어"),
    Subject(type: .advanced, title: "말과승마"),
    Subject(type: .advanced, title: "철학산책"),
    Subject(type: .advanced, title: "명저읽기"),
    Subject(type: .advanced, title: "신화와영화"),
    Subject(type: .advanced, title: "언어와마음"),
    Subject(type: .advanced, title: "기초글쓰기"),
    Subject(type: .advanced, title: "재무와회계"),
    Subject(type: .advanced, title: "인구의정치학"),
    Subject(type: .advanced, title: "과학의원리"),
    Subject(type: .advanced, title: "지리와이슈"),
    Subject(type: .advanced, title: "삶과소통"),
    Subject(type: .advanced, title: "미디어영어"),
    Subject(type: .advanced, title: "소비와행복"),
    Subject(type: .advanced, title: "윤리와삶"),
    Subject(type: .advanced, title: "상실과회복"),
    Subject(type: .advanced, title: "경제학입문"),
    Subject(type: .advanced, title: "서양문명사"),
    Subject(type: .advanced, title: "동양의지혜"),
    Subject(type: .advanced, title: "선거와여론"),
    Subject(type: .advanced, title: "성과문학"),
    Subject(type: .advanced, title: "정치학입문"),
    
    // 학과교양-61개
    Subject(type: .department, title: "문예창작"),
    Subject(type: .department, title: "영어사"),
    Subject(type: .department, title: "사서강독"),
    Subject(type: .department, title: "논리학"),
    Subject(type: .department, title: "한국고대사"),
    Subject(type: .department, title: "지형학"),
    Subject(type: .department, title: "미디어심리학"),
    Subject(type: .department, title: "상징과이미지"),
    Subject(type: .department, title: "환및가군"),
    Subject(type: .department, title: "현대광학"),
    Subject(type: .department, title: "생화학"),
    Subject(type: .department, title: "건축설비"),
    Subject(type: .department, title: "구조역학"),
    Subject(type: .department, title: "로봇공학"),
    Subject(type: .department, title: "전자회로"),
    Subject(type: .department, title: "표면화학"),
    Subject(type: .department, title: "컴파일러"),
    Subject(type: .department, title: "금융공학"),
    Subject(type: .department, title: "품질경영"),
    Subject(type: .department, title: "면역학"),
    Subject(type: .department, title: "화장품학"),
    Subject(type: .department, title: "정당론"),
    Subject(type: .department, title: "중급거시"),
    Subject(type: .department, title: "정책학개론"),
    Subject(type: .department, title: "국제재무"),
    Subject(type: .department, title: "데이터마이닝"),
    Subject(type: .department, title: "공기업경영론"),
    Subject(type: .department, title: "중국문화론"),
    Subject(type: .department, title: "원가회계"),
    Subject(type: .department, title: "혁신경영"),
    Subject(type: .department, title: "부동산실습"),
    Subject(type: .department, title: "고체물리"),
    Subject(type: .department, title: "전산모델링"),
    Subject(type: .department, title: "인공신경망"),
    Subject(type: .department, title: "화장품화학"),
    Subject(type: .department, title: "조직학"),
    Subject(type: .department, title: "약리학"),
    Subject(type: .department, title: "효소공학"),
    Subject(type: .department, title: "의약화학"),
    Subject(type: .department, title: "유전체학"),
    Subject(type: .department, title: "가축면역학"),
    Subject(type: .department, title: "농업경제학"),
    Subject(type: .department, title: "우유과학"),
    Subject(type: .department, title: "식품학개론"),
    Subject(type: .department, title: "육수학"),
    Subject(type: .department, title: "조경구조학"),
    Subject(type: .department, title: "임상로테이션"),
    Subject(type: .department, title: "광고디자인"),
    Subject(type: .department, title: "디자인기획"),
    Subject(type: .department, title: "테일러링"),
    Subject(type: .department, title: "아트타일"),
    Subject(type: .department, title: "입체일반"),
    Subject(type: .department, title: "즉흥연기"),
    Subject(type: .department, title: "초급일본어"),
    Subject(type: .department, title: "위상수학"),
    Subject(type: .department, title: "육상경기"),
    Subject(type: .department, title: "합창합주"),
    Subject(type: .department, title: "교수설계"),
    Subject(type: .department, title: "영어작문"),
    Subject(type: .department, title: "미디어통역"),
    Subject(type: .department, title: "국제통상정책")
]
