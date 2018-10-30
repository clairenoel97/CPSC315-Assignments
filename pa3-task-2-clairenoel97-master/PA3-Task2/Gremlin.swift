//
//  Gremlin.swift
//  PA3-Task2
//
//  Created by Norman, Claire on 9/18/18.
//  Copyright © 2018 Norman, Claire. All rights reserved.
//

import Foundation

//inheritance from monster
class Gremlin:Monster {
    
    //initialized values
    override init() {
        super.init()
        self.name = "Tony the Gremlin"
        self.hp = 70
        self.attackSpeed = 5
        self.chanceYouHitOpponent = 0.80//80%
        self.damageRangeMax = 30
        self.damageRangeMin = 15
        self.chanceToHealAfterAttack = 0.40 //40%
        self.healPointsMin = 20
        self.healPointsMax = 40
    }
    
    override var description: String {
        return "Tony the Gremlin"
    }
    
    //overridden
    //attack specialised to gremlin
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
            print("\t\(description) tried to nibble on your toes, but you kicked them away.")
            print("\tAttack blocked")
        }
        return turnsAdded
    }
    
    //overridden heal function
    //tests to see if the monster can heal after attack
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
                //makes sure that the gremlin cannot heal over original hp
                hp += Int(pointsHealed)
                if hp > 70 {
                    hp = 70
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
