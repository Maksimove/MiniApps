//
//  Question.swift
//  MiniApps
//
//  Created by Evgeniy Maksimov on 07.09.2024.
//

struct Question {
    let title: String
    let type: ResponceType
    let answers: [Answer]
    
    static func getQuestions() -> [Question] {
        [
            Question(
                title: "Какую пищу предпочитаете?",
                type: .single,
                answers: [
                    Answer(title: "Стейк", animal: .dog),
                    Answer(title: "Рыбу", animal: .cat),
                    Answer(title: "Морковь", animal: .rabbit),
                    Answer(title: "Кукурузу", animal: .turtle)
                ]
            ),
            Question(
                title: "Что вам нравится больше?",
                type: .multiple,
                answers: [
                    Answer(title: "Плавать", animal: .dog),
                    Answer(title: "Спать", animal: .cat),
                    Answer(title: "Есть", animal: .rabbit),
                    Answer(title: "Ходить", animal: .turtle)
                ]
            ),
            Question(
                title: "Любите ли вы поездки на машине?",
                type: .range,
                answers: [
                    Answer(title: "Ненавижу", animal: .cat),
                    Answer(title: "Нервничаю", animal: .rabbit),
                    Answer(title: "Не замечаю", animal: .turtle),
                    Answer(title: "Обожаю", animal: .dog)
                ]
            )
        ]
    }
}

enum ResponceType {
    case single
    case multiple
    case range
}
struct Answer {
    let title: String
    let animal: Animal
}

enum Animal: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
        
    var definition: String {
        switch self {
        case .dog:
            return "Вы любите быть с друзьями."
        case .cat:
            return "Вы цените одиночество."
        case .rabbit:
            return "Вы здоровы и полны энергией."
        case .turtle:
            return "Вы умны и спокойны."
        }
    }
}
