//
//  FlashcardsModel.swift
//  ChangRyanHW5
//
//  Created by Ryan Chang on 3/11/25.
//

import Foundation

// Protocol that checks to make sure you are naming your functions like intended
// Failure to follow this protocol will result in a 0
protocol FlashcardsModel {
    // Returns the number of flashcards in your flashcards array
    var numberOfFlashcards: Int { get }

    // Returns the current flashcard indicated by your currentIndex
    var currentFlashcard: Flashcard? { get }

        // Returns flashcards that has been marked as favorited
    var favoriteFlashcards: [Flashcard] { get }

    // Randomizes the currentIndex
    func randomize()

    // Set currentIndex to be next
        // if currentIndex reaches the end of array
        // it should loop back to the beginning of array
    func next()

    // Set currentIndex to be previous
        // if currentIndex reaches past the beginning
        // it should loop back to the end of array
    func previous()

    // Returns a flashcard at a given index
    func flashcard(at index: Int) -> Flashcard?

    // Initializes a flashcard at end of your flashcards array
    func append(flashcard: Flashcard)

    // Initializes a flashcard at specific index of your flashcards array
    func insert(flashcard: Flashcard, at index: Int)

    // Removes flashcard at a specific index
    func removeFlashcard(at index: Int)

    // Returns an index for a given flashcard
    func getIndex(for flashcard: Flashcard) -> Int?

    // Updates a flashcard at a specific index
    func update(flashcard: Flashcard, at index: Int)

    // Toggles the favorite attribute of your flashcard
    func toggleFavorite()

}
