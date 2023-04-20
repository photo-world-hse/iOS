//
//  Button.swift
//  PhotoWorld
//
//  Created by Stepan Ostapenko on 13.04.2023.
//

import Foundation
import SwiftUI

struct MainButtonStyle: ButtonStyle {

    var backgoundColor: Color
    var textColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(FontScheme.kInterMedium(size: getRelativeHeight(16.0)))
            .padding(.horizontal, getRelativeWidth(30.0))
            .padding(.vertical, getRelativeHeight(15.0))
            .foregroundColor(textColor)
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            .frame(width: getRelativeWidth(343.0),
                   height: getRelativeHeight(48.0), alignment: .center)
            .background(RoundedCorners(topLeft: 8.0, topRight: 8.0,
                                       bottomLeft: 8.0, bottomRight: 8.0)
                            .fill(backgoundColor))
            .padding(.top, getRelativeHeight(0.0))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
