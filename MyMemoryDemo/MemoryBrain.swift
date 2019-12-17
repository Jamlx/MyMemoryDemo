//
//  MemoryBrain.swift
//  MyMemoryDemo
//
//  Created by James Cavanaugh on 12/16/19.
//  Copyright © 2019 James Cavanaugh. All rights reserved.
//

import Foundation
import UIKit

class Changes{
    var toImage = [Card]()
    var toLabel = [Card]()
    var toRemove = [Card]()
    var movesLeft: Int
    var movesMade: Int
    var status: String
    
    init(toImage: [Card], toLabel: [Card], toRemove: [Card], movesLeft: Int, movesMade: Int, status: String){
        self.toImage = toImage
        self.toLabel = toLabel
        self.toRemove = toRemove
        self.movesLeft = movesLeft
        self.movesMade = movesMade
        self.status = status
    }
}


class MemoryBrain{
    
    var cards = [Card]()
    var flipped = [Card]()
    var flippedOld = [Card]()
    var completedPairs: Int = 0
    
    var possibleLabels = ["dog", "dog", "cat", "cat", "bird", "bird", "horse", "horse", "cow", "cow", "pig", "pig", "sheep", "sheep", "goat", "goat", "bull", "bull", "wolf", "wolf"]
    
    init(){
        for i in 1...20{
            let getLabel: String = possibleLabels.randomElement()!
            let makeCard: Card = Card(id: i, label: getLabel)
            if let index = possibleLabels.firstIndex(of: getLabel){
                possibleLabels.remove(at: index)
            }
            cards.append(makeCard)
        }
    }
    
    func isSecond()->Bool{
        if(flipped.count<2){
            return false
        }else{
            return true
        }
    }
    
    func isMatch()->Bool{
        if((flipped[0].label == flipped[1].label) && (flipped[0].id != flipped[1].id)){
            return true
        }else{
            return false
        }
    }
    
    func btnClick(_ tag: Int, _ movesLeft: Int, _ movesMade: Int)->Changes{
        let emptyCard = [Card]()
        var match: Bool
        flipped.append(cards[tag-1])
        let second: Bool = isSecond()
        var changes: Changes
        
        if(second == true){
            match = isMatch()
        }else{
            match = false
            changes = Changes(toImage: flippedOld, toLabel: [cards[tag-1]], toRemove: emptyCard, movesLeft: movesLeft - 1, movesMade: movesMade + 1, status: "cont")
            flippedOld.removeAll()
            return changes
        }
        if(match){
            completedPairs+=1
            if(completedPairs == 10){
                changes = Changes(toImage: emptyCard, toLabel: [cards[tag-1]], toRemove: flipped, movesLeft: movesLeft - 1, movesMade: movesMade + 1, status: "win")

            }else{
                changes = Changes(toImage: emptyCard, toLabel: [cards[tag-1]], toRemove: flipped, movesLeft: movesLeft - 1, movesMade: movesMade + 1, status: "cont")
            }
        }else{
            if(movesLeft - 1 == 0){
                changes = Changes(toImage: emptyCard, toLabel: [cards[tag-1]], toRemove: emptyCard, movesLeft: movesLeft - 1, movesMade: movesMade + 1, status: "lose")
            }else{
                changes = Changes(toImage: emptyCard, toLabel: [cards[tag-1]], toRemove: emptyCard, movesLeft: movesLeft - 1, movesMade: movesMade + 1, status: "cont")
            }
        }
        flippedOld = flipped
        flipped.removeAll()
        return changes
    }
    
}
