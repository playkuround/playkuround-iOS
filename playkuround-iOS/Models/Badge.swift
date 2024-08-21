//
//  Badge.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/16/24.
//

import SwiftUI

enum Badge: String, CaseIterable {
    // 출석 관련 뱃지
    case ATTENDANCE_1 = "첫 출석"
    case ATTENDANCE_5 = "5회 출석"
    case ATTENDANCE_10 = "10회 출석"
    case ATTENDANCE_30 = "30회 출석"
    case ATTENDANCE_50 = "50회 출석"
    case ATTENDANCE_100 = "100회 출석"
    
    // 기념일 뱃지
    case ATTENDANCE_FOUNDATION_DAY = "05월 15일 개교 기념일에 출석"
    case ATTENDANCE_ARBOR_DAY = "04월 05일 식목일에 출석"
    case ATTENDANCE_CHILDREN_DAY = "05월 05일 어린이날에 출석"
    case ATTENDANCE_WHITE_DAY = "03월 14일 화이트데이에 출석"
    case ATTENDANCE_DUCK_DAY = "05월 02일 오리데이에 출석"
    
    // 2024 가을학기 추가 뱃지
     case ATTENDANCE_CHUSEOK_DAY = "09월 17일 추석날에 출석"
     case ATTENDANCE_KOREAN_DAY = "10월 09일 한글날에 출석"
     case ATTENDANCE_DOKDO_DAY = "10월 25일 독도의 날에 출석"
     case ATTENDANCE_KIMCHI_DAY = "11월 22일 김치의 날에 출석"
     case ATTENDANCE_CHRISTMAS_DAY = "12월 25일 성탄절에 출석"
    
    // 대학별 뱃지
    case COLLEGE_OF_LIBERAL_ARTS = "문과대학 1회 이상 탐험"
    case COLLEGE_OF_SCIENCES = "이과대학 1회 이상 탐험"
    case COLLEGE_OF_ARCHITECTURE = "건축대학 1회 이상 탐험"
    case COLLEGE_OF_ENGINEERING = "공과대학 1회 이상 탐험"
    case COLLEGE_OF_SOCIAL_SCIENCES = "사회과학대학 1회 이상 탐험"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION = "경영대학 1회 이상 탐험"
    case COLLEGE_OF_REAL_ESTATE = "부동산과학원 1회 이상 탐험"
    case COLLEGE_OF_INSTITUTE_TECHNOLOGY = "융합과학기술원 1회 이상 탐험"
    case COLLEGE_OF_BIOLOGICAL_SCIENCES = "생명과학대학 1회 이상 탐험"
    case COLLEGE_OF_VETERINARY_MEDICINE = "수의과대학 1회 이상 탐험"
    case COLLEGE_OF_ART_AND_DESIGN = "예술디자인대학 1회 이상 탐험"
    case COLLEGE_OF_EDUCATION = "사범대학 1회 이상 탐험"
    
    // 경영대 특별 뱃지
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_10 = "경영대학 10회 이상 탐험"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_30 = "경영대학 30회 이상 탐험"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_50 = "경영대학 50회 이상 탐험"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_70 = "경영대학 70회 이상 탐험"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_100_AND_FIRST_PLACE = "경영대학 100회 이상 탐험 및 1등 달성"
    
    // 예디대 특별 뱃지
    case COLLEGE_OF_ART_AND_DESIGN_BEFORE_NOON = "예술디자인대학 09:00 ~ 11:59 탐험"
    case COLLEGE_OF_ART_AND_DESIGN_AFTER_NOON = "예술디자인대학 12:00 ~ 18:00 탐험"
    case COLLEGE_OF_ART_AND_DESIGN_NIGHT = "예술디자인대학 23:00 ~ 04:00 탐험"
    
    // 공대 특별 뱃지
    case COLLEGE_OF_ENGINEERING_A = "공대 A동 10회 이상 탐험"
    case COLLEGE_OF_ENGINEERING_B = "공대 B동 10회 이상 탐험"
    case COLLEGE_OF_ENGINEERING_C = "공대 C동 10회 이상 탐험"
    
    // 스토리용 뱃지
    case THE_DREAM_OF_DUCK = "스토리 컷씬 마스터"
    
    // 월간랭킹 관련 뱃지
    case MONTHLY_RANKING_1 = "월간 랭킹 1등"
    case MONTHLY_RANKING_2 = "월간 랭킹 2등"
    case MONTHLY_RANKING_3 = "월간 랭킹 3등"
    
