//
//  ChangRyanHW5Tests.swift
//  ChangRyanHW5Tests
//
//  Created by Ryan Chang on 3/11/25.
//

import XCTest
@testable import ChangRyanHW5

class FlashcardViewModelTests: XCTestCase {
    
    var viewModel: FlashcardViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = FlashcardViewModel()
    }
    
    func testNumberOfFlashcards() {
        XCTAssertEqual(viewModel.numberOfFlashcards, 5)
    }
    
    func testCurrentFlashcard() {
        XCTAssertNotNil(viewModel.currentFlashcard)
        
        // Empty flashcards case
        viewModel.flashcards = []
        XCTAssertNil(viewModel.currentFlashcard)
    }
    
    func testFavoriteFlashcards() {
        // Initially no favorites
        XCTAssertEqual(viewModel.favoriteFlashcards.count, 0)
        
        // Add a favorite
        let flashcard = viewModel.flashcards[0]
        let favorite = Flashcard(question: flashcard.question, answer: flashcard.answer, isFavorite: true)
        viewModel.update(flashcard: favorite, at: 0)
        
        XCTAssertEqual(viewModel.favoriteFlashcards.count, 1)
    }
    
    func testRandomize() {
        let initialIndex = viewModel.currentIndex
        viewModel.randomize()
        
        // Since randomize should give a different index, they shouldn't be equal
        // (This might occasionally fail due to randomness, but it's unlikely)
        XCTAssertNotEqual(initialIndex, viewModel.currentIndex)
    }
    
    func testNext() {
        let initialIndex = viewModel.currentIndex
        viewModel.next()
        
        // After next(), currentIndex should be one more than before, or loop back to 0
        let expectedIndex = (initialIndex + 1) % viewModel.flashcards.count
        XCTAssertEqual(viewModel.currentIndex, expectedIndex)
    }
    
    func testPrevious() {
        let initialIndex = viewModel.currentIndex
        viewModel.previous()
        
        // After previous(), currentIndex should be one less than before, or loop back to the end
        let expectedIndex = (initialIndex - 1 + viewModel.flashcards.count) % viewModel.flashcards.count
        XCTAssertEqual(viewModel.currentIndex, expectedIndex)
    }
    
    func testFlashcardAt() {
        // Valid index
        XCTAssertNotNil(viewModel.flashcard(at: 0))
        
        // Invalid index
        XCTAssertNil(viewModel.flashcard(at: -1))
        XCTAssertNil(viewModel.flashcard(at: 100))
    }
    
    func testAppend() {
        let initialCount = viewModel.flashcards.count
        let newFlashcard = Flashcard(question: "Test Question", answer: "Test Answer", isFavorite: false)
        
        viewModel.append(flashcard: newFlashcard)
        
        XCTAssertEqual(viewModel.flashcards.count, initialCount + 1)
        XCTAssertEqual(viewModel.flashcards.last?.question, "Test Question")
    }
    
    func testInsert() {
        let initialCount = viewModel.flashcards.count
        let newFlashcard = Flashcard(question: "Inserted Question", answer: "Inserted Answer", isFavorite: false)
        
        // Valid insert
        viewModel.insert(flashcard: newFlashcard, at: 1)
        
        XCTAssertEqual(viewModel.flashcards.count, initialCount + 1)
        XCTAssertEqual(viewModel.flashcards[1].question, "Inserted Question")
        
        // Insert at invalid index should append
        let anotherFlashcard = Flashcard(question: "Another Question", answer: "Another Answer", isFavorite: false)
        viewModel.insert(flashcard: anotherFlashcard, at: 100)
        
        XCTAssertEqual(viewModel.flashcards.count, initialCount + 2)
        XCTAssertEqual(viewModel.flashcards.last?.question, "Another Question")
    }
    
    func testRemoveFlashcard() {
        let initialCount = viewModel.flashcards.count
        
        // Remove valid index
        viewModel.removeFlashcard(at: 0)
        
        XCTAssertEqual(viewModel.flashcards.count, initialCount - 1)
        
        // Remove invalid index should do nothing
        viewModel.removeFlashcard(at: 100)
        
        XCTAssertEqual(viewModel.flashcards.count, initialCount - 1)
    }
    
    func testGetIndex() {
        let flashcard = viewModel.flashcards[2]
        
        XCTAssertEqual(viewModel.getIndex(for: flashcard), 2)
        
        // Non-existent flashcard should return nil
        let nonExistentFlashcard = Flashcard(question: "Not Found", answer: "Not Found", isFavorite: false)
        XCTAssertNil(viewModel.getIndex(for: nonExistentFlashcard))
    }
    
    func testUpdate() {
        let originalFlashcard = viewModel.flashcards[0]
        let updatedFlashcard = Flashcard(question: "Updated Question", answer: "Updated Answer", isFavorite: true)
        
        viewModel.update(flashcard: updatedFlashcard, at: 0)
        
        XCTAssertEqual(viewModel.flashcards[0].question, "Updated Question")
        XCTAssertEqual(viewModel.flashcards[0].answer, "Updated Answer")
        XCTAssertTrue(viewModel.flashcards[0].isFavorite)
        
        // Update invalid index should do nothing
        viewModel.update(flashcard: updatedFlashcard, at: 100)
    }
    
    func testToggleFavorite() {
        // Set current index to 0
        viewModel.currentIndex = 0
        
        // Get initial favorite state
        let initialFavorite = viewModel.currentFlashcard?.isFavorite ?? false
        
        // Toggle favorite
        viewModel.toggleFavorite()
        
        // Verify favorite state has changed
        XCTAssertEqual(viewModel.currentFlashcard?.isFavorite, !initialFavorite)
    }
}
