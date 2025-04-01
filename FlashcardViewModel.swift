//
//  FlashcardViewModel.swift
//  ChangRyanHW5
//
//  Created by Ryan Chang on 3/11/25.
//

import Foundation
import SwiftUI

class FlashcardViewModel: ObservableObject, FlashcardsModel {
    var flashcards: [Flashcard] = []
    
    var currentIndex: Int = 0 {
        didSet {
            if !flashcards.isEmpty {
                currentIndex = (currentIndex + flashcards.count) % flashcards.count
            } else {
                currentIndex = 0
            }
        }
    }
    
    init() {
        flashcards = [
            Flashcard(question: "What is the best university in Los Angeles?", answer: "University of Southern California", isFavorite: false),
            Flashcard(question: "What is the UI framework we're learning in class?", answer: "SwiftUI", isFavorite: false),
            Flashcard(question: "What is the largest planet in the solar system?", answer: "Jupiter", isFavorite: false),
            Flashcard(question: "Who is Ash Ketchum's first pokemon?", answer: "Pikachu", isFavorite: false),
            Flashcard(question: "Who is greatest basketball player of all time?", answer: "Lebron Raymone James", isFavorite: false)
        ]
    }
    
    // Protocol functions and computed properties
    var numberOfFlashcards: Int {
        return flashcards.count
    }
    
    var currentFlashcard: Flashcard? {
        if flashcards.isEmpty {
            return nil
        }
        return flashcards[currentIndex]
    }
    
    var favoriteFlashcards: [Flashcard] {
        return flashcards.filter { $0.isFavorite }
    }
    
    func randomize() {
        if flashcards.count <= 1 {
            return
        }
        
        let oldIndex = currentIndex
        var newIndex = oldIndex
        
        while newIndex == oldIndex {
            newIndex = Int.random(in: 0..<flashcards.count)
        }
        
        currentIndex = newIndex
    }
    
    func next() {
        if !flashcards.isEmpty {
            currentIndex = (currentIndex + 1) % flashcards.count
        }
    }

    func previous() {
        if !flashcards.isEmpty {
            currentIndex = (currentIndex - 1 + flashcards.count) % flashcards.count
        }
    }
    
    func flashcard(at index: Int) -> Flashcard? {
        guard index >= 0 && index < flashcards.count else {
            return nil
        }
        return flashcards[index]
    }
    
    func append(flashcard: Flashcard) {
        flashcards.append(flashcard)
    }
    
    func insert(flashcard: Flashcard, at index: Int) {
        if index >= 0 && index <= flashcards.count {
            flashcards.insert(flashcard, at: index)
        } else {
            flashcards.append(flashcard)
        }
    }
    
    func removeFlashcard(at index: Int) {
        guard index >= 0 && index < flashcards.count else {
            return
        }
        flashcards.remove(at: index)
    }
    
    func getIndex(for flashcard: Flashcard) -> Int? {
        return flashcards.firstIndex(of: flashcard)
    }
    
    func update(flashcard: Flashcard, at index: Int) {
        guard index >= 0 && index < flashcards.count else {
            return
        }
        flashcards[index] = flashcard
    }
    
    func toggleFavorite() {
        guard let currentCard = currentFlashcard else {
            return
        }
        
        let updatedCard = Flashcard(
            question: currentCard.question,
            answer: currentCard.answer,
            isFavorite: !currentCard.isFavorite
        )
        
        update(flashcard: updatedCard, at: currentIndex)
    }
}
