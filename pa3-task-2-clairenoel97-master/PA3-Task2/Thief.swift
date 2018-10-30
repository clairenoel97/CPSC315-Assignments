//
//  Thief.swift
//  PA3-Task2
//
//  Created by Norman, Claire on 9/18/18.
//  Copyright © 2018 Norman, Claire. All rights reserved.
//

import Foundation

//inherited from hero
class Thief: Hero {
    
    //initialized values
    override init() {
        super.init()
        self.hp = 75
        self.attackSpeed = 6
        self.chanceYouHitOpponent = 0.80 //80%
        self.damageRangeMax = 40
        self.damageRangeMin = 20
        self.chanceToBlock = 0.40 //40%
    }

    //gets the name from the user
    //name is returned
    override func setName() -> String {
        print("What is the name of your Thief?")
        let name = readLine()
        self.name = name!
        return self.name
    }
    
    //attack for theif
    //goes through all possibilities
    override func attack(opponent: DungeonCharacter) -> Int{
        var turnsAdded = 0
        var random = Double(arc4random_uniform(100 - 1) + 1)
        random *= 0.01
        var hit: Int
        //allows user to choose the type of attack
        let choose = chooseAttack()
        //if the theif is not dead
        if !isDead() {
            //if they choose normal attack
            if choose == 1 {
                if random <= chanceYouHitOpponent {
                    hit = Int(arc4random_uniform(UInt32(damageRangeMax - damageRangeMin)) + UInt32(damageRangeMin))
                    print("\t\(name) attacks \(opponent.description)")
                    print("\t\(name) attacked with damage \(hit)")
                    opponent.hp -= hit
                    print("\t\(opponent.description) now has \(opponent.hp) hit points")
                    opponent.heal()
                } else {
                    print("\tAre you serious! \(name) completely missed!")
                    hit = 0
                    opponent.hp -= hit
                }
            }
            //if they choose special attack
            if choose == 2 {
                //40% that the special attack works
                if random <= 0.40 {
                    print("\t\(name) is going to perform a SURPRISE ATTACK!")
                    print("\tA surprise attack is a normal attack plus an extra turn in the round")
                    hit = Int(arc4random_uniform(UInt32(damageRangeMax - damageRangeMin)) + UInt32(damageRangeMin))
                    print("\t\(name) attacked with damage \(hit)")
                    opponent.hp -= hit
                    print("\t\(opponent.description) now has \(opponent.hp) hit points")
                    opponent.heal()
                    turnsAdded += 1
                    
                }
                    //20% that the special attack doesn't work
                else if random > 0.40 && random <= 0.60 {
                    print("\t\(name) is going to perform a SURPRISE ATTACK!")
                    print("\tSUPRISE ATTACK FAILED. Your thief was caught...")
                    print("\tNo damage dealt to \(opponent.description)\n")
                    hit = 0
                    opponent.hp -= hit
                    turnsAdded = 0
                    //40% that it is just a normal attack
                } else {
                    hit = Int(arc4random_uniform(UInt32(damageRangeMax - damageRangeMin)) + UInt32(damageRangeMin))
                    print("\tSuprise attack attempted.")
                    print("\t\(name) was not sneaky enough. Preceded to attack normally")
                    print("\t\(name) attacks \(opponent.description)")
                    print("\t\(name) attacked with damage \(hit)")
                    opponent.hp -= hit
                    print("\t\(opponent.description) now has \(opponent.hp) hit points")
                    opponent.heal()
                    turnsAdded = 0
                }
            }
            //allows the hero to quit the whole game
            if choose == 3 {
                print("\tI guess you are retreating!")
                exit(0)
            }
        }
        return turnsAdded
    }
    
    //this is returns if the warrior was able to block monsters attack
    //if blocked, hp stays the same
    //else warrior looses hp
    override func block() -> Bool{
        var blocked = false
        var random = Double(arc4random_uniform(100 - 1) + 1) //probability
        random = random * 0.01
        if Double(random) <= chanceToBlock {
            //hero already dead
            if hp <= 0 {
                print("\tBlock attempted...")
                print("\tYour hero is dead. No use in trying to fight it.")
                blocked = false
                //hero was able to block the attack
            } else {
                print("\tYour hero was able to block the attack...no damage dealt")
                blocked = true
            }
            //the hero was not able to block
        } else {
            print("\tYour hero tried to block the attack, but fell on their face...embarrassing")
            blocked = false
        }
        return blocked
    }
}
