//
//  Pie.swift
//  Memorize
//
//  Created by Nicola Mastrandrea on 05/06/21.
//

import SwiftUI

struct Pie: Shape{
    var startAngle: Angle
    var endAngle: Angle
    var clockWise: Bool = false
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius: CGFloat = min(rect.height,rect.width) / 2
        let start = CGPoint(x:center.x + cos(CGFloat(startAngle.radians)),y: center.y + sin(CGFloat(startAngle.radians)))

        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockWise )
        p.addLine(to: center)
        return p
    }
}
