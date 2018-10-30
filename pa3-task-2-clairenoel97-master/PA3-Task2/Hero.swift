//
//  Hero.swift
//  PA3-Task2
//
//  Created by Norman, Claire on 9/18/18.
//  Copyright © 2018 Norman, Claire. All rights reserved.
//

import Foundation

//child class of dungeon character
class Hero: DungeonCharacter {
    //properties
    var chanceToBlock: Double //should be checked before hp is lowered
    var numberTurns: Int
    
    //get the name of the hero from the user
    func setName() -> String {
        print("What is the name of your hero?")
        let name = readLine()
        self.name = name!
        return self.name
    }
    
    //overriding the description so that it prints the name of the hero
    override var description:String {
        return ("My name is \(name) and I am a hero")
    }
    
    //initializing values
    override init() {
        self.chanceToBlock = 0.80 //represented as a whole number rather than a percent
        self.numberTurns = 3
        super.init()
    }
    
    //based on the attack speed of the hero
    //if the attack speed is twice the monsters attack speed, then there are two turns
    //if the attack speed is thrice the monsters attach speed, then there are three turns
    func getNumberTurns(monster: Monster) -> Int {
        let temp = attackSpeed / monster.attackSpeed
        numberTurns = temp
        if numberTurns == 0 {
            numberTurns = 1
        }
        return numberTurns
    }
    
    //checks to see if character can block the attack
    override func block() -> Bool{
        var blocked = false
        var random = Double(arc4random_uniform(100 - 1) + 1)
        random = random * 0.01
        //if the random number returns a number within the range
        if random <= chanceToBlock {
            //if the character is dead
            if hp <= 0 {
                print("\tYour hero is dead. No use in trying to fight it.")
                blocked = false
            //if character is alive
            } else {
                print("\tYour hero was able to block the attack...no damage dealt")
                blocked = true
            }
        } else {
            print("Your hero tried to block, but tripped on a rock...")
            blocked = false
        }
        return blocked
    }
    
    //Let the user choose the type of attack
    func chooseAttack() -> Int {
        print("\tPlease choose your attack from the following menu")
        print("\t\t1) Normal attack")
        print("\t\t2) Special attack")
        print("\t\t3) Quit Game")
        print("\t--->", terminator: "")
        let answer = readLine()
        return Int(answer!)!
    }
    
}
