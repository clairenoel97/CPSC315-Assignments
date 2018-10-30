//
//  Sorceress.swift
//  PA3-Task2
//
//  Created by Norman, Claire on 9/18/18.
//  Copyright © 2018 Norman, Claire. All rights reserved.
//

import Foundation

//inherited hero
class Sorceress: Hero {
    
    //overriding initializer
    override init() {
        super.init()
        self.hp = 75
        self.attackSpeed = 6
        self.chanceYouHitOpponent = 0.80 //this is 80%
        self.damageRangeMax = 40
        self.damageRangeMin = 20
        self.chanceToBlock = 0.40 //this is 40%
    }
    
    //asking the user for the name
    override func setName() -> String {
        print("What is the name of your Sorceress?")
        let name = readLine()
        self.name = name!
        return self.name
    }
    
    //special attack is to heal
    override func heal() -> Int {
        //hero can heal anywhere from 1 to 50 hp
        let random = arc4random_uniform(50) + 1
        hp += Int(random)
        //doesn't allow hero to heal over given hp
        if hp > 75 {
            hp = 75
        }
        print("\t\(name) activates their healing properties.")
        print("\t\(name) has healed \(random) and now has \(hp) hit points")
        print("\tNo attack was made")
        let temp = hp
        return temp
    }
    
    //put able to block function here
    override func attack(opponent: DungeonCharacter) -> Int{
        var turnsAdded = 0
        //first: get probability
        var random = Double(arc4random_uniform(100 - 1) + 1)
        random = random * 0.01
        var hit: Int
        //user chooses attack
        let choice = chooseAttack()
        if !isDead() {
            //special attack
            if choice == 2 {
                //chance to heal
                //since not given a specific range for heal points, im assigning a range from 1 - 50
                heal()
            }
            //normal attack
            if choice == 1 {
                if random <= chanceYouHitOpponent {
                    hit = Int(arc4random_uniform(UInt32(damageRangeMax - damageRangeMin)) + UInt32(damageRangeMin))
                    print("\t\(name) attacks \(opponent.description)")
                    print("\t\(name) attacked with damage \(hit)")
                    opponent.hp -= hit
                    print("\t\(opponent.name) now has \(opponent.hp) hit points")
                    //check to see if the opponent can heal
                    opponent.heal()
                } else {
                    print("\tYour sorceress conjured a sphere of fire, aimed, and dropped it on the ground.")
                    print("\tHow could they miss! \(opponent.description) was right there!")
                    hit = 0
                    opponent.hp -= hit
                }
            }
            //quit game
            if choice == 3{
                print("\tYou are to weak to continue. Now use your magic to dissapear and recover")
                exit(0)
            }
        } else {
            hit = 0
            print("\tYour Sorceress is dead. Attack failed")
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
