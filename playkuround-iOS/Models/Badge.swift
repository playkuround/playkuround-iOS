//
//  Badge.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/16/24.
//

import SwiftUI

enum Badge: String, CaseIterable {
    // 출석 관련 뱃지
    case ATTENDANCE_1 = "ATTENDANCE_1"
    case ATTENDANCE_5 = "ATTENDANCE_5"
    case ATTENDANCE_10 = "ATTENDANCE_10"
    case ATTENDANCE_30 = "ATTENDANCE_30"
    case ATTENDANCE_50 = "ATTENDANCE_50"
    case ATTENDANCE_100 = "ATTENDANCE_100"
    
    // 기념일 뱃지
    case ATTENDANCE_FOUNDATION_DAY = "ATTENDANCE_FOUNDATION_DAY"
    case ATTENDANCE_ARBOR_DAY = "ATTENDANCE_ARBOR_DAY"
    case ATTENDANCE_CHILDREN_DAY = "ATTENDANCE_CHILDREN_DAY"
    case ATTENDANCE_WHITE_DAY = "ATTENDANCE_WHITE_DAY"
    case ATTENDANCE_DUCK_DAY = "ATTENDANCE_DUCK_DAY"
    
    // 2024 가을학기 추가 뱃지
     case ATTENDANCE_CHUSEOK_DAY = "ATTENDANCE_CHUSEOK_DAY"
     case ATTENDANCE_KOREAN_DAY = "ATTENDANCE_KOREAN_DAY"
     case ATTENDANCE_DOKDO_DAY = "ATTENDANCE_DOKDO_DAY"
     case ATTENDANCE_KIMCHI_DAY = "ATTENDANCE_KIMCHI_DAY"
     case ATTENDANCE_CHRISTMAS_DAY = "ATTENDANCE_CHRISTMAS_DAY"
    
    // 대학별 뱃지
    case COLLEGE_OF_LIBERAL_ARTS = "COLLEGE_OF_LIBERAL_ARTS"
    case COLLEGE_OF_SCIENCES = "COLLEGE_OF_SCIENCES"
    case COLLEGE_OF_ARCHITECTURE = "COLLEGE_OF_ARCHITECTURE"
    case COLLEGE_OF_ENGINEERING = "COLLEGE_OF_ENGINEERING"
    case COLLEGE_OF_SOCIAL_SCIENCES = "COLLEGE_OF_SOCIAL_SCIENCES"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION = "COLLEGE_OF_BUSINESS_ADMINISTRATION"
    case COLLEGE_OF_REAL_ESTATE = "COLLEGE_OF_REAL_ESTATE"
    case COLLEGE_OF_INSTITUTE_TECHNOLOGY = "COLLEGE_OF_INSTITUTE_TECHNOLOGY"
    case COLLEGE_OF_BIOLOGICAL_SCIENCES = "COLLEGE_OF_BIOLOGICAL_SCIENCES"
    case COLLEGE_OF_VETERINARY_MEDICINE = "COLLEGE_OF_VETERINARY_MEDICINE"
    case COLLEGE_OF_ART_AND_DESIGN = "COLLEGE_OF_ART_AND_DESIGN"
    case COLLEGE_OF_EDUCATION = "COLLEGE_OF_EDUCATION"
    
    // 2024 가을학기 추가 (단과대 2개)
    case COLLEGE_OF_SANG_HUH = "COLLEGE_OF_SANG_HUH"
    case COLLEGE_OF_INTERNATIONAL = "COLLEGE_OF_INTERNATIONAL"
    
    // 경영대 특별 뱃지
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_10 = "COLLEGE_OF_BUSINESS_ADMINISTRATION_10"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_30 = "COLLEGE_OF_BUSINESS_ADMINISTRATION_30"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_50 = "COLLEGE_OF_BUSINESS_ADMINISTRATION_50"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_70 = "COLLEGE_OF_BUSINESS_ADMINISTRATION_70"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_100_AND_FIRST_PLACE = "COLLEGE_OF_BUSINESS_ADMINISTRATION_100_AND_FIRST_PLACE"
    
    // 예디대 특별 뱃지
    case COLLEGE_OF_ART_AND_DESIGN_BEFORE_NOON = "COLLEGE_OF_ART_AND_DESIGN_BEFORE_NOON"
    case COLLEGE_OF_ART_AND_DESIGN_AFTER_NOON = "COLLEGE_OF_ART_AND_DESIGN_AFTER_NOON"
    case COLLEGE_OF_ART_AND_DESIGN_NIGHT = "COLLEGE_OF_ART_AND_DESIGN_NIGHT"
    
    // 공대 특별 뱃지
    case COLLEGE_OF_ENGINEERING_A = "COLLEGE_OF_ENGINEERING_A"
    case COLLEGE_OF_ENGINEERING_B = "COLLEGE_OF_ENGINEERING_B"
    case COLLEGE_OF_ENGINEERING_C = "COLLEGE_OF_ENGINEERING_C"
    
    // 스토리용 뱃지
    case THE_DREAM_OF_DUCK = "THE_DREAM_OF_DUCK"
    
    // 월간랭킹 관련 뱃지
    case MONTHLY_RANKING_1 = "MONTHLY_RANKING_1"
    case MONTHLY_RANKING_2 = "MONTHLY_RANKING_2"
    case MONTHLY_RANKING_3 = "MONTHLY_RANKING_3"
    
