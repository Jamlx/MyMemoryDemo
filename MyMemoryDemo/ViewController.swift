//
//  ViewController.swift
//  MyMemoryDemo
//
//  Created by James Cavanaugh on 12/15/19.
//  Copyright © 2019 James Cavanaugh. All rights reserved.
//

import UIKit

class card {
    var id: Int
    var label: String
    var button: UIButton
    init(id: Int, label: String, button: UIButton){
        self.id = id
        self.label = label
        self.button = button
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var lblMovesMade: UILabel!
    @IBOutlet weak var lblMovesLeft: UILabel!
    @IBOutlet weak var winLoseLabel: UILabel!
    
    var cards = [card]()
    var flipped = [card]()
    var completedPairs: Int = 0
    
    var possibleLabels = ["dog", "dog", "cat", "cat", "bird", "bird", "horse", "horse", "cow", "cow", "pig", "pig", "sheep", "sheep", "goat", "goat", "bull", "bull", "wolf", "wolf"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...20{
            let butt = self.view.viewWithTag(i) as! UIButton
            let getLabel: String = possibleLabels.randomElement()!
            let makeCard: card = card(id: i, label: getLabel, button: butt)
            if let index = possibleLabels.firstIndex(of: getLabel){
                possibleLabels.remove(at: index)
            }
            cards.append(makeCard)
        }
        
        lblMovesLeft.text = "50"
        // Do any additional setup after loading the view.
    }
    
   
   
    @IBAction func btnClick(_ sender: UIButton) {
        
        var newLabel: String
        var image:UIImage
        let tag: Int = sender.tag
        var movesLeft: Int = 0;
        var movesMade: Int = 0;
        
        if(flipped.count==2 && completedPairs < 10){
            if let movesLeftString = lblMovesLeft.text{
                movesLeft = Int(movesLeftString)!
                movesLeft = movesLeft - 1
                lblMovesLeft.text = String(movesLeft)
            }
            
            if let movesString = lblMovesMade.text{
                movesMade = Int(movesString)!
                movesMade = movesMade + 1
                lblMovesMade.text = String(movesMade)
            }
            if(flipped[0].label == flipped[1].label){
                image = UIImage()
                newLabel = ""
                flipped[0].button.setBackgroundImage(image, for: UIControl.State.normal)
                flipped[0].button.setTitle(newLabel, for: UIControl.State.normal)
                flipped[0].button.isEnabled = false
                flipped[1].button.setBackgroundImage(image, for: UIControl.State.normal)
                flipped[1].button.setTitle(newLabel, for: UIControl.State.normal)
                flipped[1].button.isEnabled = false
                completedPairs+=1
            }else{
                image = (UIImage(named: "cute_dog.jpg") as UIImage?)!
                newLabel = ""
                flipped[0].button.setBackgroundImage(image, for: UIControl.State.normal)
                flipped[0].button.setTitle(newLabel, for: UIControl.State.normal)
                flipped[1].button.setBackgroundImage(image, for: UIControl.State.normal)
                flipped[1].button.setTitle(newLabel, for: UIControl.State.normal)
            }
            flipped.removeAll()
            if(movesLeft == 0){
                for card in cards{
                    card.button.isEnabled=false
                    card.button.setTitle("", for: UIControl.State.normal)
                    card.button.setBackgroundImage(UIImage(), for: UIControl.State.normal)
                }
                winLoseLabel.text="Loser!"
            }
        }else if(flipped.count==0 && completedPairs < 10){
                image = UIImage()
                flipped.append(cards[tag-1])
                flipped[0].button.setTitle(flipped[0].label, for: UIControl.State.normal)
                flipped[0].button.setBackgroundImage(image, for: UIControl.State.normal)
        }else if(flipped.count==1 && completedPairs < 10){
            if(flipped[0].id != tag){
                image = UIImage()
                flipped.append(cards[tag-1])
                flipped[1].button.setTitle(flipped[1].label, for: UIControl.State.normal)
                flipped[1].button.setBackgroundImage(image, for: UIControl.State.normal)
            }
        }
        if(completedPairs == 10){
            winLoseLabel.text="Winner!"
        }
    }
}

