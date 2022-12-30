//
//  Entry.swift
//  
//
//  Created by Justin Ackermann on 12/30/22.
//

import UIKit
import SwiftEntryKit

public enum Entry {
    
    case PopUpI
    case PopUpII
    
    public var attributes: EKAttributes {
        switch self {
        case .PopUpI:
            var attributes = EKAttributes.bottomFloat
            attributes.hapticFeedbackType = .success
            attributes.displayDuration = .infinity
            attributes.entryBackground = .color(color: .init(.background))
            attributes.screenBackground = .color(color: .init(UIColor.secondary.withAlphaComponent(0.4)))
            attributes.shadow = .active(
                with: .init(
                    color: .black,
                    opacity: 0.3,
                    radius: 8
                )
            )
            attributes.screenInteraction = .absorbTouches
            attributes.entryInteraction = .absorbTouches
            attributes.scroll = .disabled
            
            attributes.roundCorners = .all(radius: 25)
            attributes.entranceAnimation = .init(
                translate: .init(
                    duration: 0.7,
                    spring: .init(damping: 1, initialVelocity: 0)
                ),
                scale: .init(
                    from: 1.05,
                    to: 1,
                    duration: 0.4,
                    spring: .init(damping: 1, initialVelocity: 0)
                )
            )
            attributes.exitAnimation = .init(
                translate: .init(duration: 0.2)
            )
            attributes.popBehavior = .animated(
                animation: .init(
                    translate: .init(duration: 0.2)
                )
            )
            attributes.positionConstraints.verticalOffset = 10
            attributes.positionConstraints.size = .init(
                width: .offset(value: 20),
                height: .intrinsic
            )
            attributes.positionConstraints.maxSize = .init(
                width: .constant(value: UIScreen.main.minEdge),
                height: .intrinsic
            )
            attributes.statusBar = .dark
            attributes.displayMode = .dark
            attributes.entranceAnimation = .init(
                translate: .init(
                    duration: 0.5,
                    spring: .init(damping: 1, initialVelocity: 0)
                )
            )
            
            attributes.positionConstraints = .fullWidth
            attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
            attributes.roundCorners = .top(radius: 20)
            return attributes
            
        case .PopUpII:
            var attributes = EKAttributes.bottomFloat
            attributes.hapticFeedbackType = .success
            attributes.displayDuration = .infinity
            attributes.entryBackground = .color(color: .init(.background))
            attributes.screenBackground = .color(color: .init(.dimmedLightBackground))
            attributes.shadow = .active(
                with: .init(
                    color: .black,
                    opacity: 0.3,
                    radius: 8
                )
            )
            attributes.screenInteraction = .absorbTouches
            attributes.entryInteraction = .absorbTouches
            attributes.scroll = .enabled(
                swipeable: true,
                pullbackAnimation: .jolt
            )
            attributes.roundCorners = .all(radius: 25)
            attributes.entranceAnimation = .init(
                translate: .init(
                    duration: 0.7,
                    spring: .init(damping: 1, initialVelocity: 0)
                ),
                scale: .init(
                    from: 1.05,
                    to: 1,
                    duration: 0.4,
                    spring: .init(damping: 1, initialVelocity: 0)
                )
            )
            attributes.exitAnimation = .init(
                translate: .init(duration: 0.2)
            )
            attributes.popBehavior = .animated(
                animation: .init(
                    translate: .init(duration: 0.2)
                )
            )
            attributes.positionConstraints.verticalOffset = 10
            attributes.positionConstraints.size = .init(
                width: .offset(value: 20),
                height: .intrinsic
            )
            attributes.positionConstraints.maxSize = .init(
                width: .constant(value: UIScreen.main.minEdge),
                height: .intrinsic
            )
            attributes.statusBar = .dark
            attributes.displayMode = .dark
            attributes.scroll = .disabled
            return attributes
        }
    }
}