    // 2024 가을학기 경영vs건축 이벤트 뱃지
    case BUSINESS_ARCHITECTURE_EVENT_BUSINESS = "BUSINESS_ARCHITECTURE_EVENT_BUSINESS"
    case BUSINESS_ARCHITECTURE_EVENT_ARCHITECTURE = "BUSINESS_ARCHITECTURE_EVENT_ARCHITECTURE"
    
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
            
        case .COLLEGE_OF_SANG_HUH: return "상허교양대"
        case .COLLEGE_OF_INTERNATIONAL: return "국제대"
            
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
            
        case .BUSINESS_ARCHITECTURE_EVENT_BUSINESS: return "경영오리 비쿠"
        case .BUSINESS_ARCHITECTURE_EVENT_ARCHITECTURE: return "건축오리 어쿠"
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
            
        case .COLLEGE_OF_SANG_HUH: return "산학협동관 1회 이상 탐험 시 잠금 해제됩니다."
        case .COLLEGE_OF_INTERNATIONAL: return "법학관 1회 이상 탐험 시 잠금 해제됩니다."
            
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
            
        case .BUSINESS_ARCHITECTURE_EVENT_BUSINESS: return "경영X건축 이벤트 와우도 쟁탈전에 참여하는 경영대학 학생에게 지급됩니다."
        case .BUSINESS_ARCHITECTURE_EVENT_ARCHITECTURE: return "경영X건축 이벤트 와우도 쟁탈전에 참여하는 건축대학 학생에게 지급됩니다."
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
            
        case .COLLEGE_OF_SANG_HUH: return "산학협동관을 탐험했어요"
        case .COLLEGE_OF_INTERNATIONAL: return "법학관을 탐험했어요"
            
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
            
        case .BUSINESS_ARCHITECTURE_EVENT_BUSINESS: return "경영대학의 힘을 보여줘! 와우도를 차지하자!"
        case .BUSINESS_ARCHITECTURE_EVENT_ARCHITECTURE: return "건축대학의 힘을 보여줘! 와우도를 차지하자!"
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
            
        case .COLLEGE_OF_SANG_HUH: return Image(.sanghuh)
        case .COLLEGE_OF_INTERNATIONAL: return Image(.internatioanl)
            
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
            
        case .BUSINESS_ARCHITECTURE_EVENT_BUSINESS: return Image(.bsnsArchEventBusiness)
        case .BUSINESS_ARCHITECTURE_EVENT_ARCHITECTURE: return Image(.bsnsArchEventArchitecture)
        }
    }
}

enum BadgeEnglish: String, CaseIterable {
    // 출석 관련 뱃지
    case ATTENDANCE_1 = "ATTENDANCE_1"
    case ATTENDANCE_5 = "ATTENDANCE_5"
    case ATTENDANCE_10 = "ATTENDANCE_10"
    case ATTENDANCE_30 = "ATTENDANCE_30"
    case ATTENDANCE_50 = "ATTENDANCE_50"
    case ATTENDANCE_100 = "ATTENDANCE_100"
    
    // 기념일 뱃지
    case ATTENDANCE_FOUNDATION_DAY = "ATTENDANCE_FOUNDATION_DAY"
    case ATTENDANCE_ARBOR_DAY = "ATTENDANCE_ARBOR_DAY"
    case ATTENDANCE_CHILDREN_DAY = "ATTENDANCE_CHILDREN_DAY"
    case ATTENDANCE_WHITE_DAY = "ATTENDANCE_WHITE_DAY"
    case ATTENDANCE_DUCK_DAY = "ATTENDANCE_DUCK_DAY"
    
    // 2024 가을학기 추가 뱃지
     case ATTENDANCE_CHUSEOK_DAY = "ATTENDANCE_CHUSEOK_DAY"
     case ATTENDANCE_KOREAN_DAY = "ATTENDANCE_KOREAN_DAY"
     case ATTENDANCE_DOKDO_DAY = "ATTENDANCE_DOKDO_DAY"
     case ATTENDANCE_KIMCHI_DAY = "ATTENDANCE_KIMCHI_DAY"
     case ATTENDANCE_CHRISTMAS_DAY = "ATTENDANCE_CHRISTMAS_DAY"
    
    // 대학별 뱃지
    case COLLEGE_OF_LIBERAL_ARTS = "COLLEGE_OF_LIBERAL_ARTS"
    case COLLEGE_OF_SCIENCES = "COLLEGE_OF_SCIENCES"
    case COLLEGE_OF_ARCHITECTURE = "COLLEGE_OF_ARCHITECTURE"
    case COLLEGE_OF_ENGINEERING = "COLLEGE_OF_ENGINEERING"
    case COLLEGE_OF_SOCIAL_SCIENCES = "COLLEGE_OF_SOCIAL_SCIENCES"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION = "COLLEGE_OF_BUSINESS_ADMINISTRATION"
    case COLLEGE_OF_REAL_ESTATE = "COLLEGE_OF_REAL_ESTATE"
    case COLLEGE_OF_INSTITUTE_TECHNOLOGY = "COLLEGE_OF_INSTITUTE_TECHNOLOGY"
    case COLLEGE_OF_BIOLOGICAL_SCIENCES = "COLLEGE_OF_BIOLOGICAL_SCIENCES"
    case COLLEGE_OF_VETERINARY_MEDICINE = "COLLEGE_OF_VETERINARY_MEDICINE"
    case COLLEGE_OF_ART_AND_DESIGN = "COLLEGE_OF_ART_AND_DESIGN"
    case COLLEGE_OF_EDUCATION = "COLLEGE_OF_EDUCATION"
    
