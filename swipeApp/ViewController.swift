//
//  ViewController.swift
//  swipeApp
//
//  Created by Kazuki Omori on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {
    
    var centerOfCard: CGPoint!

    @IBOutlet weak var basicCard: UIView!
    @IBOutlet weak var likeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerOfCard = basicCard.center
        // Do any additional setup after loading the view.
    }

    @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        
        let xFromCenter = card.center.x - view.center.x
        
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width / 2) * -0.785)
        
        if xFromCenter > 0 {
            likeImageView.image = #imageLiteral(resourceName: "good.png")
            likeImageView.alpha = 1
            likeImageView.tintColor = UIColor.red
        } else if xFromCenter < 0 {
            likeImageView.image = #imageLiteral(resourceName: "bad")
            likeImageView.alpha = 1
            likeImageView.tintColor = UIColor.blue
        }
        
        if sender.state == UIGestureRecognizer.State.ended {
            
            if card.center.x < 70 {
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: card.center.x - 250, y: card.center.y)
                }
                return
            } else if card.center.x > view.frame.width - 70 {
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: card.center.x + 250, y: card.center.y)
                }
                return
            }
            
            
            UIView.animate(withDuration: 0.2, animations:{
                card.center = self.centerOfCard
                card.transform = .identity
            })
            likeImageView.alpha = 0
        }
    }
    
}

