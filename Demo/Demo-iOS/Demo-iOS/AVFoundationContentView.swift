import SwiftUI
import AVKit
import UniformTypeIdentifiers

/// Demo view using AVFoundation-based player with Picture-in-Picture support
struct AVFoundationContentView: View {
    @ObservedObject var coordinator = MPVAVFoundationPlayerView.Coordinator()
    @State private var loading = false
    @State private var showControls = true

    @State private var showSubtitlePicker = false
    @State private var showAudioPicker = false
    @State private var showFilePicker = false
    
    var body: some View {
        ZStack {
            // Player
            MPVAVFoundationPlayerView(coordinator: coordinator)
                .play(URL(string: "https://download.blender.org/peach/bigbuckbunny_movies/BigBuckBunny_320x180.mp4")!)
                .onPropertyChange { player, propertyName, propertyData in
                    switch propertyName {
                    case MPVProperty.pausedForCache:
                        loading = propertyData as? Bool ?? false
                    default:
                        break
                    }
                }
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        showControls.toggle()
                    }
                }
            
            // Overlay controls
            if showControls {
                controlsOverlay
            }
            
            // Loading indicator
            if loading {
                ProgressView()
                    .scaleEffect(1.5)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showSubtitlePicker) {
            subtitlePickerSheet
        }
        .sheet(isPresented: $showAudioPicker) {
            audioPickerSheet
        }
        .sheet(isPresented: $showFilePicker) {
            DocumentPicker { url in
                coordinator.play(url)
            }
        }
    }
    
    // MARK: - Subtitle Picker
    
    private var subtitlePickerSheet: some View {
        NavigationView {
            List(coordinator.subtitleTracks) { track in
                Button {
                    coordinator.setSubtitle(track.id)
                    showSubtitlePicker = false
                } label: {
                    HStack {
                        Text(track.displayName)
                            .foregroundColor(.primary)
                        Spacer()
                        if track.id == coordinator.currentSubtitleId {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                        }
                    }
                }
            }
            .navigationTitle("Subtitles")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        showSubtitlePicker = false
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
    
    // MARK: - Audio Picker
    
    private var audioPickerSheet: some View {
        NavigationView {
            List(coordinator.audioTracks) { track in
                Button {
                    coordinator.setAudio(track.id)
                    showAudioPicker = false
                } label: {
                    HStack {
                        Text(track.displayName)
                            .foregroundColor(.primary)
                        Spacer()
                        if track.id == coordinator.currentAudioId {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                        }
                    }
                }
            }
            .navigationTitle("Audio")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        showAudioPicker = false
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
    
    // MARK: - Controls Overlay
    
    private var controlsOverlay: some View {
        VStack {
            // Top bar with file picker, subtitle and PiP buttons
            HStack {
                // Local file picker button
                Button {
                    showFilePicker = true
                } label: {
                    Image(systemName: "folder")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                }
                
                Spacer()
                
                // Audio button
                Button {
                    coordinator.refreshAudioTracks()
                    showAudioPicker = true
                } label: {
                    Image(systemName: "speaker.wave.2")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                }
                
                // Subtitle button
                Button {
                    coordinator.refreshSubtitleTracks()
                    showSubtitlePicker = true
                } label: {
                    Image(systemName: "captions.bubble")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                }
                
                // PiP button
                Button {
                    coordinator.togglePiP()
                } label: {
                    Image(systemName: coordinator.isPiPActive ? "pip.exit" : "pip.enter")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                }
                .disabled(!coordinator.isPiPPossible && !coordinator.isPiPActive)
                .opacity(coordinator.isPiPPossible || coordinator.isPiPActive ? 1.0 : 0.5)
            }
            .padding()
            
            Spacer()
            
            // Center play/pause button
            Button {
                coordinator.togglePause()
            } label: {
                Image(systemName: coordinator.isPaused ? "play.circle.fill" : "pause.circle.fill")
                    .font(.system(size: 72))
                    .foregroundColor(.white)
                    .shadow(radius: 10)
            }
            
            Spacer()
            
            // Bottom: seek buttons and video selection
            VStack(spacing: 20) {
                // Seek controls
                HStack(spacing: 40) {
                    Button {
                        coordinator.seekRelative(-10)
                    } label: {
                        Image(systemName: "gobackward.10")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    
                    Button {
                        coordinator.seekRelative(10)
                    } label: {
                        Image(systemName: "goforward.10")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                
                // Video selection
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        // Local file button with distinct style
                        Button {
                            showFilePicker = true
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "folder.fill")
                                    .font(.caption)
                                Text("Local File")
                                    .font(.caption)
                                    .fontWeight(.medium)
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color.blue.opacity(0.6))
                            .cornerRadius(8)
                        }
                        
                        videoButton("H.264", url: "https://vjs.zencdn.net/v/oceans.mp4")
                        videoButton("H.265", url: "https://github.com/mpvkit/video-test/raw/master/resources/h265.mp4")
                        videoButton("Subs", url: "https://vjs.zencdn.net/v/oceans.mp4")
                        videoButton("HDR", url: "https://github.com/mpvkit/video-test/raw/master/resources/hdr.mkv")
                        videoButton("DV P5", url: "https://github.com/mpvkit/video-test/raw/master/resources/DolbyVision_P5.mp4")
                        videoButton("DV P8", url: "https://github.com/mpvkit/video-test/raw/master/resources/DolbyVision_P8.mp4")
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 40)
            .background(
                LinearGradient(
                    colors: [.clear, .black.opacity(0.7)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }
    
    private func videoButton(_ title: String, url: String) -> some View {
        Button {
            if let videoUrl = URL(string: url) {
                coordinator.play(videoUrl)
            }
        } label: {
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.2))
                .cornerRadius(8)
        }
    }
    
    private func videoButtonWithSubtitle(_ title: String, url: String, subtitleUrl: String) -> some View {
        Button {
            if let videoUrl = URL(string: url), let subUrl = URL(string: subtitleUrl) {
                coordinator.play(videoUrl, withSubtitle: subUrl)
            }
        } label: {
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.2))
                .cornerRadius(8)
        }
    }
}

// MARK: - Document Picker

/// A SwiftUI wrapper for UIDocumentPickerViewController to select video files
struct DocumentPicker: UIViewControllerRepresentable {
    let onPick: (URL) -> Void
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        // Define supported video types
        let supportedTypes: [UTType] = [
            .movie,
            .video,
            .mpeg4Movie,
            .quickTimeMovie,
            .avi,
            UTType(filenameExtension: "mkv") ?? .movie,
            UTType(filenameExtension: "ts") ?? .movie,
            UTType(filenameExtension: "m2ts") ?? .movie,
            UTType(filenameExtension: "webm") ?? .movie,
            UTType(filenameExtension: "flv") ?? .movie,
            UTType(filenameExtension: "wmv") ?? .movie,
            UTType(filenameExtension: "3gp") ?? .movie,
        ]
        
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes)
        picker.delegate = context.coordinator
        picker.allowsMultipleSelection = false
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onPick: onPick)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let onPick: (URL) -> Void
        
        init(onPick: @escaping (URL) -> Void) {
            self.onPick = onPick
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { return }
            
            // Start accessing security-scoped resource
            let accessing = url.startAccessingSecurityScopedResource()
            
            // Copy to a temporary location for unrestricted access
            let tempDir = FileManager.default.temporaryDirectory
            let tempURL = tempDir.appendingPathComponent(url.lastPathComponent)
            
            // Remove existing temp file if present
            try? FileManager.default.removeItem(at: tempURL)
            
            do {
                try FileManager.default.copyItem(at: url, to: tempURL)
                print("Copied file to: \(tempURL.path)")
                onPick(tempURL)
            } catch {
                print("Failed to copy file: \(error)")
                // Fall back to using the original URL
                onPick(url)
            }
            
            if accessing {
                url.stopAccessingSecurityScopedResource()
            }
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            print("Document picker cancelled")
        }
    }
}

#Preview {
    AVFoundationContentView()
}
