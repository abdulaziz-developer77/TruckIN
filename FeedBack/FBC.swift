

import SwiftUI
import AVFoundation

extension Color {
    static let borderGray = Color(red: 231/255, green: 232/255, blue: 234/255)
    static let bgGray = Color(red: 240/255, green: 242/255, blue: 244/255)
    static let tabBg = Color(red: 243/255, green: 244/255, blue: 246/255)
    static let cancelBorder = Color(red: 147/255, green: 198/255, blue: 215/255)
    static let cancelBg = Color(red: 233/255, green: 244/255, blue: 247/255)


}

struct FeedbackView: View {
    @State private var selectedTab: Int = 0
    @State private var comment: String = ""
    @FocusState private var isFocused: Bool
    @State private var isSending: Bool = false
    @State private var dotIndex: Int = 0

    @State private var audioRecorder: AVAudioRecorder?
    @State private var recordedURL: URL?
    @State private var isRecording = false
    @State private var isRecorded = false
    @State private var recordTime: Int = 0
    @State private var levels: [CGFloat] = Array(repeating: 12, count: 8)
    @State private var timer: Timer?

    var body: some View {
        GeometryReader { geo in
            let isPad = geo.size.width >= 768
            let isLandscape = geo.size.width > geo.size.height
            let horizontalPadding: CGFloat = isPad ? (isLandscape ? 240 : 24) : 14

            VStack(spacing: 20) {
                SegmentedTabs(selectedTab: $selectedTab, isPad: isPad)
                    .padding(.top, isPad ? 24 : 16)
                    .padding(.horizontal, horizontalPadding)

                if selectedTab == 0 {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(isPad ? "Feedback" : "Comments")
                            .font(.custom("SF Pro Text", size: isPad ? 16 : 14))
                            .fontWeight(.medium)
                            .foregroundColor(.black.opacity(0.8))
                            .padding(.leading, horizontalPadding)

                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.borderGray, lineWidth: 1)
                                .background(Color.bgGray.cornerRadius(12))

                            TextField("Type something", text: $comment, axis: .vertical)
                                .focused($isFocused)
                                .font(.custom("SF Pro Text", size: isPad ? 16 : 14))
                                .padding(.horizontal, isPad ? 24 : 16)
                                .padding(.vertical, 12)
                                .frame(height: 96, alignment: .topLeading)
                        }
                        .frame(height: 96)
                        .padding(.horizontal, horizontalPadding)
                        .padding(.top, 4)

                        HStack(spacing: isPad ? 16 : 12) {
                            Spacer()
                            cancelButton(isPad: isPad, isLandscape: isLandscape)
                            sendButton(isPad: isPad, isLandscape: isLandscape)
                        }
                        .padding(.horizontal, horizontalPadding)
                        .padding(.top, isPad ? 24 : 16)

                        Spacer()
                    }
                } else {
                    if isRecording {
                        VStack(spacing: 30) {
                            Spacer()
                            HStack(spacing: 8) {
                                ForEach(0..<levels.count, id: \.self) { i in
                                    Capsule()
                                        .fill(Color.primary)
                                        .frame(width: 12, height: levels[i])
                                        .animation(.easeInOut(duration: 0.1), value: levels[i])
                                }
                            }

                            HStack(spacing: 8) {
                                Image(systemName: "clock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text(formatTime(recordTime))
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }

                            Spacer()
                        }
                        .padding(.horizontal, horizontalPadding)
                    } else {
                        VoiceIdleView()
                            .padding(.horizontal, horizontalPadding)
                    }
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }

    private func cancelButton(isPad: Bool, isLandscape: Bool) -> some View {
        let width: CGFloat
        let height: CGFloat

        if isPad && isLandscape {
            width = 200; height = 48
        } else if isPad {
            width = 160; height = 48
        } else {
            width = 100; height = 44
        }

        return Button(action: { comment = "" }) {
            Text("Cancel")
                .font(.custom("SF Pro Text", size: 14))
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .frame(width: width, height: height)
                .background(Color.cancelBg)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.cancelBorder, lineWidth: 1.5)
                )
        }
    }

    private func sendButton(isPad: Bool, isLandscape: Bool) -> some View {
        let width: CGFloat
        let height: CGFloat

        if isPad && isLandscape {
            width = 200; height = 48
        } else if isPad {
            width = 160; height = 48
        } else {
            width = 100; height = 44
        }

        return Button(action: {
            if !comment.isEmpty {
                withAnimation { isSending = true }
                animateDots()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation { isSending = false }
                    comment = ""
                }
            }
        }) {
            if isSending {
                HStack(spacing: 6) {
                    ForEach(0..<3) { i in
                        Circle()
                            .fill(dotIndex == i ? Color.white : Color.gray.opacity(0.6))
                            .frame(width: 7, height: 7)
                            .scaleEffect(dotIndex == i ? 1.2 : 1.0)
                            .animation(.easeInOut(duration: 0.3), value: dotIndex)
                    }
                }
                .frame(width: width, height: height)
            } else {
                Text("Send")
                    .font(.custom("SF Pro Text", size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: width, height: height)
            }
        }
        .background(comment.isEmpty ? Color.primary50 : Color.primary100)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(comment.isEmpty ? Color.primary50 : Color.primary100, lineWidth: 1.5)
        )
        .disabled(comment.isEmpty || isSending)
    }

    private func animateDots() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if !isSending {
                timer.invalidate()
            } else {
                dotIndex = (dotIndex + 1) % 3
            }
        }
    }

    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
}

