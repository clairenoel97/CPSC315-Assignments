//
//  HeroesVersusMonsters.swift
//  PA3-Task2
//
//  Created by Norman, Claire on 9/18/18.
//  Copyright © 2018 Norman, Claire. All rights reserved.
//

import Foundation

struct HeroesVersusMonsters {
    
    //introduces player to the game
    func introduction() {
        print("***** Welcome to Heroes vs Monsters! *****")
    }
    
    //allows user to pick a hero to use
    func pickAHero() -> Hero {
        var hero: Hero
        print("Please choose your hero from the following options: ")
        print("\t1) Warrior ")
        print("\t2) Sorceress ")
        print("\t3) Thief ")
        print("-->", terminator:"")
        let chooseHero = readLine()
        if (chooseHero?.contains("1"))! {
            hero = Warrior()
            return hero
        } else if (chooseHero?.contains("2"))!{
            hero = Sorceress()
            return hero
        } else {
            hero = Thief()
            return hero
        }
    }
    
    //this is for the hero
    //allows the hero to attack for however many turns they have
    func herofight(attacker: Hero, opponent: Monster) {
        var index = 1 //this keeps the count of the turn player is on
        var numberTurns = attacker.getNumberTurns(monster: opponent) //number of turns
        var turncounter = numberTurns
        var num2 = turncounter
        //while the player still has turns, continue
        while turncounter != 0 {
            //checks if either character is dead
            if attacker.isDead() {
                print("\n\t\(attacker.name) is dead. \(opponent.description) won!")
                break
            }
            if opponent.isDead() {
                print("\n\t\(opponent.description) is dead. \(attacker.name) won!")
                break
            }
            //prints header for the ghero
            print("~~~ \(attacker.name)'s turn (\(index) of \(numberTurns)) ~~~")
            print("\t\(attacker.name) \(attacker.hp) hit points")
            print("\t\(opponent.description) \(opponent.hp) hit points\n")

            //attacks the opponent with attack specific to the character
            if attacker.attack(opponent: opponent) == 1 {
                numberTurns += 1
                turncounter += 1
            }

            turncounter -= 1
            index += 1
        }
    }
    
    //fight function specifically for monsters
    //attacks only once
    func monsterFight(attacker: Monster, opponent: Hero) {
        var num = 1
        while num != 0 {
            //checks to see if the characters are dead or not
            if attacker.isDead() {
                print("\n\t\(attacker.description) is dead. \(opponent.name) won!")
                break
            }
            if opponent.isDead() {
                print("\n\t\(opponent.name) is dead. \(attacker.description) won!")
                break
            }
            
            //header for the monster
            print("\n~~~ \(attacker.description)'s turn ~~~")
            print("\t\(attacker.description) \(attacker.hp) hit points")
            print("\t\(opponent.name) \(opponent.hp) hit points\n")
            attacker.attack(opponent: opponent)
            num -= 1

            
        }
    }
    
    //function that randomly selects monster for hero to fight
    func pickAMonster() -> Monster {
        var monster: Monster
        let random = arc4random_uniform(100)
        let index = random % 3
        if index == 0 {
            monster = Skeleton()
        } else if index == 1 {
            monster = Gremlin()
        } else {
            monster = Ogre()
        }
        return monster
    }
}
