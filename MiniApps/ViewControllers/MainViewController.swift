//
//  MainViewController.swift
//  MiniApps
//
//  Created by Evgeniy Maksimov on 08.09.2024.
//

import UIKit

enum DisplayMode {
    case small
    case medium
    case full
}

final class MainViewController: UITableViewController {
    // MARK: - Private properties
    private let miniApps = MiniApp.getMiniApps()
    private var currentMode: DisplayMode = .small

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        miniApps.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let miniApp = miniApps[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = miniApp.name
        content.image = UIImage(named: miniApp.image)
        
        cell.contentConfiguration = content
        switch currentMode {
        case .small:
            cell.isUserInteractionEnabled = false
        case .medium, .full:
            cell.isUserInteractionEnabled = true
        }
        
        return cell
    }
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let miniApp = miniApps[indexPath.row]
        miniApp.name == "Погода" 
        ? performSegue(withIdentifier: "showWeather", sender: nil)
        : performSegue(withIdentifier: "showQuiz", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        
        switch currentMode {
        case .small:
            return screenHeight / 8
        case .medium:
            return screenHeight / 2
        case .full:
            return screenHeight
        }
    }
    
    @IBAction func updateUI(_ sender: UIBarButtonItem) {
        switch currentMode {
        case .small:
            currentMode = .medium
        case .medium:
            currentMode = .full
        case .full:
            currentMode = .small
        }
        tableView.reloadData()
    }
}

