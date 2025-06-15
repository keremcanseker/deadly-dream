import SwiftUI

struct NotesView: View {
    @Binding var isPresented: Bool
    @State private var noteText: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Siyah arka plan - beyaz kenarları gizlemek için
                Color.black
                    .ignoresSafeArea(.all)
                
                // Notebook arka plan resmi - tam ekran
                Image("notebook")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        minWidth: geometry.size.width,
                        minHeight: geometry.size.height
                    )
                    .clipped()
                    .ignoresSafeArea(.all)
                
                // Kapat butonu - sağ üst köşe
                VStack {
                    HStack {
                        Spacer()
                        Button("Kapat") {
                            isPresented = false
                        }
                        .foregroundColor(.orange)
                        .font(.custom("Saira-SemiBold", size: 16))
                        .padding(.top, 30)
                        .padding(.trailing, 20)
                    }
                    Spacer()
                }
                
                // Yazı alanı - scrollable
                VStack {
                    // Üstten %25 boşluk (4'te 1)
                    Spacer()
                        .frame(height: geometry.size.height * 0.07)
                    
                    // Ortada %60 alan - TextEditor
                    TextEditor(text: $noteText)
                        .font(.custom("Saira-Medium", size: 16))
                        .foregroundColor(.black)
                        .background(Color.clear)
                        .scrollContentBackground(.hidden)
                        .frame(height: geometry.size.height * 0.9)
                        .padding(.leading, geometry.size.width * 0.26) // Sol taraftan daha fazla padding
                        .padding(.trailing, geometry.size.width * 0.28) // Sağ taraftan az padding
                    
                    // Alt boşluk
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            loadNotes()
        }
        .onDisappear {
            saveNotes()
        }
        .onChange(of: noteText) { _ in
            // Otomatik kaydetme (debounced)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                saveNotes()
            }
        }
    }
    
    private func loadNotes() {
        noteText = UserDefaults.standard.string(forKey: "DetectiveNotebook") ?? ""
    }
    
    private func saveNotes() {
        UserDefaults.standard.set(noteText, forKey: "DetectiveNotebook")
    }
}

#Preview {
    NotesView(isPresented: .constant(true))
} 