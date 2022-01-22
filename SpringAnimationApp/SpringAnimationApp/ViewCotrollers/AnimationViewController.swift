//
//  ViewController.swift
//  SpringAnimationApp
//
//  Created by Pavlentiy on 22.09.2021.
//

import Spring

class AnimationViewController: UIViewController {
    
    @IBOutlet var animationLabel: UILabel!
    @IBOutlet var forceLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var dampingLabel: UILabel!
    @IBOutlet var velocityLabel: UILabel!

    @IBOutlet var repeatButton: UIButton!
    @IBOutlet var runButton: UIButton!
    
    @IBOutlet var animatedView: SpringView!
    
    private var previousAnimation: Animation = Animation.getRandomAnimation()
    private var nextAnimation: Animation = Animation.getRandomAnimation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animatedView.layer.cornerRadius = 10
        runButton.layer.cornerRadius = 5
        repeatButton.layer.cornerRadius = 5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        apply(previousAnimation)
        changeButtonsTitles()
    }
    
    @IBAction func runButtonPressed() {
        apply(nextAnimation)
        changeAnimations()
        changeButtonsTitles()
    }
    
    @IBAction func repeatButtonPressed() {
        showView(with: previousAnimation)
    }
    
    private func showView(with animation: Animation) {
        animatedView.animation = animation.name
        animatedView.force = CGFloat(animation.force)
        animatedView.velocity = CGFloat(animation.velocity)
        animatedView.duration = CGFloat(animation.duration)
        animatedView.damping = CGFloat(animation.damping)
        
        animatedView.animate()
    }
    
    private func changeViewLabels(dueTo animation: Animation) {
        animationLabel.text = "Animation: \(animation.name)"
        forceLabel.text = String(format: "Force: %.2f", animation.force)
        durationLabel.text = String(format: "Duration: %.2f", animation.duration)
        dampingLabel.text = String(format: "Damping: %.2f", animation.damping)
        velocityLabel.text = String(format: "Velocity: %.2f", animation.velocity)
    }
    
    private func apply(_ animation: Animation) {
        changeViewLabels(dueTo: animation)
        showView(with: animation)
    }
    
    private func changeAnimations() {
        previousAnimation = nextAnimation
        nextAnimation = Animation.getRandomAnimation()
    }
    
    private func changeButtonsTitles() {
        runButton.setTitle("Run \(nextAnimation.name)", for: .normal)
        repeatButton.setTitle("Repeat \(previousAnimation.name)", for: .normal)
    }
}