    /// 뱃지 제목
    var title: String {
        switch self {
        case .ATTENDANCE_1: return "첫 출석"
        case .ATTENDANCE_5: return "5일 출석"
        case .ATTENDANCE_10: return "10일 출석"
        case .ATTENDANCE_30: return "30일 출석"
        case .ATTENDANCE_50: return "50일 출석"
        case .ATTENDANCE_100: return "100일 출석"
            
        case .ATTENDANCE_FOUNDATION_DAY: return "개교기념일"
        case .ATTENDANCE_ARBOR_DAY: return "식목일"
        case .ATTENDANCE_CHILDREN_DAY: return "어린이날"
        case .ATTENDANCE_WHITE_DAY: return "화이트데이"
        case .ATTENDANCE_DUCK_DAY: return "오리의날"
            
        case .ATTENDANCE_CHUSEOK_DAY: return "추석"
        case .ATTENDANCE_KOREAN_DAY: return "한글날"
        case .ATTENDANCE_DOKDO_DAY: return "독도의 날"
        case .ATTENDANCE_KIMCHI_DAY: return "김치의 날"
        case .ATTENDANCE_CHRISTMAS_DAY: return "성탄절"
            
        case .COLLEGE_OF_ENGINEERING: return "공과대"
        case .COLLEGE_OF_ART_AND_DESIGN: return "예디대"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION: return "경영대"
        case .COLLEGE_OF_LIBERAL_ARTS: return "문과대"
        case .COLLEGE_OF_SCIENCES: return "이과대"
        case .COLLEGE_OF_ARCHITECTURE: return "건축대"
        case .COLLEGE_OF_SOCIAL_SCIENCES: return "사과대"
        case .COLLEGE_OF_REAL_ESTATE: return "부동산"
        case .COLLEGE_OF_INSTITUTE_TECHNOLOGY: return "융과기"
        case .COLLEGE_OF_BIOLOGICAL_SCIENCES: return "생과대"
        case .COLLEGE_OF_VETERINARY_MEDICINE: return "수의대"
        case .COLLEGE_OF_EDUCATION: return "사범대"
            
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_10: return "인턴"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_30: return "대리"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_50: return "과장"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_70: return "부장"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_100_AND_FIRST_PLACE: return "CEO"
            
        case .COLLEGE_OF_ART_AND_DESIGN_BEFORE_NOON: return "카페인 노예 덕쿠"
        case .COLLEGE_OF_ART_AND_DESIGN_AFTER_NOON: return "덕쿠는 작업중"
        case .COLLEGE_OF_ART_AND_DESIGN_NIGHT: return "야작하는 덕쿠"
            
        case .COLLEGE_OF_ENGINEERING_A: return "공대A"
        case .COLLEGE_OF_ENGINEERING_B: return "공대B"
        case .COLLEGE_OF_ENGINEERING_C: return "공대C"
            
        case .THE_DREAM_OF_DUCK: return "오리의 꿈"
            
        case .MONTHLY_RANKING_1: return "금메달"
        case .MONTHLY_RANKING_2: return "은메달"
        case .MONTHLY_RANKING_3: return "동메달"
        }
    }
    
