//
//  Landmark.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/30/24.
//

import Foundation

struct Landmark: Identifiable, Codable, Equatable {
    var id = UUID()
    let number: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let radius: Double
}

struct LandmarkInformation: Codable {
    let title: String
    let content: String
}

struct LandmarkDescription: Identifiable, Codable {
    let id: Int
    let description: String
    let information: [LandmarkInformation]
    let amenity: [String]
}

let landmarkList: [Landmark] = [
    // 서버 API 반환값 및 랜드마크 인덱스는 1부터 시작하므로 0번째는 더미 노드 추가
    Landmark(number: 0, name: "Error: Index Out of Range", latitude: 0, longitude: 0, radius: 0),
    Landmark(number: 1, name: "산학협동관", latitude: 37.539765, longitude: 127.073215, radius: 40),
    Landmark(number: 2, name: "입학정보관", latitude: 37.540296, longitude: 127.07341, radius: 20),
    Landmark(number: 3, name: "수의학관", latitude: 37.53931, longitude: 127.07459, radius: 35),
    Landmark(number: 4, name: "동물생명과학관", latitude: 37.540184, longitude: 127.074179, radius: 30),
    Landmark(number: 5, name: "생명과학관", latitude: 37.540901, longitude: 127.074055, radius: 40),
    Landmark(number: 6, name: "상허도서관", latitude: 37.542051, longitude: 127.073808, radius: 55),
    Landmark(number: 7, name: "의생명과학연구관", latitude: 37.541461, longitude: 127.072215, radius: 36),
    Landmark(number: 8, name: "예디대", latitude: 37.542908, longitude: 127.072815, radius: 50),
    Landmark(number: 9, name: "언어교육원", latitude: 37.542533, longitude: 127.0747, radius: 35),
    Landmark(number: 10, name: "법학관", latitude: 37.541667, longitude: 127.075046, radius: 50),
    Landmark(number: 11, name: "상허박물관", latitude: 37.542375, longitude: 127.075711, radius: 30),
    Landmark(number: 12, name: "행정관", latitude: 37.543222, longitude: 127.075305, radius: 44),
    Landmark(number: 13, name: "교육과학관", latitude: 37.543998, longitude: 127.074145, radius: 50),
    Landmark(number: 14, name: "상허연구관", latitude: 37.544018, longitude: 127.075141, radius: 35),
    Landmark(number: 15, name: "경영관", latitude: 37.544319, longitude: 127.076184, radius: 40),
    Landmark(number: 16, name: "새천년관", latitude: 37.543374, longitude: 127.077314, radius: 40),
    Landmark(number: 17, name: "건축관", latitude: 37.543732, longitude: 127.078482, radius: 25),
    Landmark(number: 18, name: "부동산학관", latitude: 37.543283, longitude: 127.078093, radius: 25),
    Landmark(number: 19, name: "인문학관", latitude: 37.542602, longitude: 127.07825, radius: 40),
    Landmark(number: 20, name: "학생회관", latitude: 37.541954, longitude: 127.077748, radius: 30),
    Landmark(number: 21, name: "제2학생회관", latitude: 37.541298, longitude: 127.077828, radius: 35),
    Landmark(number: 22, name: "공학관A", latitude: 37.541655, longitude: 127.078769, radius: 33),
    Landmark(number: 23, name: "공학관B", latitude: 37.542004, longitude: 127.079563, radius: 33),
    Landmark(number: 24, name: "공학관C", latitude: 37.541226, longitude: 127.079357, radius: 28),
    Landmark(number: 25, name: "신공학관", latitude: 37.540455, longitude: 127.079304, radius: 40),
    Landmark(number: 26, name: "과학관", latitude: 37.541491, longitude: 127.080565, radius: 43),
    Landmark(number: 27, name: "창의관", latitude: 37.541114, longitude: 127.081743, radius: 45),
    Landmark(number: 28, name: "공예관", latitude: 37.54222, longitude: 127.080961, radius: 33),
    Landmark(number: 29, name: "KU기술혁신관", latitude: 37.539995, longitude: 127.07718, radius: 40),
    Landmark(number: 30, name: "기숙사", latitude: 37.539147, longitude: 127.078248, radius: 75),
    Landmark(number: 31, name: "일감호", latitude: 37.540796, longitude: 127.076495, radius: 50),
    Landmark(number: 32, name: "홍예교", latitude: 37.541688, longitude: 127.077344, radius: 18),
    Landmark(number: 33, name: "황소동상", latitude: 37.543135, longitude: 127.076172, radius: 20),
    Landmark(number: 34, name: "청심대", latitude: 37.542366, longitude: 127.076835, radius: 30),
    Landmark(number: 35, name: "상허박사동상", latitude: 37.5413665, longitude: 127.0734648, radius: 25),
    Landmark(number: 36, name: "노천극장중앙", latitude: 37.541475, longitude: 127.077802, radius: 0),
    Landmark(number: 37, name: "대운동장", latitude: 37.544387, longitude: 127.077593, radius: 65),
    Landmark(number: 38, name: "실내체육관", latitude: 37.544456, longitude: 127.079587, radius: 50),
    Landmark(number: 39, name: "건국문", latitude: 37.545122, longitude: 127.076613, radius: 20),
    Landmark(number: 40, name: "중문", latitude: 37.541827, longitude: 127.07178, radius: 15),
    Landmark(number: 41, name: "일감문", latitude: 37.539165, longitude: 127.074042, radius: 15),
    Landmark(number: 42, name: "상허문", latitude: 37.539692, longitude: 127.072491, radius: 25),
    Landmark(number: 43, name: "구의역쪽문", latitude: 37.541584, longitude: 127.082226, radius: 15),
    Landmark(number: 44, name: "기숙사쪽문", latitude: 37.539255, longitude: 127.076741, radius: 20)
]