struct SegmentedTabs: View {
    @Binding var selectedTab: Int
    var isPad: Bool

    var body: some View {
        HStack(spacing: 0) {
            tabButton(title: "Text feedback", index: 0)
            tabButton(title: "Voice feedback", index: 1)
        }
        .padding(2)
        .background(Color.tabBg)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func tabButton(title: String, index: Int) -> some View {
        Button(action: { withAnimation(.easeInOut(duration: 0.25)) { selectedTab = index } }) {
            Text(title)
                .font(.custom("SF Pro Text", size: isPad ? 14 : 13))
                .fontWeight(.semibold)
                .foregroundColor(selectedTab == index ? .primary100 : .black)
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(
                    ZStack {
                        if selectedTab == index {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
                        }
                    }
                )
        }
        .buttonStyle(.plain)
    }
}
struct VoiceIdleView: View {
    let barWidth: CGFloat
    let spacing: CGFloat
    
    private let ipadHeights: [CGFloat] = [48, 86, 156, 200, 156, 86, 48]
    private let iphoneHeights: [CGFloat] = [38.4, 68.8, 124.8, 160, 124.8, 68.8, 38.4]
    
    private var currentHeights: [CGFloat] {
        UIDevice.current.userInterfaceIdiom == .pad ? ipadHeights : iphoneHeights
    }
    
    @State private var isRecording = false
    @State private var isFinished = false
    @State private var audioRecorder: AVAudioRecorder?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var recordedURL: URL?
    @State private var timer: Timer?
    @State private var elapsedTime: TimeInterval = 0
    @State private var audioLevels: [CGFloat] = []
    
    @State private var isSending = false
    @State private var activeCircle = 0
    @State private var circleTimer: Timer?
    
    init() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.barWidth = 36
            self.spacing = 7.55
        } else {
            self.barWidth = 28.8
            self.spacing = 6.04
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            let config = currentConfig(for: geo.size)
            ZStack {
                // MARK: Bars
                VStack(spacing: 12) {
                    HStack(alignment: .center, spacing: spacing) {
                        ForEach(0..<currentHeights.count, id: \.self) { i in
                            Capsule()
                                .fill(isRecording || isFinished ? Color.primary100 : Color.primary10.opacity(0.6))
                                .frame(
                                    width: barWidth,
                                    height: isRecording
                                        ? (audioLevels.indices.contains(i) ? audioLevels[i] : currentHeights[i])
                                        : currentHeights[i]
                                )
                                .cornerRadius(barWidth / 2)
                                .animation(.easeInOut(duration: 0.1), value: audioLevels)
                        }
                    }
                    
                    if isRecording || isFinished {
                        HStack(spacing: 6) {
                            Image("timeIcon")
                                .resizable()
                                .frame(width: config.timerImageSize, height: config.timerImageSize)
                            
                            Text(formatTime(elapsedTime))
                                .font(.system(size: config.timerFontSize, weight: .semibold))
                                .foregroundColor(.primary100)
                        }
                        .padding(.top, 6)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                VStack(spacing: 12) {
                    Spacer()
                    
                    if !isFinished {
                        VStack(spacing: 8) {
                            Image(isRecording ? "checkIcon" : "micIcon")
                                .resizable()
                                .frame(width: config.micSize, height: config.micSize)
                                .onTapGesture { toggleRecording() }
                            
                            Text(isRecording ? "Stop" : "Push to speak")
                                .font(.system(size: config.labelFontSize, weight: .medium))
                                .foregroundColor(.primary100)
                        }
                    } else {
                        VStack(spacing: 20) {
                            HStack(spacing: config.buttonSpacing) {
                                
                                Button(action: { resetRecording() }) {
                                    HStack(spacing: config.iconTextSpacing) {
                                        Image("xIcon")
                                            .resizable()
                                            .frame(width: config.buttonIconSize, height: config.buttonIconSize)
                                        
                                        Text("Reject")
                                            .font(.system(size: config.buttonFontSize, weight: .semibold))
                                    }
                                    .frame(width: config.buttonWidth, height: config.buttonHeight)
                                    .background(Color.red.opacity(0.1))
                                    .cornerRadius(config.buttonRadius)
                                    .foregroundColor(Color.red)
                                }
                                
                                Button(action: { sendRecording() }) {
                                    if isSending {
                                        HStack(spacing: 8) {
                                            ForEach(0..<3, id: \.self) { i in
                                                Circle()
                                                    .fill(activeCircle == i ? Color.primary100 : Color.primary50)
                                                    .overlay(
                                                        Circle().stroke(Color.primary100, lineWidth: 1.5)
                                                    )
                                                    .frame(width: 12, height: 12)
                                                    .animation(.easeInOut(duration: 0.3), value: activeCircle)
                                            }
                                        }
                                        .frame(width: config.buttonWidth, height: config.buttonHeight)
                                    } else {
                                        HStack(spacing: config.iconTextSpacing) {
                                            Image("sendIcon")
                                                .resizable()
                                                .frame(width: config.buttonIconSize, height: config.buttonIconSize)
                                            
                                            Text("Send")
                                                .font(.system(size: config.buttonFontSize, weight: .semibold))
                                        }
                                        .frame(width: config.buttonWidth, height: config.buttonHeight)
                                    }
                                }
                                .background(Color.primary50)
                                .cornerRadius(config.buttonRadius)
                                .foregroundColor(Color.primary100)
                            }
                        }
                    }
                }
                .padding(.bottom, config.bottomPadding)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
    
    private func currentConfig(for size: CGSize) -> UIConfig {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if size.width > size.height {
                return .iPadLandscape
            } else {
                return .iPadPortrait
            }
        } else {
            return .iPhone
        }
    }
    
    private func toggleRecording() {
        if isRecording { stopRecording() }
        else { startRecording() }
    }
    
    private func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            
            let url = FileManager.default.temporaryDirectory.appendingPathComponent("feedback.m4a")
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.record()
            recordedURL = url
            isRecording = true
            isFinished = false
            elapsedTime = 0
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                audioRecorder?.updateMeters()
                elapsedTime += 0.1
                
                let power = audioRecorder?.averagePower(forChannel: 0) ?? -60
                let normalized = max(0, (power + 60) / 60)
                
                audioLevels = currentHeights.map { base in
                    min(base, max(8, base * CGFloat(normalized)))
                }
            }
            
        } catch {
            print("Recording failed:", error.localizedDescription)
        }
    }
    