    /// 뱃지 잠겼을 때 설명
    var lockDescription: String {
        switch self {
        case .ATTENDANCE_1: return "플레이쿠라운드 출석 1회시 잠금 해제됩니다."
        case .ATTENDANCE_5: return "플레이쿠라운드 출석 5회시 잠금 해제됩니다."
        case .ATTENDANCE_10: return "플레이쿠라운드 출석 10회시 잠금 해제됩니다."
        case .ATTENDANCE_30: return "플레이쿠라운드 출석 30회시 잠금 해제됩니다."
        case .ATTENDANCE_50: return "플레이쿠라운드 출석 50회시 잠금 해제됩니다."
        case .ATTENDANCE_100: return "플레이쿠라운드 출석 100회시 잠금 해제됩니다."
            
        case .ATTENDANCE_FOUNDATION_DAY: return "개교기념일(5/15) 출석 시 잠금 해제됩니다."
        case .ATTENDANCE_ARBOR_DAY: return "식목일(4/5) 출석 시 잠금 해제됩니다"
        case .ATTENDANCE_CHILDREN_DAY: return "어린이날(5/5) 출석 시 잠금 해제됩니다"
        case .ATTENDANCE_WHITE_DAY: return "화이트데이(3/14) 출석 시 잠금 해제됩니다"
        case .ATTENDANCE_DUCK_DAY: return "오리의날(5/2) 출석 시 잠금 해제됩니다"
            
        case .ATTENDANCE_CHUSEOK_DAY: return "추석(9/17) 출석 시 잠금 해제됩니다."
        case .ATTENDANCE_KOREAN_DAY: return "한글날(10/9) 출석 시 잠금 해제됩니다."
        case .ATTENDANCE_DOKDO_DAY: return "독도의 날(10/25) 출석 시 잠금 해제됩니다."
        case .ATTENDANCE_KIMCHI_DAY: return "김치의 날(11/22) 출석 시 잠금 해제됩니다."
        case .ATTENDANCE_CHRISTMAS_DAY: return "성탄절(12/25) 출석 시 잠금 해제됩니다."
            
        case .COLLEGE_OF_ENGINEERING: return "공학관 A, B, C, 신공학관 탐험 시 잠금 해제됩니다."
        case .COLLEGE_OF_ART_AND_DESIGN: return "예술디자인관, 공예관 탐험 시 잠금 해제됩니다."
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION: return "경영관 탐험 시 잠금 해제됩니다."
        case .COLLEGE_OF_LIBERAL_ARTS: return "인문학관 탐험 시 잠금 해제됩니다."
        case .COLLEGE_OF_SCIENCES: return "과학관 탐험 시 잠금 해제됩니다."
        case .COLLEGE_OF_ARCHITECTURE: return "건축관 탐험 시 잠금 해제됩니다."
        case .COLLEGE_OF_SOCIAL_SCIENCES: return "상허연구관 탐험 시 잠금 해제됩니다."
        case .COLLEGE_OF_REAL_ESTATE: return "부동산학관 탐험 시 잠금 해제됩니다."
        case .COLLEGE_OF_INSTITUTE_TECHNOLOGY: return "공학관 A, B, C, 생명공학관 탐험 시 잠금 해제됩니다."
        case .COLLEGE_OF_BIOLOGICAL_SCIENCES: return "동물생명과학관 탐험 시 잠금 해제됩니다."
        case .COLLEGE_OF_VETERINARY_MEDICINE: return "수의학관 탐험 시 잠금 해제됩니다."
        case .COLLEGE_OF_EDUCATION: return "교육과학관 탐험 시 잠금 해제됩니다."
            
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_10: return "경영대 건물에서 10회 게임 실행 시 잠금 해제됩니다."
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_30: return "경영대 건물에서 30회 게임 실행 시 잠금 해제됩니다."
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_50: return "경영대 건물에서 50회 게임 실행 시 잠금 해제됩니다."
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_70: return "경영대 건물에서 70회 게임 실행 시 잠금 해제됩니다."
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_100_AND_FIRST_PLACE: return "경영대 건물에서 100회 게임 실행 시 잠금 해제됩니다."
            
        case .COLLEGE_OF_ART_AND_DESIGN_BEFORE_NOON: return "9:00 ~ 11:59 사이 예디대 건물에서 게임 실행 시 잠금 해제됩니다."
        case .COLLEGE_OF_ART_AND_DESIGN_AFTER_NOON: return "12:00 ~ 18:00 사이 예디대 건물에서 게임 실행 시 잠금 해제됩니다."
        case .COLLEGE_OF_ART_AND_DESIGN_NIGHT: return "23:00 ~ 4:00 사이 예디대 건물에서 게임 실행 시 잠금 해제됩니다."
            
        case .COLLEGE_OF_ENGINEERING_A: return "공대 A관에서 게임 10회 이상 게임 실행 시 잠금 해제됩니다."
        case .COLLEGE_OF_ENGINEERING_B: return "공대 B관에서 게임 10회 이상 게임 실행 시 잠금 해제됩니다."
        case .COLLEGE_OF_ENGINEERING_C: return "공대 C관에서 게임 10회 이상 게임 실행 시 잠금 해제됩니다."
            
        case .THE_DREAM_OF_DUCK: return "6개의 스토리 컷씬 모두 보면 잠금 해제됩니다."
            
        case .MONTHLY_RANKING_1: return "월간 전체 랭킹 1등 시 잠금 해제됩니다."
        case .MONTHLY_RANKING_2: return "월간 전체 랭킹 2등 시 잠금 해제됩니다."
        case .MONTHLY_RANKING_3: return "월간 전체 랭킹 3등 시 잠금 해제됩니다."
        }
    }
    
