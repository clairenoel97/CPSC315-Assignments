//
//  Warrior.swift
//  PA3-Task2
//
//  Created by Norman, Claire on 9/18/18.
//  Copyright © 2018 Norman, Claire. All rights reserved.
//


//DONE
import Foundation

//inherited hero
class Warrior: Hero {
    //extra properties
    var attackBlocked: Bool
    
    //initializer
    override init() {
        self.attackBlocked = false
        super.init()
        self.hp = 25
        self.attackSpeed = 4
        self.chanceYouHitOpponent = 0.80 //represented as 80%
        self.damageRangeMax = 60
        self.damageRangeMin = 35
        self.chanceToBlock = 0.20 //represened as 20%
    }
    
    //gets the name of the character from user
    //sets the name of the character for the rest of the game
    override func setName() -> String {
        print("What is the name of your Warrior?")
        let name = readLine()
        self.name = name!
        return self.name
    }
    
    //this is the special attack
    //only 40% chance of succeeding
    func crushingBlow() -> Int {
        let random = arc4random_uniform(175 - 75) + 75
        return Int(random)
    }
    
    //string representation
    override var description: String {
        return "\(name)"
    }
    
    //this is the attack for the warrior
    //added choices specifically for warrior
    override func attack(opponent: DungeonCharacter) -> Int {
        var addedTurns = 0
        //first: get probability
        var random = Double(arc4random_uniform(100 - 1) + 1)
        random = (random * 0.01) //probability in terms of a decimal
        var hit: Int
        //gets the user input for the type of attack
        let choice = chooseAttack()
        //checks if character is dead
        if !isDead() {
            //if the user chooses the special attack
            if choice == 2 {
                if random <= chanceYouHitOpponent {
                    hit = crushingBlow()
                    print("\t\(name) attacks \(opponent.description)")
                    print("\t\(name) is going to perform a SPECIAL SKILL on \(opponent.description)")
                    print("\t\(name) attacked with a crushing blow of \(hit)\n")
                    opponent.hp -= hit
                    print("\tThat one had to hurt...")
                    //checking to see if the opponent can heal
                    opponent.heal()
                } else {
                    print("\tYour warrior drew their sword, swung, and missed.")
                    print("\tHow could they miss! \(opponent.description) was right there!")
                    hit = 0
                    opponent.hp -= hit
                }
            }
            //if the user chooses the normal attack
            if choice == 1 {
                if random <= chanceYouHitOpponent {
                    hit = Int(arc4random_uniform(UInt32(damageRangeMax - damageRangeMin)) + UInt32(damageRangeMin))
                    print("\t\(name) attacks \(opponent.description)")
                    print("\t\(name) attacked with damage \(hit)")
                    opponent.hp -= hit
                    print("\t\(opponent.description) now has \(opponent.hp) hit points")
                    //check to see if the monster can heal
                    opponent.heal()
                } else {
                    print("\tYour warrior drew their sword, swung, and missed.")
                    print("\tHow could they miss! \(opponent.description) was right there!")
                    hit = 0
                    opponent.hp -= hit
                }
            }
            //if the user wants to quit the game
            if choice == 3{
                print("\tRETREAT!!! Find some shelter to recover and prepare for the next battle")
                exit(0)
            }
        //the player is dead
        } else {
            hit = 0
            print("\tYour Warrior is dead. Attack failed")
        }
        return addedTurns
    }
    
    //this is returns if the warrior was able to block monsters attack
    //if blocked, hp stays the same
    //else warrior looses hp
    override func block() -> Bool{
        var blocked = false //boolean
        var random = Double(arc4random_uniform(100 - 1) + 1) //probability
        random = random * 0.01
        
        //if the player is able to block the attack then continue into the loop
        if random <= chanceToBlock {
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