    private func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        isFinished = true
        timer?.invalidate()
    }
    
    private func resetRecording() {
        isFinished = false
        recordedURL = nil
        audioLevels = []
        elapsedTime = 0
        activeCircle = 0
        isSending = false
        circleTimer?.invalidate()
    }
    
    private func sendRecording() {
        print("Audio sent! File:", recordedURL?.absoluteString ?? "nil")
        isSending = true
        activeCircle = 0
        circleTimer?.invalidate()
        
        circleTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            withAnimation {
                activeCircle = (activeCircle + 1) % 3
            }
        }
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


struct UIConfig {
    let timerImageSize: CGFloat
    let timerFontSize: CGFloat
    let micSize: CGFloat
    let labelFontSize: CGFloat
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    let buttonFontSize: CGFloat
    let buttonIconSize: CGFloat
    let buttonRadius: CGFloat
    let buttonSpacing: CGFloat
    let iconTextSpacing: CGFloat
    let bottomPadding: CGFloat
    
    static let iPhone = UIConfig(
        timerImageSize: 20,
        timerFontSize: 18,
        micSize: 64,
        labelFontSize: 14,
        buttonWidth: 120,
        buttonHeight: 60,
        buttonFontSize: 16,
        buttonIconSize: 24,
        buttonRadius: 100,
        buttonSpacing: 16,
        iconTextSpacing: 8,
        bottomPadding: 20
    )
    
    static let iPadPortrait = UIConfig(
        timerImageSize: 24,
        timerFontSize: 24,
        micSize: 80,
        labelFontSize: 16,
        buttonWidth: 170,
        buttonHeight: 80,
        buttonFontSize: 20,
        buttonIconSize: 32,
        buttonRadius: 100,
        buttonSpacing: 16,
        iconTextSpacing: 12,
        bottomPadding: 100
    )
    
    static let iPadLandscape = UIConfig(
        timerImageSize: 24,
        timerFontSize: 24,
        micSize: 80,
        labelFontSize: 16,
        buttonWidth: 170,
        buttonHeight: 80,
        buttonFontSize: 20,
        buttonIconSize: 32,
        buttonRadius: 100,
        buttonSpacing: 16,
        iconTextSpacing: 12,
        bottomPadding: 60
    )
}






struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FeedbackView() // iPhone
                .previewDevice("iPhone 15")
            FeedbackView() // iPad portrait
                .previewDevice("iPad Pro (11-inch) (4th generation)")
            FeedbackView() // iPad landscape
                .previewDevice("iPad Pro (11-inch) (4th generation)")
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}




