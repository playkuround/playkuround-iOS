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
    let name: String
    let id: Int
}

/// 단과대학별 학과/부 리스트
let majorListKorean: [College] = [
    College(name: "문과대학", majors: [
        Major(name: "국어국문학과", id: 0),
        Major(name: "영어영문학과", id: 1),
        Major(name: "중어중문학과", id: 2),
        Major(name: "철학과", id: 3),
        Major(name: "사학과", id: 4),
        Major(name: "지리학과", id: 5),
        Major(name: "미디어커뮤니케이션학과", id: 6),
        Major(name: "문화콘텐츠학과", id: 7)
    ]),
    College(name: "이과대학", majors: [
        Major(name: "수학과", id: 10),
        Major(name: "물리학과", id: 11),
        Major(name: "화학과", id: 12)
    ]),
    College(name: "건축대학", majors: [
        Major(name: "건축학부", id: 13)
    ]),
    College(name: "공과대학", majors: [
        Major(name: "사회환경공학부", id: 20),
        Major(name: "기계항공공학부", id: 21),
        Major(name: "전기전자공학부", id: 22),
        Major(name: "화학공학부", id: 23),
        Major(name: "컴퓨터공학부", id: 24),
        Major(name: "산업경영공학부 산업공학과", id: 25),
        Major(name: "산업경영공학부 신산업융합학과", id: 26),
        Major(name: "생물공학과", id: 27),
        Major(name: "K뷰티산업융합학과", id: 28)
    ]),
    College(name: "사회과학대학", majors: [
        Major(name: "정치외교학과", id: 30),
        Major(name: "경제학과", id: 31),
        Major(name: "행정학과", id: 32),
        Major(name: "국제무역학과", id: 33),
        Major(name: "응용통계학과", id: 34),
        Major(name: "융합인재학과", id: 35),
        Major(name: "글로벌비즈니스학과", id: 36)
    ]),
    College(name: "경영대학", majors: [
        Major(name: "경영학과", id: 40),
        Major(name: "기술경영학과", id: 41)
    ]),
    College(name: "부동산과학원", majors: [
        Major(name: "부동산학과", id: 50)
    ]),
    College(name: "KU융합과학기술원", majors: [
        Major(name: "미래에너지공학과", id: 60),
        Major(name: "스마트운행체공학과", id: 61),
        Major(name: "스마트ICT융합공학과", id: 62),
        Major(name: "화장품공학과", id: 63),
        Major(name: "줄기세포재생공학과", id: 64),
        Major(name: "의생명공학과", id: 65),
        Major(name: "시스템생명공학과", id: 66),
        Major(name: "융합생명공학과", id: 67)
    ]),
    College(name: "상허생명과학대학", majors: [
        Major(name: "생명과학특성학과", id: 70),
        Major(name: "동물자원과학과", id: 71),
        Major(name: "식량자원과학과", id: 72),
        Major(name: "축산식품생명공학과", id: 73),
        Major(name: "식품유통공학과", id: 74),
        Major(name: "환경보건과학과", id: 75),
        Major(name: "산림조경학과", id: 76)
    ]),
    College(name: "수의과대학", majors: [
        Major(name: "수의예과", id: 80),
        Major(name: "수의학과", id: 81)
    ]),
    College(name: "예술디자인대학", majors: [
        Major(name: "커뮤니케이션디자인학과", id: 82),
        Major(name: "산업디자인학과", id: 83),
        Major(name: "의상디자인학과", id: 84),
        Major(name: "리빙디자인학과", id: 85),
        Major(name: "현대미술학과", id: 86),
        Major(name: "영상영화학과", id: 87)
    ]),
    College(name: "사범대학", majors: [
        Major(name: "일어교육과", id: 90),
        Major(name: "수학교육과", id: 91),
        Major(name: "체육교육과", id: 92),
        Major(name: "음악교육과", id: 93),
        Major(name: "교육공학과", id: 94),
        Major(name: "영어교육과", id: 95),
        Major(name: "교직과", id: 96)
    ]),
    College(name: "상허교양대학", majors: [
        Major(name: "국제학부", id: 100)
    ]),
    College(name: "국제대학", majors: [
        Major(name: "국제통상학과", id: 101),
        Major(name: "문화미디어학과", id: 102)
    ])
]

