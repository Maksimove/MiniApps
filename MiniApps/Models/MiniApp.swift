//
//  MiniApp.swift
//  MiniApps
//
//  Created by Evgeniy Maksimov on 08.09.2024.
//

struct MiniApp {
    let name: String
    let image: String
    
    static func getMiniApps() -> [MiniApp] {
        var menuApps: [MiniApp] = []
        for _ in 1...10 {
            let miniAppWeather = MiniApp(name: "Погода", image: "weatherImage")
            menuApps.append(miniAppWeather)
            let miniAppQuiz = MiniApp(name: "Викторина", image: "quizImage")
            menuApps.append(miniAppQuiz)
        }
       return menuApps.shuffled()
    }
}
