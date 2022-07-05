//
//  ViewController.swift
//  swipeApp
//
//  Created by Kazuki Omori on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var basicCard: UIView!
    @IBOutlet weak var likeImageView: UIImageView!
    
    @IBOutlet weak var person1: UIView!
    @IBOutlet weak var person2: UIView!
    @IBOutlet weak var person3: UIView!
    @IBOutlet weak var person4: UIView!
    
    var centerOfCard: CGPoint!
    var people = [UIView]()
    
    var selectedCardCount = 0
    
    let name = ["ほのか","あかね","みほ","カルロス"]
    var likedName = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerOfCard = basicCard.center
        people.append(person1)
        people.append(person2)
        people.append(person3)
        people.append(person4)
        // Do any additional setup after loading the view.
    }
    
    func resetCard() {
        basicCard.center = self.centerOfCard
        basicCard.transform = .identity
    }

    @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        people[selectedCardCount].center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        
        let xFromCenter = card.center.x - view.center.x
        
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width / 2) * -0.785)
        people[selectedCardCount].transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width / 2) * -0.785)
        
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
                    self.resetCard()
                    self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x - 250, y: self.people[self.selectedCardCount].center.y)
                }
                selectedCardCount += 1
                likeImageView.alpha = 0
                return
            } else if card.center.x > view.frame.width - 70 {
                UIView.animate(withDuration: 0.2) {
                    self.resetCard()
                    self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x + 250, y: self.people[self.selectedCardCount].center.y)
                }
                likedName.append(name[selectedCardCount])
                selectedCardCount += 1
                likeImageView.alpha = 0
                return
            }
            
            
            UIView.animate(withDuration: 0.2, animations:{
                self.resetCard()
                self.people[self.selectedCardCount].center = self.centerOfCard
                self.people[self.selectedCardCount].transform = .identity
            })
            likeImageView.alpha = 0
        }
    }
    
}

