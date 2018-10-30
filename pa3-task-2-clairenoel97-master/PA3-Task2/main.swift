//
//  main.swift
//  PA3-Task2
//
//  Created by Norman, Claire on 9/18/18.
//  Copyright © 2018 Norman, Claire. All rights reserved.
//

import Foundation

var playAgain = true;
var myGame = HeroesVersusMonsters()

myGame.introduction();

//main game loop
while playAgain {
    //pick a hero and set the name
    let hero = myGame.pickAHero()
    hero.setName()
    
    //pick a monster
    let monster = myGame.pickAMonster()
    
    //second intro
    print("Your hero is battling \(monster.description)")
    print("Please press enter to continue...")
    let _ = readLine()
    
    //while the players are not dead, continue the game
    while !hero.isDead() && !monster.isDead() {
        myGame.herofight(attacker: hero, opponent: monster)
        print()
        myGame.monsterFight(attacker: monster, opponent: hero)
        print()
    }
    
    //start the playagain loop
    print("Would you like to play again? ('y' or 'n')")
    let play = readLine()
    if (play?.contains("y"))! {
        playAgain = true
    } else {
        playAgain = false
    }
}
//if the player quits the game
print("Thanks for playing!")


