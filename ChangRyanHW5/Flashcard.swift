//
//  Flashcard.swift
//  ChangRyanHW5
//
//  Created by Ryan Chang on 3/11/25.
//
import Foundation

struct Flashcard: Identifiable, Hashable{
    let id = UUID()
    let question: String
    let answer: String
    let isFavorite: Bool
    
    static func == (lhs: Flashcard, rhs: Flashcard) -> Bool{
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
