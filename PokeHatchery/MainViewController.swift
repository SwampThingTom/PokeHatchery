//
//  MainViewController.swift
//  PokeHatchery
//
//  Created by Thomas Aylesworth on 11/15/16.
//  Copyright © 2016 Thomas H Aylesworth. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var simulationCountField: NSTextField?
    @IBOutlet weak var eggCountField: NSTextField?
    @IBOutlet weak var hatchPercentField: NSTextField?
    @IBOutlet weak var statusLabel: NSTextField?
    @IBOutlet weak var tableView: NSTableView?
    
    private var pokémonRemaining = [Int]()
    private var simulationCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func hatch(sender: NSButton) {
        guard let simulationCount = simulationCountField?.integerValue,
            let totalEggs = eggCountField?.integerValue,
            let hatchPercentage = hatchPercentField?.doubleValue else {
                showErrorStatus(text: "Internal error: unable to get values from text fields")
                return
        }
        
        if simulationCount <= 0 {
            showErrorStatus(text: "Simulation count must be > 0")
            return
        }

        if totalEggs <= 0 {
            showErrorStatus(text: "Total egg count must be > 0")
            return
        }
        
        if hatchPercentage <= 0.0 || hatchPercentage > 100.0 {
            showErrorStatus(text: "Egg hatch percentage must be between 0.0 and 100.0")
            return
        }
        
        do {
            let numberOfEggsToHatch = Int(Double(totalEggs) * (hatchPercentage / 100.0))
            try simulateHatching(times: simulationCount, eggs: numberOfEggsToHatch)
        } catch {
            showErrorStatus(text: "Internal error: unable to run simulation")
        }
    }
    
    private func simulateHatching(times: Int, eggs: Int) throws {
        assert(times > 0)
        assert(eggs > 0)
        
        showInfoStatus(text: "Simulating hatching \(eggs) eggs, \(times) times")
        
        let pokémonEggs = try PokémonEggs(pokémonEggs: PokémonEggs.eggs10K)
        DispatchQueue.global().async {
            self.pokémonRemaining = pokémonEggs.runSimulation(times: times, eggs: eggs)
            self.simulationCount = times
            
            DispatchQueue.main.async {
                self.showInfoStatus(text: "Simulated hatching \(eggs) eggs, \(times) times")
                self.tableView?.reloadData()
            }
        }
    }
    
    private func showErrorStatus(text: String) {
        statusLabel?.stringValue = text
        statusLabel?.textColor = NSColor.red
    }
    
    private func showInfoStatus(text: String) {
        statusLabel?.stringValue = text
        statusLabel?.textColor = NSColor.black
    }
    
    // MARK: - TableView Delegate
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return pokémonRemaining.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let columnIdentifier = tableColumn?.identifier else {
            return nil
        }
        
        guard let cellView = tableView.make(withIdentifier: columnIdentifier, owner: self) as? NSTableCellView else {
            return nil
        }
        
        if columnIdentifier == "RemainingPokemonColumn" {
            cellView.textField?.stringValue = "\(row)"
        }
        else if tableColumn?.identifier == "ChanceColumn" {
            let percent = 100.0 * Double(pokémonRemaining[row]) / Double(simulationCount)
            cellView.textField?.stringValue = "\(percent)"
        }
        
        return cellView
    }
}
