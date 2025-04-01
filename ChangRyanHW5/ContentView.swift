import SwiftUI

struct ContentView: View {
    let OFFSET_X = 450.0
    let OFFSET_Y = 900.0
    
    @StateObject var flashcardViewModel = FlashcardViewModel()
    @State var isShowingQuestion = true
    @State var offsetX = 0.0
    @State var offsetY = 0.0
    @State var isHidden = false
    
    var title: String {
        guard let currCard = flashcardViewModel.currentFlashcard else {
            return ""
        }
        return isShowingQuestion ? currCard.question : currCard.answer
    }
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .bold()
                .foregroundColor(isShowingQuestion ? .blue : .green)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.purple)
        .onTapGesture(count: 2) {
            toggleQuestionAnswer()
        }
        .onTapGesture {
            showRandomFlashcard()
        }
        .opacity(isHidden ? 0 : 1)
        .offset(x: offsetX, y: offsetY)
        .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
            .onEnded { value in
                print(value.translation)
                switch(value.translation.width, value.translation.height) {
                    case (...0, -30...30):
                        print("left swipe")
                        showNextCard()
                    case (0..., -30...30):
                        print("right swipe")
                        showPreviousCard()
                    case (-100...100, ...0):
                        print("up swipe")
                    case (-100...100, 0...):
                        print("down swipe")
                    default:
                        print("no clue")
                }
            }
        )
    }
    
    func showRandomFlashcard() {
        withAnimation(.easeInOut(duration: 0.3)) {
            offsetY = -OFFSET_Y
            isHidden = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            offsetY = OFFSET_Y
            isShowingQuestion = true
            flashcardViewModel.randomize()
            
            withAnimation(.easeInOut(duration: 0.3)) {
                offsetY = 0
                isHidden = false
            }
        }
    }
    
    func toggleQuestionAnswer() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isHidden = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isShowingQuestion.toggle()
            
            withAnimation(.easeInOut(duration: 0.3)) {
                isHidden = false
            }
        }
    }
    
    func showNextCard() {
        withAnimation(.easeInOut(duration: 0.3)) {
            offsetX = -OFFSET_X
            isHidden = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            offsetX = OFFSET_X
            isShowingQuestion = true
            flashcardViewModel.next()
            
            withAnimation(.easeInOut(duration: 0.3)) {
                offsetX = 0
                isHidden = false
            }
        }
    }
    
    func showPreviousCard() {
        withAnimation(.easeInOut(duration: 0.3)) {
            offsetX = OFFSET_X
            isHidden = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            offsetX = -OFFSET_X
            isShowingQuestion = true
            flashcardViewModel.previous()
            
            withAnimation(.easeInOut(duration: 0.3)) {
                offsetX = 0
                isHidden = false
            }
        }
    }
}

