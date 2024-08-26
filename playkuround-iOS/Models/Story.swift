//
//  Story.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 7/15/24.
//

import SwiftUI

struct Story {
    let number: Int
    let image: String
    let title: String
    let description: String
    var isLocked: Bool = true
    var isNew: Bool = false
}

let storyList: [Story] = [Story(number: 1,
                                image: "storyImage1",
                                title: "덕쿠의 꿈",
                                description:  "일감호에 사는 INFP 소심한 오리 덕쿠. 오늘도 캠퍼스와 학생들을 바라보며 상상을 한다. \"학교를 다니는 건 어떤 기분일까?\" \"나도 건국대학교 학생이고 싶어!\""),
                          Story(number: 2,
                                image: "storyImage2",
                                title: "소원을 들어줘",
                                description: "어느날 잠에 들어 꿈을 꾸는데... 유석창 박사님 동상이 이야기를 한다..!.. \"건국대학교의 학생이 되고싶다면.. 성신의를 찾아라...\" \"헉! 성신의라고 불리는 보물을 찾아오면 내 소원을 들어주겠다고?!\""),
                          Story(number: 3,
                                image: "storyImage3",
                                title: "모험가 덕쿠",
                                description: "퍼뜩 깨어난 덕쿠, \"성신의? 까짓거 찾아주겠어.\" 건대생을 꿈꾸며 보물 성신의를 찾기 위해 캠퍼스를 돌아다니며 열심히 모험을 떠난다."),
                          Story(number: 4,
                                image: "storyImage4",
                                title: "보물이 없어",
                                description: "건국대학교 캠퍼스를 전부 돌아다니며 산전수전을 겪은 덕쿠... 하지만.. 아무리 찾아봐도 성신의는 없다...\"도대체 성신의란 보물은 어디있는거지?! 아니 애초에 어떻게 생긴거지?!?!?\""),
                          Story(number: 5,
                                image: "storyImage5",
                                title: "성신의의 진실",
                                description: "\"설마..!\" 덕쿠는 성신의는 물질적인 것이 아니라 모험하는 과정에서 얻을 수 있는 내적인 가치라는 것을 깨달았다."),
                          Story(number: 6,
                                image: "storyImage6",
                                title: "모험의 시작",
                                description: "덕쿠의 건국대학교 학생이 되기위한 모험은 이제 시작이다. 오늘도 성신의를 함양하며 어엿한 건대인 되기 위해 덕쿠는 모험을 떠난다.")
]

let storyListEnglish: [Story] = [Story(number: 1,
                                       image: "storyImage1",
                                       title: "Duckoo's Dream",
                                       description: "Ducku is a timid duck who lives on a lake. Even today, he looks at the campus and students and imagines. \"I wonder what it's like to go to school?\" \"I want to be a student at Konkuk University!\""),
                                 Story(number: 2,
                                       image: "storyImage2",
                                       title: "Make a Wish",
                                       description: "I go to sleep and dream a dream... The statue of Dr. Yoo Seok Chang talks to you.... \"If you want to become a student of Konkuk University... find 'Sung Shin Ui'...\" \"Hmph, if I find the treasure called 'Sung Shin Ui', you'll grant my wish?!\""),
                                 Story(number: 3,
                                       image: "storyImage3",
                                       title: "Ducku the Adventurer",
                                       description: "Ducku wakes up with a start, \"'Sung Shin Ui'? I'll find it.\" He dreams of being a university student, and eagerly adventures around campus in search of the treasure Sung Shin Ui."),
                                 Story(number: 4,
                                       image: "storyImage4",
                                       title: "There is no treasure",
                                       description: "I've been all over the campus of Konkuk University, and I've been through a lot... But... No matter how much I looked, there is no 'Sung Shin Ui'...\"Where the hell is the treasure called ‘Sung Shin Ui\"?!"),
                                 Story(number: 5,
                                       image: "storyImage5",
                                       title: "The Truth About Sung Shin Ui",
                                       description: "\"No way...!\" Ducku realized that 'Sung Shin Ui' is not a material thing, but an inner value that can be gained in the process of adventure."),
                                 Story(number: 6,
                                       image: "storyImage6",
                                       title: "The Adventure Begins",
                                       description: "Ducku's adventure to become a student at Konkuk University has just begun. Today, Ducku continues his adventure to cultivate 'Sung Shin Ui' and become the best KU student he can be.")
]

let storyListChinese: [Story] = [Story(number: 1,
                                       image: "storyImage1",
                                       title: "鸭子梦",
                                       description:  "\"上学是什么感觉?\" \"我也想成为建国大学的学生!\""),
                                 Story(number: 2,
                                       image: "storyImage2",
                                       title: "许愿",
                                       description: "鸭子做梦. \"找到建国大学的宝物就能变成人?\""),
                                 Story(number: 3,
                                       image: "storyImage3",
                                       title: "探险家鸭子",
                                       description: "梦醒的鸭子, 为了成为建国大学的学生开始学校探险"),
                                 Story(number: 4,
                                       image: "storyImage4",
                                       title: "失传的宝物",
                                       description: "走遍建国大学校园, 饱经风霜的鸭子... 但是. 怎么找也没有宝物..."),
                                 Story(number: 5,
                                       image: "storyImage5",
                                       title: "宝藏的真实",
                                       description: "鸭子意识到宝物不是物质上的, 而是冒险过程中可以获得的内在价值. "),
                                 Story(number: 6,
                                       image: "storyImage6",
                                       title: "冒险的开始",
                                       description: "鸭子成为建国大学学生的冒险才刚刚开始. 今天也为了培养宝物, 成为堂堂建国大学的学生, 鸭子去冒险.")
]