    // 경영대 특별 뱃지
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_10 = "COLLEGE_OF_BUSINESS_ADMINISTRATION_10"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_30 = "COLLEGE_OF_BUSINESS_ADMINISTRATION_30"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_50 = "COLLEGE_OF_BUSINESS_ADMINISTRATION_50"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_70 = "COLLEGE_OF_BUSINESS_ADMINISTRATION_70"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_100_AND_FIRST_PLACE = "COLLEGE_OF_BUSINESS_ADMINISTRATION_100_AND_FIRST_PLACE"
    
    // 예디대 특별 뱃지
    case COLLEGE_OF_ART_AND_DESIGN_BEFORE_NOON = "COLLEGE_OF_ART_AND_DESIGN_BEFORE_NOON"
    case COLLEGE_OF_ART_AND_DESIGN_AFTER_NOON = "COLLEGE_OF_ART_AND_DESIGN_AFTER_NOON"
    case COLLEGE_OF_ART_AND_DESIGN_NIGHT = "COLLEGE_OF_ART_AND_DESIGN_NIGHT"
    
    // 공대 특별 뱃지
    case COLLEGE_OF_ENGINEERING_A = "COLLEGE_OF_ENGINEERING_A"
    case COLLEGE_OF_ENGINEERING_B = "COLLEGE_OF_ENGINEERING_B"
    case COLLEGE_OF_ENGINEERING_C = "COLLEGE_OF_ENGINEERING_C"
    
    // 스토리용 뱃지
    case THE_DREAM_OF_DUCK = "THE_DREAM_OF_DUCK"
    
    // 월간랭킹 관련 뱃지
    case MONTHLY_RANKING_1 = "MONTHLY_RANKING_1"
    case MONTHLY_RANKING_2 = "MONTHLY_RANKING_2"
    case MONTHLY_RANKING_3 = "MONTHLY_RANKING_3"
    
    /// 뱃지 제목
    var title: String {
        switch self {
        case .ATTENDANCE_1: return "First attendance"
        case .ATTENDANCE_5: return "Attendance on day 5"
        case .ATTENDANCE_10: return "10 days attendance"
        case .ATTENDANCE_30: return "30 days of attendance"
        case .ATTENDANCE_50: return "50 days of attendance"
        case .ATTENDANCE_100: return "100 days of attendance"
            
        case .ATTENDANCE_FOUNDATION_DAY: return "Foundation Day"
        case .ATTENDANCE_ARBOR_DAY: return "Arbor Day"
        case .ATTENDANCE_CHILDREN_DAY: return "Children's Day"
        case .ATTENDANCE_WHITE_DAY: return "White Day"
        case .ATTENDANCE_DUCK_DAY: return "Duck Day"
            
        case .ATTENDANCE_CHUSEOK_DAY: return "Chuseok Day"
        case .ATTENDANCE_KOREAN_DAY: return "Korean Day"
        case .ATTENDANCE_DOKDO_DAY: return "Dokdo Day"
        case .ATTENDANCE_KIMCHI_DAY: return "Kimchi Day"
        case .ATTENDANCE_CHRISTMAS_DAY: return "Christmas Day"
            
        case .COLLEGE_OF_ENGINEERING: return "College of Engineering"
        case .COLLEGE_OF_ART_AND_DESIGN: return "College of Art and Design"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION: return "College of Business Administration"
        case .COLLEGE_OF_LIBERAL_ARTS: return "College of Liberal Arts"
        case .COLLEGE_OF_SCIENCES: return "College of Science"
        case .COLLEGE_OF_ARCHITECTURE: return "College of Architecture"
        case .COLLEGE_OF_SOCIAL_SCIENCES: return "College of Social Sciences"
        case .COLLEGE_OF_REAL_ESTATE: return "College of Real Estate"
        case .COLLEGE_OF_INSTITUTE_TECHNOLOGY: return "Institute of Technology"
        case .COLLEGE_OF_BIOLOGICAL_SCIENCES: return "College of Biological Sciences"
        case .COLLEGE_OF_VETERINARY_MEDICINE: return "College of Veterinary Medicine"
        case .COLLEGE_OF_EDUCATION: return "College of Education"
            
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_10: return "Intern"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_30: return "Representative"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_50: return "Manager"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_70: return "Assistant Director"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_100_AND_FIRST_PLACE: return "CEO"
            
        case .COLLEGE_OF_ART_AND_DESIGN_BEFORE_NOON: return "Ducku drinking coffee"
        case .COLLEGE_OF_ART_AND_DESIGN_AFTER_NOON: return "Ducku is working"
        case .COLLEGE_OF_ART_AND_DESIGN_NIGHT: return "Ducku is working at night."
            
        case .COLLEGE_OF_ENGINEERING_A: return "College of Engineering A"
        case .COLLEGE_OF_ENGINEERING_B: return "College of Engineering B"
        case .COLLEGE_OF_ENGINEERING_C: return "College of Engineering C"
            
        case .THE_DREAM_OF_DUCK: return "The Dream of Duck"
            
        case .MONTHLY_RANKING_1: return "Gold Medal"
        case .MONTHLY_RANKING_2: return "Silver Medal"
        case .MONTHLY_RANKING_3: return "Bronze medal"
        }
    }
    
