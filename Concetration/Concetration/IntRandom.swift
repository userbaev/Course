//
//  IntRandom.swift
//  Concetration
//
//  Created by Marat on 31/01/2020.
//  Copyright © 2020 ASU. All rights reserved.
//

import Foundation


extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}


