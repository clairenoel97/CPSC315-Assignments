//
//  DungeonCharacter.swift
//  PA3-Task2
//
//  Created by Norman, Claire on 9/18/18.
//  Copyright © 2018 Norman, Claire. All rights reserved.
//

import Foundation

class DungeonCharacter: CustomStringConvertible {
    //properties
    var name: String
    var hp: Int //how much damage can a character take before it dies
    var attackSpeed: Int
    var damageRangeMin: Int
    var damageRangeMax: Int
    var chanceYouHitOpponent: Double
    
    //first initializing values
    //giving them dummy values to test the functionality of the object
    init() {
        self.name = ""
        self.hp = 210 //initialized to only have 210 hp
        self.attackSpeed = 1
        self.damageRangeMin = 1
        self.damageRangeMax = 5
        self.chanceYouHitOpponent = 80.0
    }
    
    //to be implemented in the subclasses
    //this function attacks and takes a parameter of a character
    //the parameter object is the character that is attacked
    func attack(opponent: DungeonCharacter) -> Int {
        let hit: Int
        var turnsAdded = 0
        //if your chance to hit the opponent is met
        //and your character is not dead
        //then you can attack
        if chanceYouHitOpponent > 0 && !isDead() {
            hit = Int(arc4random_uniform(UInt32(damageRangeMax)) + UInt32(damageRangeMin))
            print("\(name) attacked with with damage \(hit)")
            opponent.hp -= hit
            print("\(opponent.description) now has \(opponent.hp) hit points")
            //heal()
        } else {
            hit = 0
            print("Attack failed")
        }
        return turnsAdded
    }
    
    //this checks to see if the character is dead
    //returns a bool
    func isDead() -> Bool {
        if hp <= 0 {
            return true
        } else {
            return false
        }
    }
    
    //string function
    var description: String {
        return ("I am a \(name)")
    }
    
    //asks to get the name of the character
    func getName() -> String{
        print("Please enter the name of your character: ")
        let Hname = readLine()
        self.name = Hname!
        return self.name
    }
    
    //this function allows the monster to heal after being attacked
    func heal() -> Int {
        //assign a chance to heal for the monster
        let random = arc4random_uniform(100 - 1) + 1
        //this is a comparrison of a dummy value
        //ther is a 40 percent chance of healing
        if Double(random) <= 40 {
            let pointsHealed = arc4random_uniform(10 - 1) + 1
            //the points that the monster can heal after attacked
            //if the monster is dead, then the monster cannot be healed
            if hp <= 0 {
                print("\(name) was not able to heal")
                hp = 0
            } else {
                hp += Int(pointsHealed)
                print("\(name) was able to heal \(pointsHealed) hit points")
            }
        }
        return hp
    }

    //checks to see if the character can block the attack from opponent
    func block() -> Bool{
        var blocked = false
        let random = arc4random_uniform(100 - 1) + 1
        if Double(random) <= 0 {
            if hp <= 0 {
                print("Your hero is dead. No use in trying to fight it.")
                blocked = false
            } else {
                print("Your hero was able to block the attack...no damage dealt")
                blocked = true
            }
        } else {
            
        }
        return blocked
    }
}
