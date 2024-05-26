//
//  CatchGameViewModel.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/23/24.
//

import Foundation

final class CatchGameViewModel: GameViewModel {
    @Published var windowList: [WindowComponent] = [WindowComponent(windowState: .half, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .half, windowType: .catchDuckkuWhiteHit),
                                                    WindowComponent(windowState: .half, windowType: .catchDuckkuBlack),
                                                    WindowComponent(windowState: .half, windowType: .catchDuckkuBlackHit),
                                                    WindowComponent(windowState: .open, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .open, windowType: .catchDuckkuWhiteHit),
                                                    WindowComponent(windowState: .open, windowType: .catchDuckkuBlack),
                                                    WindowComponent(windowState: .open, windowType: .catchDuckkuBlackHit),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),]
}