    /// 뱃지 잠겼을 때 설명
    var lockDescription: String {
        switch self {
        case .ATTENDANCE_1: return "Unlocked after 1 game attendance."
        case .ATTENDANCE_5: return "Unlocked after 5 game attendances."
        case .ATTENDANCE_10: return "Unlocked after 10 game attendances."
        case .ATTENDANCE_30: return "Unlocked after 30 game attendances."
        case .ATTENDANCE_50: return "Unlocked after 50 game attendances."
        case .ATTENDANCE_100: return "Unlocked at 100 game attendances."
            
        case .ATTENDANCE_FOUNDATION_DAY: return "Unlocked for Foundation Day (5/15) attendance."
        case .ATTENDANCE_ARBOR_DAY: return "Unlocked for Arbor Day (4/5) attendance"
        case .ATTENDANCE_CHILDREN_DAY: return "Unlocked for attendance on Children's Day (5/5)"
        case .ATTENDANCE_WHITE_DAY: return "Unlocked for attendance on White Day (3/14)"
        case .ATTENDANCE_DUCK_DAY: return "Unlocked for attendance on Duck Day (5/2)"
            
        case .ATTENDANCE_CHUSEOK_DAY: return "Unlocked for Chuseok (9/17) attendance."
        case .ATTENDANCE_KOREAN_DAY: return "Unlocked for attendance on Hangeul Day (10/9)."
        case .ATTENDANCE_DOKDO_DAY: return "Unlocked for attendance on Dokdo Day (10/25)."
        case .ATTENDANCE_KIMCHI_DAY: return "Unlocked for attendance on Kimchi Day (11/22)."
        case .ATTENDANCE_CHRISTMAS_DAY: return "Unlocked for attendance on Christmas Day (12/25)."
            
        case .COLLEGE_OF_ENGINEERING: return "Unlocked when exploring Engineering Halls A, B, C, and New Engineering."
        case .COLLEGE_OF_ART_AND_DESIGN: return "Unlocked by exploring the Art and Design Building and the Crafts Building."
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION: return "Unlocked upon exploring the Administration Building."
        case .COLLEGE_OF_LIBERAL_ARTS: return "Unlocked upon exploring the Humanities Building."
        case .COLLEGE_OF_SCIENCES: return "Unlocked upon exploring the College of Sciences."
        case .COLLEGE_OF_ARCHITECTURE: return "Unlocked upon exploring the Architecture building."
        case .COLLEGE_OF_SOCIAL_SCIENCES: return "Unlocked when exploring the College of Social Sciences."
        case .COLLEGE_OF_REAL_ESTATE: return "Unlocked upon exploration of the Real Estate Department."
        case .COLLEGE_OF_INSTITUTE_TECHNOLOGY: return "Unlocked upon exploring Engineering Halls A, B, C, and Biotechnology."
        case .COLLEGE_OF_BIOLOGICAL_SCIENCES: return "Unlocked when exploring the Animal Life Sciences Building."
        case .COLLEGE_OF_VETERINARY_MEDICINE: return "Unlocked upon exploring the Veterinary Medicine building."
        case .COLLEGE_OF_EDUCATION: return "Unlocked when exploring the College of Education building."
            
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_10: return "Unlocked after 10 game runs in the College of Business building."
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_30: return "Unlocked after 30 game runs in the College of Business building."
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_50: return "Unlocked after 50 game runs in the College of Business building."
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_70: return "Unlocked after 70 game runs in the College of Business building."
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_100_AND_FIRST_PLACE: return "Unlocked after 100 game runs in the College of Business Administration building."
            
        case .COLLEGE_OF_ART_AND_DESIGN_BEFORE_NOON: return "Unlocked when playing in the College of Art and Design building between 9:00 and 11:59."
        case .COLLEGE_OF_ART_AND_DESIGN_AFTER_NOON: return "Unlocked when playing in the College of Art and Design building between 12:00 and 18:00."
        case .COLLEGE_OF_ART_AND_DESIGN_NIGHT: return "Unlocked when playing in the College of Art and Design building between 23:00 and 4:00."
            
        case .COLLEGE_OF_ENGINEERING_A: return "Unlocked when you play the game in the College of Engineering Building A at least 10 times."
        case .COLLEGE_OF_ENGINEERING_B: return "Unlocked after playing the game at least 10 times in College of Engineering Building B."
        case .COLLEGE_OF_ENGINEERING_C: return "Unlocked after playing the game in College of Engineering Building C at least 10 times."
            
        case .THE_DREAM_OF_DUCK: return "Unlocked after viewing all 6 stories."
            
        case .MONTHLY_RANKING_1: return "Unlocked when ranked #1 overall for the month."
        case .MONTHLY_RANKING_2: return "Unlocked when ranked #2 overall for the month."
        case .MONTHLY_RANKING_3: return "Unlocked when ranked #3 overall for the month."
        }
    }
    