// 영어
let majorListEnglish: [College] = [
    College(name: "College of Liberal arts", majors: [
        Major(name: "Department of Korean Language and Literature", id: 0),
        Major(name: "Department of English Language and Literature", id: 1),
        Major(name: "Department of Chinese Language and Literature", id: 2),
        Major(name: "Philosophy", id: 3),
        Major(name: "History", id: 4),
        Major(name: "Geography", id: 5),
        Major(name: "Department of Media and Communication", id: 6),
        Major(name: "Department of Cultural Contents", id: 7)
    ]),
    College(name: "College of Science", majors: [
        Major(name: "Math Department", id: 10),
        Major(name: "Physics", id: 11),
        Major(name: "Chemistry", id: 12)
    ]),
    College(name: "College of Architecture", majors: [
        Major(name: "School of Architecture", id: 13)
    ]),
    College(name: "College of Engineering", majors: [
        Major(name: "School of Social and Environmental Engineering", id: 20),
        Major(name: "Mechanical and Aerospace Engineering", id: 21),
        Major(name: "Electrical and Electronics Engineering", id: 22),
        Major(name: "Chemical Engineering", id: 23),
        Major(name: "School of Computer Science", id: 24),
        Major(name: "Department of Industrial Engineering, College of Industrial and Management Engineering", id: 25),
        Major(name: "Department of New Industrial Convergence, College of Industrial Management Engineering", id: 26),
        Major(name: "Department of Biological Engineering", id: 27),
        Major(name: "Department of K-beauty Industry Convergence", id: 28)
    ]),
    College(name: "College of Social Sciences", majors: [
        Major(name: "Department of Political Science and Diplomacy", id: 30),
        Major(name: "Department of Economics", id: 31),
        Major(name: "Department of Public Administration", id: 32),
        Major(name: "Department of International Trade", id: 33),
        Major(name: "Department of Applied Statistics", id: 34),
        Major(name: "Department of Interdisciplinary Studies", id: 35),
        Major(name: "Department of Global Business", id: 36)
    ]),
    College(name: "College of Business", majors: [
        Major(name: "School of Business", id: 40),
        Major(name: "Management of Technology", id: 41)
    ]),
    College(name: "Real Estate Science Institute", majors: [
        Major(name: "Department of Real Estate", id: 50)
    ]),
    College(name: "KU Institute of Convergence Science and Technology", majors: [
        Major(name: "Future Energy Engineering", id: 60),
        Major(name: "Smart Vehicle Engineering", id: 61),
        Major(name: "Smart ICT Convergence Engineering", id: 62),
        Major(name: "Cosmetology", id: 63),
        Major(name: "Department of Stem Cell Regeneration", id: 64),
        Major(name: "Department of Biomedical Engineering", id: 65),
        Major(name: "Department of Systems Biology", id: 66),
        Major(name: "Department of Convergence Biotechnology", id: 67)
    ]),
    College(name: "College of Life Sciences", majors: [
        Major(name: "Department of Life Science Characteristics", id: 70),
        Major(name: "Department of Animal Resources Science", id: 71),
        Major(name: "Department of Food and Resource Sciences", id: 72),
        Major(name: "Department of Animal and Food Biotechnology", id: 73),
        Major(name: "Department of Food Distribution Engineering", id: 74),
        Major(name: "Department of Environmental Health Sciences", id: 75),
        Major(name: "Department of Forestry and Landscape Architecture", id: 76)
    ]),
    College(name: "College of Veterinary Medicine", majors: [
        Major(name: "Pre-Veterinary Medicine", id: 80),
        Major(name: "Veterinary Medicine", id: 81)
    ]),
    College(name: "College of Art and Design", majors: [
        Major(name: "Communication Design Department", id: 82),
        Major(name: "Industrial Design", id: 83),
        Major(name: "Department of Costume Design", id: 84),
        Major(name: "Department of Living Design", id: 85),
        Major(name: "Department of Contemporary Art", id: 86),
        Major(name: "Department of Video and Film Studies", id: 87)
    ]),
    College(name: "College of Education", majors: [
        Major(name: "Japanese Education Department", id: 90),
        Major(name: "Mathematics Education Department", id: 91),
        Major(name: "Physical Education", id: 92),
        Major(name: "Music Education", id: 93),
        Major(name: "Department of Education", id: 94),
        Major(name: "Department of English Education", id: 95),
        Major(name: "Department of Teaching", id: 96)
    ]),
    College(name: "SANG-HUH COLLEGE", majors: [
        Major(name: "International Studies", id: 100)
    ]),
    College(name: "International Commerce/Cultural Media Studies", majors: [
        Major(name: "International Commerce", id: 101),
        Major(name: "Culture and Media Studies", id: 102)
    ])
]

