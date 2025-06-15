import SwiftUI

struct InterrogationView: View {
    let onInterrogationFinished: (() -> Void)?
    @State private var showingNotes = false
    
    init(onInterrogationFinished: (() -> Void)? = nil) {
        self.onInterrogationFinished = onInterrogationFinished
    }
    
    var body: some View {
        ZStack {
            // Ana içerik
            DialogueSequenceView(steps: loadSteps(fromResource: "interregation"), onFinished: onInterrogationFinished)
            
            // Not alma butonu - sağ üst köşe
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showingNotes = true
                    }) {
                        Image(systemName: "note.text")
                            .font(.system(size: 20, weight: .semibold))
                    }
                    .buttonStyle(.notesButton)
                    .padding(.top, 50)
                    .padding(.trailing, 20)
                }
                Spacer()
            }
        }
        .sheet(isPresented: $showingNotes) {
            NotesView(isPresented: $showingNotes)
        }
    }
}

