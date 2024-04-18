//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors.
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

@main
struct Main {
    static func main() {
        var board = STM32F746Board()

        let blink = {
            board.ledOn()
            board.delay(milliseconds: 10)
            board.ledOff()
            board.delay(milliseconds: 20)
        }
        
        board.delay(milliseconds: 10)
        
        let maxLogoPosition = Point(x: board.displaySize.width - board.logoLayerSize.width, y: board.displaySize.height - board.logoLayerSize.height)
        
        var logoPosition = Point(x: 100, y: 0)
        board.moveLogo(to: logoPosition)

        var logoDelta = Point(x: 1, y: 1)
        
        var iteration = 0
        
        while true {
            board.delay(milliseconds: 10)
            
            logoPosition = logoPosition.offset(by: logoDelta)
            board.moveLogo(to: logoPosition)
            
            if logoPosition.x <= 0 || logoPosition.x >= maxLogoPosition.x  { logoDelta.x *= -1 }
            if logoPosition.y <= 0 || logoPosition.y >= maxLogoPosition.y { logoDelta.y *= -1 }
            
            if iteration % 16 == 0 { blink() }
            
            let backgroundGray: Int
            if iteration % 512 < 256 {
                backgroundGray = iteration % 256
            } else if iteration % 512 == 256 {
                backgroundGray = 255
            } else {
                backgroundGray = (512 - (iteration % 512)) % 256
            }
            board.setBackgroundColor(color: Color(r: backgroundGray, g: backgroundGray, b: backgroundGray))
            
            iteration += 1
        }
    }
}