    /// 뱃지 열렸을 때 설명
    var description: String {
        switch self {
        case .ATTENDANCE_1: return "첫 출석을 축하드려요!"
        case .ATTENDANCE_5: return "5일 출석하셨어요!"
        case .ATTENDANCE_10: return "10일 출석하셨어요!"
        case .ATTENDANCE_30: return "30일 출석하셨어요!"
        case .ATTENDANCE_50: return "50일 출석하셨어요!"
        case .ATTENDANCE_100: return "100일 출석하셨어요!"
            
        case .ATTENDANCE_FOUNDATION_DAY: return "건국대학교의 개교기념일 5월 15일 쿠라운드에서 축하해요!"
        case .ATTENDANCE_ARBOR_DAY: return "오늘은 식목일! 오늘만이라도 나무들에게 칭찬 한마디~"
        case .ATTENDANCE_CHILDREN_DAY: return "마음이 어린이면 어린이 아닌가요? 우리의 날을 축하하며!"
        case .ATTENDANCE_WHITE_DAY: return "화이트데이를 기념해 쿠라운드에서 달콤한 사탕 뱃지를 드립니다!"
        case .ATTENDANCE_DUCK_DAY: return "덕쿠의날을 기록하며 덕쿠야 축하해!"
            
        case .ATTENDANCE_CHUSEOK_DAY: return "풍요로운 추석 보내세요! 덕쿠 절 드립니다!"
        case .ATTENDANCE_KOREAN_DAY: return "훈민정음 창제를 기념하고 우리 한글의 우수성을 알리며!"
        case .ATTENDANCE_DOKDO_DAY: return "뱃길따라 이백리~ 독도는 우리땅!"
        case .ATTENDANCE_KIMCHI_DAY: return "도둑 덕쿠도 못참는 한국의 전통음식 김치! 김치의 날을 기념해요!"
        case .ATTENDANCE_CHRISTMAS_DAY: return "Merry Christmas! 모두 행복한 크리스마스 보내세요"
            
        case .COLLEGE_OF_ENGINEERING: return "공과대학을 탐험했어요"
        case .COLLEGE_OF_ART_AND_DESIGN: return "예술디자인대학을 탐험했어요"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION: return "경영대학을 탐험했어요"
        case .COLLEGE_OF_LIBERAL_ARTS: return "문과대학을 탐험했어요"
        case .COLLEGE_OF_SCIENCES: return "이과대학을 탐험했어요"
        case .COLLEGE_OF_ARCHITECTURE: return "건축대학을 탐험했어요"
        case .COLLEGE_OF_SOCIAL_SCIENCES: return "사회과학대학을 탐험했어요"
        case .COLLEGE_OF_REAL_ESTATE: return "부동산과학원을 탐험했어요"
        case .COLLEGE_OF_INSTITUTE_TECHNOLOGY: return "융합과학기술원을 탐험했어요"
        case .COLLEGE_OF_BIOLOGICAL_SCIENCES: return "생명과학대학을 탐험했어요"
        case .COLLEGE_OF_VETERINARY_MEDICINE: return "수의과대학을 탐험했어요"
        case .COLLEGE_OF_EDUCATION: return "사범대학을 탐험했어요"
            
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_10: return "네..! 넵의 연속 나는야 새싹 인턴"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_30: return "이걸 제가요? 어엿한 대리 승급!"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_50: return "라떼는 말이야… 실무와 관리의 공존 과장"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_70: return "어째서 내가 리더..?\n경쟁을 이끌어! 부장"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_100_AND_FIRST_PLACE: return "john 우리의 수익을 develop할 수 있는 방안 없을까? 비전과 열정 탑 CEO"
            
        case .COLLEGE_OF_ART_AND_DESIGN_BEFORE_NOON: return "예디대생들 피엔 카페인이 흘러.. "
        case .COLLEGE_OF_ART_AND_DESIGN_AFTER_NOON: return "영차영차 오늘도 덕쿠는 작업중"
        case .COLLEGE_OF_ART_AND_DESIGN_NIGHT: return "너 야작해..?\n예디대생들은 야작의 노예"
            
        case .COLLEGE_OF_ENGINEERING_A: return "당신을 공대 A관의 공돌이로 임명합니다!"
        case .COLLEGE_OF_ENGINEERING_B: return "당신을 공대 B관의 공돌이로 임명합니다!"
        case .COLLEGE_OF_ENGINEERING_C: return "당신을 공대 C관의 공돌이로 임명합니다!"
            
        case .THE_DREAM_OF_DUCK: return "컷신을 모두 보셨군요!\n쿠라운드를 즐길 준비 완료!"
            
        case .MONTHLY_RANKING_1: return "월간 랭킹 1위 기록을 축하드립니다!"
        case .MONTHLY_RANKING_2: return "월간 랭킹 2위 기록을 축하드립니다!"
        case .MONTHLY_RANKING_3: return "월간 랭킹 3위 기록을 축하드립니다!"
        }
    }
    
