//
//  Story.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 7/15/24.
//

import SwiftUI

struct Story {
    let number: Int
    let image: Image
    let title: String
    let description: String
}

let storys: [Story] = [Story(number: 1,
                             image: Image(.storyImage1),
                             title: "덕쿠의 꿈",
                             description:  "일감호에 사는 INFP 소심한 오리 덕쿠. 오늘도 캠퍼스와 학생들을 바라보며 상상을 한다. “학교를 다니는 건 어떤 기분일까?” “나도 건국대학교 학생이고 싶어!”"),
                       Story(number: 2,
                             image: Image(.storyImage2),
                             title: "소원을 들어줘",
                             description: "어느날 잠에 들어 꿈을 꾸는데... 유석창 박사님 동상이 이야기를 한다..!.. “건국대학교의 학생이 되고싶다면.. 성신의를 찾아라...” “헉! 성신의라고 불리는 보물을 찾아오면 내 소원을 들어주겠다고?!”"),
                       Story(number: 3,
                             image: Image(.storyImage3),
                             title: "모험가 덕쿠",
                             description: "퍼뜩 깨어난 덕쿠, “성신의? 까짓거 찾아주겠어.” 건대생을 꿈꾸며 보물 성신의를 찾기 위해 캠퍼스를 돌아다니며 열심히 모험을 떠난다."),
                       Story(number: 4,
                             image: Image(.storyImage4),
                             title: "보물이 없어",
                             description: "건국대학교 캠퍼스를 전부 돌아다니며 산전수전을 겪은 덕쿠... 하지만.. 아무리 찾아봐도 성신의는 없다...“도대체 성신의란 보물은 어디있는거지?! 아니 애초에 어떻게 생긴거지?!?!?”"),
                       Story(number: 5,
                             image: Image(.storyImage5),
                             title: "성신의의 진실",
                             description: "”설마..!” 덕쿠는 성신의는 물질적인 것이 아니라 모험하는 과정에서 얻을 수 있는 내적인 가치라는 것을 깨달았다."),
                       Story(number: 6,
                             image: Image(.storyImage5),
                             title: "모험의 시작",
                             description: "덕쿠의 건국대학교 학생이 되기위한 모험은 이제 시작이다. 오늘도 성신의를 함양하며 어엿한 건대인 되기 위해 덕쿠는 모험을 떠난다.")
                                    ]
