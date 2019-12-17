//
//  ViewController.swift
//  MyMemoryDemo
//
//  Created by James Cavanaugh on 12/15/19.
//  Copyright © 2019 James Cavanaugh. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var model: MemoryBrain = MemoryBrain()
    var buttons = [UIButton]()

    @IBOutlet weak var lblMovesMade: UILabel!
    @IBOutlet weak var lblMovesLeft: UILabel!
    @IBOutlet weak var winLoseLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...20{
            let butt = self.view.viewWithTag(i) as! UIButton
            buttons.append(butt)
        }
        lblMovesLeft.text = "70"
    }
   
    
    func updateView(_ changes: Changes){
        var newLabel: String
        var image: UIImage
        
        lblMovesLeft.text = String(changes.movesLeft)
        lblMovesMade.text = String(changes.movesMade)
        
        if(changes.status != "cont"){
            image = UIImage()
            newLabel = ""
            for btn in buttons{
                btn.setTitle(newLabel, for: UIControl.State.normal)
                btn.setBackgroundImage(image, for: UIControl.State.normal)
                btn.isEnabled = false
            }
            if(changes.status == "win"){
                winLoseLabel.text = "Winner!"
            }else if(changes.status == "lose"){
                winLoseLabel.text = "Loser!"
            }
            
        }
        
        if(changes.toImage.count != 0 ){
            image = (UIImage(named: "cute_dog.jpg") as UIImage?)!
            newLabel = ""
            for card in changes.toImage{
                buttons[card.id-1].setTitle(newLabel, for: UIControl.State.normal)
                buttons[card.id-1].setBackgroundImage(image, for: UIControl.State.normal)
                
            }
        }
        
        if(changes.toLabel.count != 0){
            image = UIImage()
            for card in changes.toLabel{
                buttons[card.id-1].setTitle(card.label, for: UIControl.State.normal)
                buttons[card.id-1].setBackgroundImage(image, for: UIControl.State.normal)
                
            }
        }
        
        if(changes.toRemove.count != 0){
            image = UIImage()
            newLabel = ""
            for card in changes.toRemove{
                let seconds = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.buttons[card.id-1].setTitle(newLabel, for: UIControl.State.normal)
                    self.buttons[card.id-1].setBackgroundImage(image, for: UIControl.State.normal)
                    self.buttons[card.id-1].isEnabled = false
                }

            }
        }

    }
    
    @IBAction func btnClick(_ sender: UIButton) {
        let movesLeft = Int(lblMovesLeft.text!)!
        let movesMade = Int(lblMovesMade.text!)!
        let tag = Int(sender.tag)
        let changes: Changes = model.btnClick(tag, movesLeft, movesMade)
        updateView(changes)
    }
}