// 중국어
let majorListChinese: [College] = [
    College(name: "文科学院", majors: [
        Major(name: "韩国语国文学系", id: 0),
        Major(name: "英语英文学科", id: 1),
        Major(name: "中文系", id: 2),
        Major(name: "哲学系", id: 3),
        Major(name: "史学系", id: 4),
        Major(name: "地理学科", id: 5),
        Major(name: "传媒学系", id: 6),
        Major(name: "文化信息专业", id: 7)
    ]),
    College(name: "理学院", majors: [
        Major(name: "数学系", id: 10),
        Major(name: "物理学系", id: 11),
        Major(name: "化学系", id: 12)
    ]),
    College(name: "建筑学院", majors: [
        Major(name: "建筑学部", id: 13)
    ]),
    College(name: "工学院", majors: [
        Major(name: "社会环境工程学部", id: 20),
        Major(name: "机械航空工程学部", id: 21),
        Major(name: "电气电子工程学部", id: 22),
        Major(name: "化学工程学部", id: 23),
        Major(name: "计算机工程学部", id: 24),
        Major(name: "工业管理工程学部 工业工程系", id: 25),
        Major(name: "工业管理工程学部 新产业融合学系", id: 26),
        Major(name: "生物工程系", id: 27),
        Major(name: "K美容产业融合学系", id: 28)
    ]),
    College(name: "社会科学学院", majors: [
        Major(name: "政治外交学系", id: 30),
        Major(name: "经济学系", id: 31),
        Major(name: "行政学系", id: 32),
        Major(name: "国际贸易学系", id: 33),
        Major(name: "应用统计学系", id: 34),
        Major(name: "融合人才学系", id: 35),
        Major(name: "全球商业学系", id: 36)
    ]),
    College(name: "管理学院", majors: [
        Major(name: "管理学系", id: 40),
        Major(name: "技术管理学系", id: 41)
    ]),
    College(name: "房地产科学研究院", majors: [
        Major(name: "房地产学系", id: 50)
    ]),
    College(name: "KU融合科学技术院", majors: [
        Major(name: "未来能源工程学系", id: 60),
        Major(name: "智能运行体工程学系", id: 61),
        Major(name: "智能ICT融合工程学系", id: 62),
        Major(name: "化妆品工程学系", id: 63),
        Major(name: "干细胞再生工程学系", id: 64),
        Major(name: "医学生物工程学系", id: 65),
        Major(name: "系统生物工程学系", id: 66),
        Major(name: "融合生物工程学系", id: 67)
    ]),
    College(name: "商虞生命科学学院", majors: [
        Major(name: "生命科学特性学系", id: 70),
        Major(name: "动物资源科学系", id: 71),
        Major(name: "粮食资源科学系", id: 72),
        Major(name: "畜产食品生命工程学系", id: 73),
        Major(name: "食品流通工程学系", id: 74),
        Major(name: "环境卫生科学系", id: 75),
        Major(name: "林业景观学系", id: 76)
    ]),
    College(name: "兽医学学院", majors: [
        Major(name: "兽医预科", id: 80),
        Major(name: "兽医学系", id: 81)
    ]),
    College(name: "艺术设计学院", majors: [
        Major(name: "传播设计学系", id: 82),
        Major(name: "工业设计学系", id: 83),
        Major(name: "服装设计学系", id: 84),
        Major(name: "生活设计学系", id: 85),
        Major(name: "现代美术学系", id: 86),
        Major(name: "影视电影学系", id: 87)
    ]),
    College(name: "师范学院", majors: [
        Major(name: "日语教育学系", id: 90),
        Major(name: "数学教育学系", id: 91),
        Major(name: "体育教育学系", id: 92),
        Major(name: "音乐教育学系", id: 93),
        Major(name: "教育技术学系", id: 94),
        Major(name: "英语教育学系", id: 95),
        Major(name: "教师教育学系", id: 96)
    ]),
    College(name: "商虞通识学院", majors: [
        Major(name: "国际学部", id: 100)
    ]),
    College(name: "国际通商/文化媒体学", majors: [
        Major(name: "国际通商学系", id: 101),
        Major(name: "文化媒体学系", id: 102)
    ])
]

/// Major 테스트용 뷰
struct MajorTestView: View {
    var body: some View {
        // Menu로 단과대학 구분
        Menu {
            ForEach(majorListKorean) { college in
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
            ForEach(majorListKorean) { college in
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
