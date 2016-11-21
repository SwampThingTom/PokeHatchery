//
//  PokémonEggs.swift
//  PokeHatchery
//
//  Created by Thomas Aylesworth on 11/15/16.
//  Copyright © 2016 Thomas H Aylesworth. All rights reserved.
//

import Foundation

enum PokémonEggErrors: Error {
    case invalidPercentages
}

struct PokémonEggs {
    
    static let eggs10K = [
        ("eevee", 17.7),
        ("magmar", 8.7),
        ("onix", 8.4),
        ("electabuzz", 8.1),
        ("pinsir", 8.0),
        ("jynx", 7.5),
        ("scyther", 7.1),
        ("snorlax", 5.2),
        ("lapras", 4.9),
        ("aerodactyl", 4.2),
        ("chansey", 3.6),
        ("hitmonlee", 3.6),
        ("dratini", 3.5),
        ("kabuto", 3.5),
        ("omanyte", 3.1),
        ("hitmonchan", 2.9)]

    private let pokémon: [(String, Double)]
    
    init(pokémonEggs: [(String, Double)]) throws {
        var totalPercent = 0.0
        pokémon = pokémonEggs.map({ (name, percent) -> (String, Double) in
            totalPercent += (percent / 100.0)
            return (name, totalPercent)
        })
        if fabs(totalPercent - 1.0) < DBL_EPSILON {
            throw PokémonEggErrors.invalidPercentages
        }
    }
    
    func runSimulation(times: Int, eggs: Int) -> [Int] {
        var pokémonRemaining = [Int](repeating: 0, count: pokémon.count)
        for _ in 1 ... times {
            let hatches = hatch(eggs: eggs)
            let numberOfPokémonRemaining = hatches.values.reduce(0) { $0 + ($1 == 0 ? 1 : 0) }
            pokémonRemaining[numberOfPokémonRemaining] += 1
        }
        return pokémonRemaining
    }

    private typealias PokémonHatchCounts = Dictionary<String, Int>
    
    private func hatch(eggs: Int) -> PokémonHatchCounts {
        var hatchCount = initialHatchCount()
        for _ in 1 ... eggs {
            let pokémon = hatchPokémon()
            hatchCount[pokémon] = hatchCount[pokémon]! + 1
        }
        return hatchCount
    }
    
    private func initialHatchCount() -> PokémonHatchCounts {
        var hatchCount = PokémonHatchCounts()
        for (name, _) in pokémon {
            hatchCount[name] = 0
        }
        return hatchCount
    }
    
    private func hatchPokémon() -> String {
        let rng = Double(Double(arc4random()) / Double(UINT32_MAX))
        for (name, percent) in pokémon {
            if rng < percent {
                return name
            }
        }
        fatalError("Invalid rng")
    }
}