    /// 뱃지 이미지
    var image: Image {
        switch self {
        case .ATTENDANCE_1: return Image(.attendance1)
        case .ATTENDANCE_5: return Image(.attendance5)
        case .ATTENDANCE_10: return Image(.attendance10)
        case .ATTENDANCE_30: return Image(.attendance30)
        case .ATTENDANCE_50: return Image(.attendance50)
        case .ATTENDANCE_100: return Image(.attendance100)
            
        case .ATTENDANCE_FOUNDATION_DAY: return Image(.foundationDay)
        case .ATTENDANCE_ARBOR_DAY: return Image(.arborDay)
        case .ATTENDANCE_CHILDREN_DAY: return Image(.childrenDay)
        case .ATTENDANCE_WHITE_DAY: return Image(.whiteDay)
        case .ATTENDANCE_DUCK_DAY: return Image(.duckDay)
            
        case .ATTENDANCE_CHUSEOK_DAY: return Image(.chuseokDay)
        case .ATTENDANCE_KOREAN_DAY: return Image(.koreanDay)
        case .ATTENDANCE_DOKDO_DAY: return Image(.dokdoDay)
        case .ATTENDANCE_KIMCHI_DAY: return Image(.kimchiDay)
        case .ATTENDANCE_CHRISTMAS_DAY: return Image(.christmasDay)
            
        case .COLLEGE_OF_ENGINEERING: return Image(.engineering)
        case .COLLEGE_OF_ART_AND_DESIGN: return Image(.artAndDesign)
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION: return Image(.businessAdministration)
        case .COLLEGE_OF_LIBERAL_ARTS: return Image(.liberalArts)
        case .COLLEGE_OF_SCIENCES: return Image(.sciences)
        case .COLLEGE_OF_ARCHITECTURE: return Image(.architecture)
        case .COLLEGE_OF_SOCIAL_SCIENCES: return Image(.socialSciences)
        case .COLLEGE_OF_REAL_ESTATE: return Image(.realEstate)
        case .COLLEGE_OF_INSTITUTE_TECHNOLOGY: return Image(.instituteTechnology)
        case .COLLEGE_OF_BIOLOGICAL_SCIENCES: return Image(.biologicalSciences)
        case .COLLEGE_OF_VETERINARY_MEDICINE: return Image(.veterinaryMedicine)
        case .COLLEGE_OF_EDUCATION: return Image(.education)
            
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_10: return Image(.intern)
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_30: return Image(.daeri)
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_50: return Image(.gwajang)
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_70: return Image(.boojang)
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_100_AND_FIRST_PLACE: return Image(.ceo)
            
        case .COLLEGE_OF_ART_AND_DESIGN_BEFORE_NOON: return Image(.artAndDesignbeforeNoon)
        case .COLLEGE_OF_ART_AND_DESIGN_AFTER_NOON: return Image(.artAndDesignafterNoon)
        case .COLLEGE_OF_ART_AND_DESIGN_NIGHT: return Image(.artAndDesignNight)
            
        case .COLLEGE_OF_ENGINEERING_A: return Image(.engineeringA)
        case .COLLEGE_OF_ENGINEERING_B: return Image(.engineeringB)
        case .COLLEGE_OF_ENGINEERING_C: return Image(.engineeringC)
            
        case .THE_DREAM_OF_DUCK: return Image(.random)
            
        case .MONTHLY_RANKING_1: return Image(.ranking1)
        case .MONTHLY_RANKING_2: return Image(.ranking2)
        case .MONTHLY_RANKING_3: return Image(.ranking3)
        }
    }
}
