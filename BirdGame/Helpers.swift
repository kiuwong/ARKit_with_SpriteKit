//
//  Helpers.swift
//  BirdGame
//
//  Created by Kiu Ming Wong on 4/8/19.
//  Copyright © 2019 AlphaR. All rights reserved.
//

import Foundation

enum GameState:Int {
    case none, spawnBirds
}

func randomPosition (lowerBound lower:Float, upperBound upper:Float) -> Float {
    return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
}

func randomNumber (lowerBound lower:Int, upperBound upper:Int) -> Int {
    return Int(arc4random()) / Int(UInt32.max) * (lower - upper) + upper
}
