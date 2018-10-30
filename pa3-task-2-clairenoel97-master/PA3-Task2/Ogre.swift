//
//  File.swift
//  PA3-Task2
//
//  Created by Norman, Claire on 9/18/18.
//  Copyright © 2018 Norman, Claire. All rights reserved.
//

import Foundation

//class for inheritance
class Ogre: Monster {
    //initialized values
    override init() {
        super.init()
        self.name = "Shrek the Ogre"
        self.hp = 200
        self.attackSpeed = 2
        self.chanceYouHitOpponent = 0.60 //60%
        self.damageRangeMax = 60
        self.damageRangeMin = 30
        self.chanceToHealAfterAttack = 0.10 //10%
        self.healPointsMin = 30
        self.healPointsMax = 60
    }
    
    override var description: String {
        return "Shrek the Ogre"
    }
    
    //attack function inherited for the monsters
    //only difference is the statements that are printed
    override func attack(opponent: DungeonCharacter) -> Int {
        var turnsAdded = 0
        var random = Double(arc4random_uniform(100-1) + 1)
        random = random * 0.01
        var hit: Int
        if random <= chanceYouHitOpponent {
            hit = Int(arc4random_uniform(UInt32(damageRangeMax - damageRangeMin)) + UInt32(damageRangeMin))
            print("\t\(description) attacks \(opponent.name)")
            print("\t\(description) attacked with damage \(hit)")
            opponent.hp -= hit
            if opponent.block() {
                opponent.hp += hit
            }
            print("\t\(opponent.name) now has \(opponent.hp) hit points")
        } else {
            print("\t\(description) tried to hit you with a log, but he just threw a twig... intimidating")
            print("\tAttack blocked")
        }
        return turnsAdded
    }
    
    //inherited from monster
    //determines whether or not the monster will heal after the attack
    override func heal() -> Int {
        //assign a chance to heal for the monster
        var random = Double(arc4random_uniform(100 - 1) + 1)
        random = random * 0.01
        if random <= chanceToHealAfterAttack {
            let pointsHealed = arc4random_uniform(UInt32(healPointsMax - healPointsMin)) + UInt32(healPointsMin)
            //the points that the monster can heal after attacked
            //if the monster is dead, then the monster cannot be healed
            if hp <= 0 {
                print("\t\(description) was not able to heal\n")
                hp = 0
                return hp
            } else {
                //doesn't allow monster to heal over the original hp
                hp += Int(pointsHealed)
                if hp > 200 {
                    hp = 200
                }
                print("\t\(description) was able to heal to \(hp)\n")
                return hp
            }
        } else {
            print("\t\(description) was not able to heal\n")
            return hp
        }
    }
}