let landmarkListEnglish: [Landmark] = [
    // 서버 API 반환값 및 랜드마크 인덱스는 1부터 시작하므로 0번째는 더미 노드 추가
    Landmark(number: 0, name: "Error: Index Out of Range", latitude: 0, longitude: 0, radius: 0),
    Landmark(number: 1, name: "Industry-Academic Cooperation Center", latitude: 37.539765, longitude: 127.073215, radius: 40),
    Landmark(number: 2, name: "Admissions Information Center", latitude: 37.540296, longitude: 127.07341, radius: 20),
    Landmark(number: 3, name: "Veterinary Medicine Building", latitude: 37.53931, longitude: 127.07459, radius: 35),
    Landmark(number: 4, name: "Animal Life Sciences Building", latitude: 37.540184, longitude: 127.074179, radius: 30),
    Landmark(number: 5, name: "Life Sciences Building", latitude: 37.540901, longitude: 127.074055, radius: 40),
    Landmark(number: 6, name: "SangHuh Library", latitude: 37.542051, longitude: 127.073808, radius: 55),
    Landmark(number: 7, name: "Biomedical Sciences Research Center", latitude: 37.541461, longitude: 127.072215, radius: 36),
    Landmark(number: 8, name: "College of Art & Design", latitude: 37.542908, longitude: 127.072815, radius: 50),
    Landmark(number: 9, name: "Language Institute", latitude: 37.542533, longitude: 127.0747, radius: 35),
    Landmark(number: 10, name: "Law School", latitude: 37.541667, longitude: 127.075046, radius: 50),
    Landmark(number: 11, name: "Museum", latitude: 37.542375, longitude: 127.075711, radius: 30),
    Landmark(number: 12, name: "Administration Building", latitude: 37.543222, longitude: 127.075305, radius: 44),
    Landmark(number: 13, name: "Education and Science Building", latitude: 37.543998, longitude: 127.074145, radius: 50),
    Landmark(number: 14, name: "SangHuh Research Center", latitude: 37.544018, longitude: 127.075141, radius: 35),
    Landmark(number: 15, name: "Management Building", latitude: 37.544319, longitude: 127.076184, radius: 40),
    Landmark(number: 16, name: "New Millennium Hall", latitude: 37.543374, longitude: 127.077314, radius: 40),
    Landmark(number: 17, name: "Architecture Hall", latitude: 37.543732, longitude: 127.078482, radius: 25),
    Landmark(number: 18, name: "Real Estate Building", latitude: 37.543283, longitude: 127.078093, radius: 25),
    Landmark(number: 19, name: "Humanities Building", latitude: 37.542602, longitude: 127.07825, radius: 40),
    Landmark(number: 20, name: "Student Center", latitude: 37.541954, longitude: 127.077748, radius: 30),
    Landmark(number: 21, name: "2nd Student Center", latitude: 37.541298, longitude: 127.077828, radius: 35),
    Landmark(number: 22, name: "Engineering Building A", latitude: 37.541655, longitude: 127.078769, radius: 33),
    Landmark(number: 23, name: "Engineering Building B", latitude: 37.542004, longitude: 127.079563, radius: 33),
    Landmark(number: 24, name: "Engineering Building C", latitude: 37.541226, longitude: 127.079357, radius: 28),
    Landmark(number: 25, name: "New Engineering Building", latitude: 37.540455, longitude: 127.079304, radius: 40),
    Landmark(number: 26, name: "Science Building", latitude: 37.541491, longitude: 127.080565, radius: 43),
    Landmark(number: 27, name: "Creative Building", latitude: 37.541114, longitude: 127.081743, radius: 45),
    Landmark(number: 28, name: "Craft Hall", latitude: 37.54222, longitude: 127.080961, radius: 33),
    Landmark(number: 29, name: "KU Technology Innovation Center", latitude: 37.539995, longitude: 127.07718, radius: 40),
    Landmark(number: 30, name: "Dormitory", latitude: 37.539147, longitude: 127.078248, radius: 75),
    Landmark(number: 31, name: "Lake", latitude: 37.540796, longitude: 127.076495, radius: 50),
    Landmark(number: 32, name: "Kondae Bridge", latitude: 37.541688, longitude: 127.077344, radius: 18),
    Landmark(number: 33, name: "Bull Statue", latitude: 37.543135, longitude: 127.076172, radius: 20),
    Landmark(number: 34, name: "Cheongsimdae", latitude: 37.542366, longitude: 127.076835, radius: 30),
    Landmark(number: 35, name: "Dr. SangHuh Statue", latitude: 37.5413665, longitude: 127.0734648, radius: 25),
    Landmark(number: 36, name: "Open Air Theater Central", latitude: 37.541475, longitude: 127.077802, radius: 0),
    Landmark(number: 37, name: "Large sports field", latitude: 37.544387, longitude: 127.077593, radius: 65),
    Landmark(number: 38, name: "Indoor gymnasium", latitude: 37.544456, longitude: 127.079587, radius: 50),
    Landmark(number: 39, name: "Konkuk-Gate", latitude: 37.545122, longitude: 127.076613, radius: 20),
    Landmark(number: 40, name: "Central-Gate", latitude: 37.541827, longitude: 127.07178, radius: 15),
    Landmark(number: 41, name: "Ilgam-Gate", latitude: 37.539165, longitude: 127.074042, radius: 15),
    Landmark(number: 42, name: "Sanghuh-Gate", latitude: 37.539692, longitude: 127.072491, radius: 25),
    Landmark(number: 43, name: "Guui side door", latitude: 37.541584, longitude: 127.082226, radius: 15),
    Landmark(number: 44, name: "Dormitory side door", latitude: 37.539255, longitude: 127.076741, radius: 20)
]

