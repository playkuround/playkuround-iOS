//
//  LeadingFlexBox.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 8/20/24.
//

import SwiftUI

// 출처: https://velog.io/@comdongsam/SwiftUI-Layout-실전-가운데-정렬-Flex-Wrap-만들기
struct LeadingFlexBox: Layout {
    private var horizontalSpacing: CGFloat
    private var verticalSpacing: CGFloat
    
    public init(horizontalSpacing: CGFloat, verticalSpacing: CGFloat) {
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
    }
    
    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) -> CGSize {
        // subview가 없으면 .zero를 리턴
        guard !subviews.isEmpty else { return .zero }

        // subview들의 높이 중에서 최대값을 구한다.
        let height = subviews.map { $0.sizeThatFits(proposal).height }.max() ?? 0

        // 너비 중에서 최대값을 구하는 과정
        var rowWidths = [CGFloat]() // 각 row의 너비들
        var currentRowWidth: CGFloat = 0 // 현재 너비
        // 모든 subview를 순회하면서 너비를 구한다.
        subviews.forEach { subview in
            // 현재 너비에 subview의 너비를 더했을 때 부모 view 보다 큰 경우 -> 줄 바꿈
            if currentRowWidth + horizontalSpacing + subview.sizeThatFits(proposal).width >= proposal.width ?? 0 {
                rowWidths.append(currentRowWidth) // 현재까지의 너비 기록하고
                currentRowWidth = subview.sizeThatFits(proposal).width // 현재 subview부터 다시 너비 측정
            // 줄바꾸지 않고 너비 누적
            } else {
                currentRowWidth += horizontalSpacing + subview.sizeThatFits(proposal).width
            }
        }
        // 남은 currentRowWidth 배열에 넣기
        rowWidths.append(currentRowWidth)

        let rowCount = CGFloat(rowWidths.count)
        // 너비: row의 너비 중에 가장 큰 값
        // 높이: subview의 높이 * row의 갯수 + 수직 간격 * (row의 갯수 - 1)
        return CGSize(width: max(rowWidths.max() ?? 0, proposal.width ?? 0), height: rowCount * height + (rowCount - 1) * verticalSpacing)
    }
    
    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        
        let height = subviews.map { $0.dimensions(in: proposal).height }.max() ?? 0
        guard !subviews.isEmpty else { return }
        // 일단 y좌표 최상단에서 시작
        var y = bounds.minY
        
        // 한 row에 들어갈 subview들을 임시 저장하는 배열
        var row = [LayoutSubviews.Element]()
        var rowWidth: CGFloat = 0 // 현재 row의 길이
        
        // subview 순회
        for subview in subviews {
            // 아직 한 row의 길이가 다 안차면 row에 넣고 continue
            if rowWidth + subview.dimensions(in: proposal).width < bounds.width {
                row.append(subview)
                rowWidth += subview.dimensions(in: proposal).width + horizontalSpacing
                continue
            }
            
            // 한 row가 다 차면 일단 지금 있는 줄 place 시작한다.
            rowWidth -= horizontalSpacing // 마지막 horizontalSpacing 하나는 빼준다
            
            // topLeading 기준 x축 출발점
            var x = bounds.minX + (bounds.width - rowWidth) / 2
            
            // row에 저장되어 있는 것 배열 시작
            for sv in row {
                sv.place(
                    at: CGPoint(x: x, y: y),
                    anchor: .topLeading,
                    proposal: ProposedViewSize(
                        width: sv.dimensions(in: proposal).width,
                        height: sv.dimensions(in: proposal).height
                    )
                )
                x += sv.dimensions(in: proposal).width + horizontalSpacing
            }
            
            // 임시 배열 및 길이 초기화
            row = []
            rowWidth = 0
            
            // 줄바꿈
            y += height + verticalSpacing
            
            // 새로운 row 시작
            row.append(subview)
            rowWidth += subview.dimensions(in: proposal).width + horizontalSpacing
        }
        
        // 반복문 내에서 place 되지 않은 row 배열
        rowWidth -= horizontalSpacing
        var x = bounds.minX + (bounds.width - rowWidth) / 2
        
        for sv in row {
            sv.place(
                at: CGPoint(x: x, y: y),
                anchor: .topLeading,
                proposal: ProposedViewSize(
                    width: sv.dimensions(in: proposal).width,
                    height: sv.dimensions(in: proposal).height
                )
            )
            x += sv.dimensions(in: proposal).width + horizontalSpacing
        }
    }
}