    /// 뱃지 열렸을 때 설명
    var description: String {
        switch self {
        case .ATTENDANCE_1: return "Congratulations on your first attendance!"
        case .ATTENDANCE_5: return "You have 5 days of attendance!"
        case .ATTENDANCE_10: return "You have 10 days of attendance!"
        case .ATTENDANCE_30: return "You have 30 days of attendance!"
        case .ATTENDANCE_50: return "You attended 50 days!"
        case .ATTENDANCE_100: return "You have 100 days of attendance!"
            
        case .ATTENDANCE_FOUNDATION_DAY: return "Celebrate Konkuk University's Foundation Day on May 15th in the Kooround!"
        case .ATTENDANCE_ARBOR_DAY: return "Today is Arbor Day! Give the trees a pat on the back for today~"
        case .ATTENDANCE_CHILDREN_DAY: return "If you're a child at heart, aren't you a child? Celebrate our day!"
        case .ATTENDANCE_WHITE_DAY: return "In honor of White Day, we're giving away sweet candy badges in the Circle!"
        case .ATTENDANCE_DUCK_DAY: return "Celebrate being a Duck by logging a Duck Day!"
            
        case .ATTENDANCE_CHUSEOK_DAY: return "Happy Chuseok! I bow to you!"
        case .ATTENDANCE_KOREAN_DAY: return "Celebrating the creation of Hunmin Jeongneum and promoting the excellence of our Korean language!"
        case .ATTENDANCE_DOKDO_DAY: return "Two hundred miles along the sea~ Dokdo is our land!"
        case .ATTENDANCE_KIMCHI_DAY: return "Kimchi, a traditional Korean food that even thieves can't resist! Celebrate Kimchi Day!"
        case .ATTENDANCE_CHRISTMAS_DAY: return "Merry Christmas! Happy Christmas to all"
            
        case .COLLEGE_OF_ENGINEERING: return "You explored the College of Engineering"
        case .COLLEGE_OF_ART_AND_DESIGN: return "You explored the College of Art and Design"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION: return "You have explored the College of Business Administration"
        case .COLLEGE_OF_LIBERAL_ARTS: return "You have explored the College of Liberal Arts"
        case .COLLEGE_OF_SCIENCES: return "You have explored the College of Sciences"
        case .COLLEGE_OF_ARCHITECTURE: return "You have explored the College of Architecture"
        case .COLLEGE_OF_SOCIAL_SCIENCES: return "You have explored the College of Social Sciences"
        case .COLLEGE_OF_REAL_ESTATE: return "You have explored the College of Real Estate"
        case .COLLEGE_OF_INSTITUTE_TECHNOLOGY: return "You have explored the Institute of Technology"
        case .COLLEGE_OF_BIOLOGICAL_SCIENCES: return "You have explored the College of Biological Sciences"
        case .COLLEGE_OF_VETERINARY_MEDICINE: return "You have explored the College of Veterinary Medicine"
        case .COLLEGE_OF_EDUCATION: return "You have explored the College of Education"
            
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_10: return "I am an intern"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_30: return "I've been promoted by proxy!"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_50: return "Exaggerating the coexistence of practice and management"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_70: return "I am a leader. I am a department head"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_100_AND_FIRST_PLACE: return "Top CEO for vision and passion"
            
        case .COLLEGE_OF_ART_AND_DESIGN_BEFORE_NOON: return "Caffeine in my blood."
        case .COLLEGE_OF_ART_AND_DESIGN_AFTER_NOON: return "The ducks are still working today"
        case .COLLEGE_OF_ART_AND_DESIGN_NIGHT: return "The duck is working at night"
            
        case .COLLEGE_OF_ENGINEERING_A: return "I hereby appoint you as a college student of College of Engineering A!"
        case .COLLEGE_OF_ENGINEERING_B: return "I appoint you as a student of College of Engineering Building B!"
        case .COLLEGE_OF_ENGINEERING_C: return "I appoint you as a student of College of Engineering Building C!"
            
        case .THE_DREAM_OF_DUCK: return "You are ready to play PlayKuRound!"
            
        case .MONTHLY_RANKING_1: return "Congratulations on winning first place!"
        case .MONTHLY_RANKING_2: return "Congratulations on winning 2nd place!"
        case .MONTHLY_RANKING_3: return "Congratulations on winning 3rd place!"
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

enum BadgeChinese: String, CaseIterable {
    // 출석 관련 뱃지
    case ATTENDANCE_1 = "ATTENDANCE_1"
    case ATTENDANCE_5 = "ATTENDANCE_5"
    case ATTENDANCE_10 = "ATTENDANCE_10"
    case ATTENDANCE_30 = "ATTENDANCE_30"
    case ATTENDANCE_50 = "ATTENDANCE_50"
    case ATTENDANCE_100 = "ATTENDANCE_100"
    
    // 기념일 뱃지
    case ATTENDANCE_FOUNDATION_DAY = "ATTENDANCE_FOUNDATION_DAY"
    case ATTENDANCE_ARBOR_DAY = "ATTENDANCE_ARBOR_DAY"
    case ATTENDANCE_CHILDREN_DAY = "ATTENDANCE_CHILDREN_DAY"
    case ATTENDANCE_WHITE_DAY = "ATTENDANCE_WHITE_DAY"
    case ATTENDANCE_DUCK_DAY = "ATTENDANCE_DUCK_DAY"
    
    // 2024 가을학기 추가 뱃지
     case ATTENDANCE_CHUSEOK_DAY = "ATTENDANCE_CHUSEOK_DAY"
     case ATTENDANCE_KOREAN_DAY = "ATTENDANCE_KOREAN_DAY"
     case ATTENDANCE_DOKDO_DAY = "ATTENDANCE_DOKDO_DAY"
     case ATTENDANCE_KIMCHI_DAY = "ATTENDANCE_KIMCHI_DAY"
     case ATTENDANCE_CHRISTMAS_DAY = "ATTENDANCE_CHRISTMAS_DAY"
    
    // 대학별 뱃지
    case COLLEGE_OF_LIBERAL_ARTS = "COLLEGE_OF_LIBERAL_ARTS"
    case COLLEGE_OF_SCIENCES = "COLLEGE_OF_SCIENCES"
    case COLLEGE_OF_ARCHITECTURE = "COLLEGE_OF_ARCHITECTURE"
    case COLLEGE_OF_ENGINEERING = "COLLEGE_OF_ENGINEERING"
    case COLLEGE_OF_SOCIAL_SCIENCES = "COLLEGE_OF_SOCIAL_SCIENCES"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION = "COLLEGE_OF_BUSINESS_ADMINISTRATION"
    case COLLEGE_OF_REAL_ESTATE = "COLLEGE_OF_REAL_ESTATE"
    case COLLEGE_OF_INSTITUTE_TECHNOLOGY = "COLLEGE_OF_INSTITUTE_TECHNOLOGY"
    case COLLEGE_OF_BIOLOGICAL_SCIENCES = "COLLEGE_OF_BIOLOGICAL_SCIENCES"
    case COLLEGE_OF_VETERINARY_MEDICINE = "COLLEGE_OF_VETERINARY_MEDICINE"
    case COLLEGE_OF_ART_AND_DESIGN = "COLLEGE_OF_ART_AND_DESIGN"
    case COLLEGE_OF_EDUCATION = "COLLEGE_OF_EDUCATION"
    
    // 경영대 특별 뱃지
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_10 = "COLLEGE_OF_BUSINESS_ADMINISTRATION_10"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_30 = "COLLEGE_OF_BUSINESS_ADMINISTRATION_30"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_50 = "COLLEGE_OF_BUSINESS_ADMINISTRATION_50"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_70 = "COLLEGE_OF_BUSINESS_ADMINISTRATION_70"
    case COLLEGE_OF_BUSINESS_ADMINISTRATION_100_AND_FIRST_PLACE = "COLLEGE_OF_BUSINESS_ADMINISTRATION_100_AND_FIRST_PLACE"
    
    // 예디대 특별 뱃지
    case COLLEGE_OF_ART_AND_DESIGN_BEFORE_NOON = "COLLEGE_OF_ART_AND_DESIGN_BEFORE_NOON"
    case COLLEGE_OF_ART_AND_DESIGN_AFTER_NOON = "COLLEGE_OF_ART_AND_DESIGN_AFTER_NOON"
    case COLLEGE_OF_ART_AND_DESIGN_NIGHT = "COLLEGE_OF_ART_AND_DESIGN_NIGHT"
    
    // 공대 특별 뱃지
    case COLLEGE_OF_ENGINEERING_A = "COLLEGE_OF_ENGINEERING_A"
    case COLLEGE_OF_ENGINEERING_B = "COLLEGE_OF_ENGINEERING_B"
    case COLLEGE_OF_ENGINEERING_C = "COLLEGE_OF_ENGINEERING_C"
    
    // 스토리용 뱃지
    case THE_DREAM_OF_DUCK = "THE_DREAM_OF_DUCK"
    
    // 월간랭킹 관련 뱃지
    case MONTHLY_RANKING_1 = "MONTHLY_RANKING_1"
    case MONTHLY_RANKING_2 = "MONTHLY_RANKING_2"
    case MONTHLY_RANKING_3 = "MONTHLY_RANKING_3"
    
    /// 뱃지 제목
    var title: String {
        switch self {
        case .ATTENDANCE_1: return "第一次出席"
        case .ATTENDANCE_5: return "出席5天"
        case .ATTENDANCE_10: return "出席10天"
        case .ATTENDANCE_30: return "出席30天"
        case .ATTENDANCE_50: return "出席50天"
        case .ATTENDANCE_100: return "出席100天"

        case .ATTENDANCE_FOUNDATION_DAY: return "建校纪念日"
        case .ATTENDANCE_ARBOR_DAY: return "植树节"
        case .ATTENDANCE_CHILDREN_DAY: return "儿童节"
        case .ATTENDANCE_WHITE_DAY: return "白色情人节"
        case .ATTENDANCE_DUCK_DAY: return "鸭子日"

        case .ATTENDANCE_CHUSEOK_DAY: return "秋夕"
        case .ATTENDANCE_KOREAN_DAY: return "韩文字母日"
        case .ATTENDANCE_DOKDO_DAY: return "独岛日"
        case .ATTENDANCE_KIMCHI_DAY: return "泡菜日"
        case .ATTENDANCE_CHRISTMAS_DAY: return "圣诞节"
   
        case .COLLEGE_OF_ENGINEERING: return "工程学院"
        case .COLLEGE_OF_ART_AND_DESIGN: return "艺术与设计学院"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION: return "商学院"
        case .COLLEGE_OF_LIBERAL_ARTS: return "文科学院"
        case .COLLEGE_OF_SCIENCES: return "理科学院"
        case .COLLEGE_OF_ARCHITECTURE: return "建筑学院"
        case .COLLEGE_OF_SOCIAL_SCIENCES: return "社会科学学院"
        case .COLLEGE_OF_REAL_ESTATE: return "房地产学院"
        case .COLLEGE_OF_INSTITUTE_TECHNOLOGY: return "融合科技学院"
        case .COLLEGE_OF_BIOLOGICAL_SCIENCES: return "生命科学学院"
        case .COLLEGE_OF_VETERINARY_MEDICINE: return "兽医学院"
        case .COLLEGE_OF_EDUCATION: return "教育学院"
      
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_10: return "实习生"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_30: return "代理"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_50: return "科长"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_70: return "部长"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_100_AND_FIRST_PLACE: return "CEO"
            
        case .COLLEGE_OF_ART_AND_DESIGN_BEFORE_NOON: return "咖啡因中毒的鸭子"
        case .COLLEGE_OF_ART_AND_DESIGN_AFTER_NOON: return "工作的鸭子"
        case .COLLEGE_OF_ART_AND_DESIGN_NIGHT: return "夜间工作的鸭子"

        case .COLLEGE_OF_ENGINEERING_A: return "工学院A"
        case .COLLEGE_OF_ENGINEERING_B: return "工学院B"
        case .COLLEGE_OF_ENGINEERING_C: return "工学院C"

        case .THE_DREAM_OF_DUCK: return "鸭子的梦想"

        case .MONTHLY_RANKING_1: return "金牌"
        case .MONTHLY_RANKING_2: return "银牌"
        case .MONTHLY_RANKING_3: return "铜牌"
        }
    }
    
    /// 뱃지 잠겼을 때 설명
    var lockDescription: String {
        switch self {
        case .ATTENDANCE_1: return "游戏出席1次后解锁"
        case .ATTENDANCE_5: return "游戏出席5次后解锁"
        case .ATTENDANCE_10: return "游戏出席10次后解锁"
        case .ATTENDANCE_30: return "游戏出席30次后解锁"
        case .ATTENDANCE_50: return "游戏出席50次后解锁"
        case .ATTENDANCE_100: return "游戏出席100次后解锁"
         
        case .ATTENDANCE_FOUNDATION_DAY: return "建校纪念日(5/15)出席时解锁"
        case .ATTENDANCE_ARBOR_DAY: return "植树节(4/5)出席时解锁。"
        case .ATTENDANCE_CHILDREN_DAY: return "儿童节(5/5)出席时解锁"
        case .ATTENDANCE_WHITE_DAY: return "白色情人节(3/14)出席时解锁"
        case .ATTENDANCE_DUCK_DAY: return "鸭子日(5/2)出席时解锁"

        case .ATTENDANCE_CHUSEOK_DAY: return "秋夕(9/17)出席时解锁"
        case .ATTENDANCE_KOREAN_DAY: return "韩文日(10/9)出席时解锁"
        case .ATTENDANCE_DOKDO_DAY: return "独岛日(10/25)出席时解锁"
        case .ATTENDANCE_KIMCHI_DAY: return "泡菜日(11/22)出席时解锁"
        case .ATTENDANCE_CHRISTMAS_DAY: return "圣诞节(12/25)出席时解锁"
     
        case .COLLEGE_OF_ENGINEERING: return "工程馆A, B, C, 新工程馆探险时解锁"
        case .COLLEGE_OF_ART_AND_DESIGN: return "艺术设计馆，工艺馆探险时解锁"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION: return "管理馆探险时解锁"
        case .COLLEGE_OF_LIBERAL_ARTS: return "人文学馆探险时解锁"
        case .COLLEGE_OF_SCIENCES: return "科学馆探险时解锁"
        case .COLLEGE_OF_ARCHITECTURE: return "建筑馆探险时解锁"
        case .COLLEGE_OF_SOCIAL_SCIENCES: return "商虞研究馆探险时解锁"
        case .COLLEGE_OF_REAL_ESTATE: return "房地产学馆探险时解锁"
        case .COLLEGE_OF_INSTITUTE_TECHNOLOGY: return "工程馆A, B, C, 生物工程馆探险时解锁"
        case .COLLEGE_OF_BIOLOGICAL_SCIENCES: return "动物生命科学馆探险时解锁"
        case .COLLEGE_OF_VETERINARY_MEDICINE: return "兽医学馆探险时解锁"
        case .COLLEGE_OF_EDUCATION: return "教育科学馆探险时解锁"

            
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_10: return "在经营学院大楼进行10次游戏时会解锁"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_30: return "在经营学院大楼进行30次游戏时会解锁"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_50: return "在经营学院大楼进行50次游戏时会解锁"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_70: return "在经营学院大楼进行70次游戏时会解锁"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_100_AND_FIRST_PLACE: return "在经营学院大楼进行100次游戏时会解锁"
            
        case .COLLEGE_OF_ART_AND_DESIGN_BEFORE_NOON: return "9:00~11:59之间在艺术设计大学大楼进行游戏时将解锁"
        case .COLLEGE_OF_ART_AND_DESIGN_AFTER_NOON: return "12:00 ~ 18:00之间在艺术设计大学大楼进行游戏时将解锁"
        case .COLLEGE_OF_ART_AND_DESIGN_NIGHT: return "23:00 ~ 4:00之间在艺术设计大学大楼进行游戏时将解锁"
            
        case .COLLEGE_OF_ENGINEERING_A: return "在工学大学A馆运行10次以上游戏时, 将被解锁"
        case .COLLEGE_OF_ENGINEERING_B: return "在工学大学B馆运行10次以上游戏时, 将被解锁"
        case .COLLEGE_OF_ENGINEERING_C: return "在工学大学C馆运行10次以上游戏时, 将被解锁"
            
        case .THE_DREAM_OF_DUCK: return "如果查看所有6个故事画面, 就可以解锁"
            
        case .MONTHLY_RANKING_1: return "月度总排名第1时解锁。"
        case .MONTHLY_RANKING_2: return "月度总排名第2时解锁。"
        case .MONTHLY_RANKING_3: return "月度总排名第3时解锁。"

        }
    }
    
    /// 뱃지 열렸을 때 설명
    var description: String {
        switch self {
       case .ATTENDANCE_1: return "恭喜您第一次出席！"
       case .ATTENDANCE_5: return "您已经出席了5天！"
       case .ATTENDANCE_10: return "您已经出席了10天！"
       case .ATTENDANCE_30: return "您已经出席了30天！"
       case .ATTENDANCE_50: return "您已经出席了50天！"
       case .ATTENDANCE_100: return "您已经出席了100天！"

        case .ATTENDANCE_FOUNDATION_DAY: return "祝贺建国大学的建校纪念日5月15日的游戏！"
        case .ATTENDANCE_ARBOR_DAY: return "今天是植树节！今天也要给树木一句赞美~"
        case .ATTENDANCE_CHILDREN_DAY: return "心中有童心就是儿童吗？祝我们的日子快乐！"
        case .ATTENDANCE_WHITE_DAY: return "为庆祝白色情人节，游戏中赠送甜蜜的糖果徽章！"
        case .ATTENDANCE_DUCK_DAY: return "记录鸭子的日子，鸭子啊，祝贺你！"

        case .ATTENDANCE_CHUSEOK_DAY: return "祝您丰收的中秋节！送您鸭子礼！"
        case .ATTENDANCE_KOREAN_DAY: return "纪念训民正音的创制，宣传我们韩文的优越性！"
        case .ATTENDANCE_DOKDO_DAY: return "沿着船路两百里~独岛是我们的土地！"
        case .ATTENDANCE_KIMCHI_DAY: return "连小偷鸭也不能抵挡的韩国传统美食泡菜！庆祝泡菜日！"
        case .ATTENDANCE_CHRISTMAS_DAY: return "圣诞快乐！祝大家度过一个幸福的圣诞节！"

        case .COLLEGE_OF_ENGINEERING: return "探索了工程学院"
        case .COLLEGE_OF_ART_AND_DESIGN: return "探索了艺术设计学院"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION: return "探索了商学院"
        case .COLLEGE_OF_LIBERAL_ARTS: return "探索了文学院"
        case .COLLEGE_OF_SCIENCES: return "探索了理学院"
        case .COLLEGE_OF_ARCHITECTURE: return "探索了建筑学院"
        case .COLLEGE_OF_SOCIAL_SCIENCES: return "探索了社会科学学院"
        case .COLLEGE_OF_REAL_ESTATE: return "探索了房地产科学研究院"
        case .COLLEGE_OF_INSTITUTE_TECHNOLOGY: return "探索了融合科学技术研究院"
        case .COLLEGE_OF_BIOLOGICAL_SCIENCES: return "探索了生命科学学院"
        case .COLLEGE_OF_VETERINARY_MEDICINE: return "探索了兽医学学院"
        case .COLLEGE_OF_EDUCATION: return "探索了师范学院"

            
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_10: return "我是实习生"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_30: return "我是代理"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_50: return "我是科长"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_70: return "我是部长"
        case .COLLEGE_OF_BUSINESS_ADMINISTRATION_100_AND_FIRST_PLACE: return "我是CEO"

        case .COLLEGE_OF_ART_AND_DESIGN_BEFORE_NOON: return "正在喝咖啡.."
        case .COLLEGE_OF_ART_AND_DESIGN_AFTER_NOON: return "今天的鸭子正在工作中"
        case .COLLEGE_OF_ART_AND_DESIGN_NIGHT: return "艺术设计专业的学生们正在夜间工作"

        case .COLLEGE_OF_ENGINEERING_A: return "您被任命为工学院A楼的大学生！"
        case .COLLEGE_OF_ENGINEERING_B: return "您被任命为工学院B楼的大学生！"
        case .COLLEGE_OF_ENGINEERING_C: return "您被任命为工学院C楼的大学生！"

        case .THE_DREAM_OF_DUCK: return "游戏准备完成！"

        case .MONTHLY_RANKING_1: return "恭喜您获得月度排名第一！"
        case .MONTHLY_RANKING_2: return "恭喜您获得月度排名第二！"
        case .MONTHLY_RANKING_3: return "恭喜您获得月度排名第三！"

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