let landmarkListChinese: [Landmark] = [
    // 서버 API 반환값 및 랜드마크 인덱스는 1부터 시작하므로 0번째는 더미 노드 추가
    Landmark(number: 0, name: "Error: Index Out of Range", latitude: 0, longitude: 0, radius: 0),
    Landmark(number: 1, name: "山学协同馆", latitude: 37.539765, longitude: 127.073215, radius: 40),
    Landmark(number: 2, name: "入学信息馆", latitude: 37.540296, longitude: 127.07341, radius: 20),
    Landmark(number: 3, name: "兽医学馆", latitude: 37.53931, longitude: 127.07459, radius: 35),
    Landmark(number: 4, name: "动物生命科学馆", latitude: 37.540184, longitude: 127.074179, radius: 30),
    Landmark(number: 5, name: "生命科学馆", latitude: 37.540901, longitude: 127.074055, radius: 40),
    Landmark(number: 6, name: "上许图书馆", latitude: 37.542051, longitude: 127.073808, radius: 55),
    Landmark(number: 7, name: "医生命科学研究馆", latitude: 37.541461, longitude: 127.072215, radius: 36),
    Landmark(number: 8, name: "艺术设计学院", latitude: 37.542908, longitude: 127.072815, radius: 50),
    Landmark(number: 9, name: "语言教育院", latitude: 37.542533, longitude: 127.0747, radius: 35),
    Landmark(number: 10, name: "法学馆", latitude: 37.541667, longitude: 127.075046, radius: 50),
    Landmark(number: 11, name: "上许博物馆", latitude: 37.542375, longitude: 127.075711, radius: 30),
    Landmark(number: 12, name: "行政馆", latitude: 37.543222, longitude: 127.075305, radius: 44),
    Landmark(number: 13, name: "教育科学馆", latitude: 37.543998, longitude: 127.074145, radius: 50),
    Landmark(number: 14, name: "上许研究馆", latitude: 37.544018, longitude: 127.075141, radius: 35),
    Landmark(number: 15, name: "经营馆", latitude: 37.544319, longitude: 127.076184, radius: 40),
    Landmark(number: 16, name: "新千年馆", latitude: 37.543374, longitude: 127.077314, radius: 40),
    Landmark(number: 17, name: "建筑馆", latitude: 37.543732, longitude: 127.078482, radius: 25),
    Landmark(number: 18, name: "房地产学馆", latitude: 37.543283, longitude: 127.078093, radius: 25),
    Landmark(number: 19, name: "人文学馆", latitude: 37.542602, longitude: 127.07825, radius: 40),
    Landmark(number: 20, name: "学生会馆", latitude: 37.541954, longitude: 127.077748, radius: 30),
    Landmark(number: 21, name: "第2学生会馆", latitude: 37.541298, longitude: 127.077828, radius: 35),
    Landmark(number: 22, name: "工学院A", latitude: 37.541655, longitude: 127.078769, radius: 33),
    Landmark(number: 23, name: "工学院B", latitude: 37.542004, longitude: 127.079563, radius: 33),
    Landmark(number: 24, name: "工学院C", latitude: 37.541226, longitude: 127.079357, radius: 28),
    Landmark(number: 25, name: "新工学院", latitude: 37.540455, longitude: 127.079304, radius: 40),
    Landmark(number: 26, name: "科学馆", latitude: 37.541491, longitude: 127.080565, radius: 43),
    Landmark(number: 27, name: "创意馆", latitude: 37.541114, longitude: 127.081743, radius: 45),
    Landmark(number: 28, name: "工艺馆", latitude: 37.54222, longitude: 127.080961, radius: 33),
    Landmark(number: 29, name: "KU技术创新馆", latitude: 37.539995, longitude: 127.07718, radius: 40),
    Landmark(number: 30, name: "宿舍", latitude: 37.539147, longitude: 127.078248, radius: 75),
    Landmark(number: 31, name: "日感湖", latitude: 37.540796, longitude: 127.076495, radius: 50),
    Landmark(number: 32, name: "虹桥", latitude: 37.541688, longitude: 127.077344, radius: 18),
    Landmark(number: 33, name: "黄牛铜像", latitude: 37.543135, longitude: 127.076172, radius: 20),
    Landmark(number: 34, name: "青心台", latitude: 37.542366, longitude: 127.076835, radius: 30),
    Landmark(number: 35, name: "博士铜像", latitude: 37.5413665, longitude: 127.0734648, radius: 25),
    Landmark(number: 36, name: "剧场中央", latitude: 37.541475, longitude: 127.077802, radius: 0),
    Landmark(number: 37, name: "大运动场", latitude: 37.544387, longitude: 127.077593, radius: 65),
    Landmark(number: 38, name: "室内体育馆", latitude: 37.544456, longitude: 127.079587, radius: 50),
    Landmark(number: 39, name: "建国门", latitude: 37.545122, longitude: 127.076613, radius: 20),
    Landmark(number: 40, name: "中门", latitude: 37.541827, longitude: 127.07178, radius: 15),
    Landmark(number: 41, name: "日感门", latitude: 37.539165, longitude: 127.074042, radius: 15),
    Landmark(number: 42, name: "上许门", latitude: 37.539692, longitude: 127.072491, radius: 25),
    Landmark(number: 43, name: "九义站门", latitude: 37.541584, longitude: 127.082226, radius: 15),
    Landmark(number: 44, name: "宿舍门", latitude: 37.539255, longitude: 127.076741, radius: 20)
]
