//
//  Skeleton.swift
//  PA3-Task2
//
//  Created by Norman, Claire on 9/18/18.
//  Copyright © 2018 Norman, Claire. All rights reserved.
//

import Foundation

//inherited class monster
class Skeleton: Monster {
    
    //initialied values
    override init() {
        super.init()
        self.name = "Benny the Skeleton"
        self.hp = 100
        self.attackSpeed = 3
        self.chanceYouHitOpponent = 0.80 //80%
        self.damageRangeMax = 50
        self.damageRangeMin = 30
        self.chanceToHealAfterAttack = 0.30 //30%
        self.healPointsMin = 30
        self.healPointsMax = 50
    }
    
    override var description: String {
        return "Benny the Skeleton"
    }
    
    //attack function for monster
    //added comments for skeleton
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
            print("\t\(description) tried to stab you with one of his ribs. He missed, but nice try")
            print("\tAttack blocked")
        }
        return turnsAdded
    }
    
    //overidden
    //checks to see if monster can heal
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
                //doesn't allow healing to go over original hp
                hp += Int(pointsHealed)
                if hp > 100 {
                    hp = 100
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
