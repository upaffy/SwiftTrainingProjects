//
//  Animation.swift
//  SpringAnimationApp
//
//  Created by Pavlentiy on 22.09.2021.
//

struct Animation {
    let name: String
    let force: Double
    let velocity: Double
    let duration: Double
    let damping: Double
    
    static func getRandomAnimation() -> Animation {
        let name = AnimationPreset.allCases.randomElement()
        let force = Double.random(in: 1...2)
        let velocity = Double.random(in: 1...2)
        let duration = Double.random(in: 1...3)
        let damping = Double.random(in: 1...2)
        
        return Animation(
            name: name?.rawValue ?? "wobble",
            force: force,
            velocity: velocity,
            duration: duration,
            damping: damping
        )
    }
    
    enum AnimationPreset: String, CaseIterable {
        case slideLeft
        case slideRight
        case slideDown
        case slideUp
        case squeezeLeft
        case squeezeRight
        case squeezeDown
        case squeezeUp
        case fadeIn
        case fadeOutIn
        case fadeInLeft
        case fadeInRight
        case fadeInDown
        case fadeInUp
        case zoomIn
        case shake
        case pop
        case flipX
        case flipY
        case morph
        case squeeze
        case flash
        case wobble
        case swing
    }
}
