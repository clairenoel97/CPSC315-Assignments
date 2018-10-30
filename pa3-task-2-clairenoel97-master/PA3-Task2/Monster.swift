//
//  Monster.swift
//  PA3-Task2
//
//  Created by Norman, Claire on 9/18/18.
//  Copyright © 2018 Norman, Claire. All rights reserved.
//

import Foundation

//inherited from Dungeon Character
class Monster: DungeonCharacter {
    //properties
    var chanceToHealAfterAttack: Double //checked in the hero attack function
    var healPointsMax: Int
    var healPointsMin: Int
    
    //initializing dummy values that will be overidden by child classes
    override init() {
        self.chanceToHealAfterAttack = 0.20
        self.healPointsMax = 10
        self.healPointsMin = 1
        super.init()
    }
    
    //this function allows the monster to heal after being attacked
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
                hp += Int(pointsHealed)
                print("\t\(description) was able to heal to \(hp)\n")
                return hp
            }
        } else {
            print("\t\(description) was not able to heal\n")
            return hp
        }
    }
    
    override var description: String {
        return "Monster the Monster"
    }
    
    //general attack towards hero
    //all monsters attack the same
    override func attack(opponent: DungeonCharacter) -> Int {
        var turnsAdded = 0
        var random = Double(arc4random_uniform(100-1) + 1)
        random = random * 0.01
        var hit: Int
        //while monster isn't dead, continue
        if !isDead() {
            if random <= chanceYouHitOpponent {
                hit = Int(arc4random_uniform(UInt32(damageRangeMax - damageRangeMin)) + UInt32(damageRangeMin))
                print("\(description) attacked with damage \(hit)")
                opponent.hp -= hit
                if opponent.block() {
                    opponent.hp += hit
                }
                print("\(opponent.name) now has \(opponent.hp) hit points")
            }
        } else {
            print("you dead")
        }
        return turnsAdded
    }
    
}
