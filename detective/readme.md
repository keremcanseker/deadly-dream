// GPT PROMPT

// Amaç:
// SwiftUI ile geliştirilecek bu proje, bir cinayet soruşturmasını konu alan,
// çizgi roman tarzında akan, etkileşimli ve modüler yapıya sahip
// bir **senaryo tabanlı interaktif oyun çerçevesi** sunar.

// Oyuncu, resim ve diyaloglarla ilerleyen hikayeyi takip eder,
// şüphelileri sorgular, delilleri inceler ve sonunda bir karar verir:
// katil kim?

// Yapı, tamamen JSON verisiyle yönlendirilir ve yeniden kullanılabilir niteliktedir:
// Yeni oyun oluşturmak sadece senaryo dosyasını ve görselleri değiştirmekle mümkündür.

// Ana Özellikler:
// - Tap-to-progress narrative system
// - Multiple visual story steps per section (like comic panels)
// - Modular scenario defined by a single JSON file
// - Evidence-based interrogation system
// - A decision point where player chooses the murderer
// - Dynamic ending based on player’s choice

// Screen Flow:
// 1. `IntroView` – Static background + intro narration (image, audio, text)
// 2. `StoryView` – Comic-style story progression with visuals and dialogues
// 3. `InterrogationView`– Suspect-by-suspect questioning + interactable evidence
// 4. `DecisionView` – Overview of suspects & their statements + player selects culprit
// 5. `EndingView` – Final outcome based on the choice, with narrative closure

// Technical Requirements:
// - The entire game will run in **landscape orientation only**
// - **Every screen must have a full-screen background image**
// - On the Intro screen, display two buttons: `Start Game` and `Settings`
// - In the Story screen:
// • Each step includes a full background image
// • Dialogue or narration text is shown in a **stylized subtitle box**
// • Subtitle box is positioned at the bottom of the landscape screen
// • Styled as a translucent gray rounded rectangle with proper padding/margin

// Tasks:
// - Define all models based on the JSON schema (Codable structs)
// - Build a centralized StoryEngine class to manage story progression
// - Implement each view using MVVM architecture
// - Load scenario.json and drive gameplay purely through data
// - Design UI to simulate graphic novel panels with speech bubbles or subtitles

// Notlar:
// - Oyuncu sadece "tap" ile ilerler, seçenek sunulmaz (karar noktası hariç)
// - Her ekran kendi ViewModel’i ile birlikte gelir
// - Tüm veri senaryo.json dosyasından çekilir
// - Asset’ler (resimler, sesler) dosya adlarıyla belirlenir

// Lütfen şimdi yukarıdaki yapıya uygun tüm model tanımlarını (`Scenario`, `StorySection`, `Suspect`, `DialogueLine`, `EndingSection`, vs.) oluştur.
// Tüm struct'lar Swift dilinde, Codable uyumlu olacak şekilde yazılmalı.

// Please write all code with a senior-level Swift standard:
// - Use type-safe, extensible and generic-friendly structures
// - Ensure clear separation of concerns and clean component design
