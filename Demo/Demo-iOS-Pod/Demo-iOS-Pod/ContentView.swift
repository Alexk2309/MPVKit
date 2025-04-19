import SwiftUI

// Try to import MPVKit
#if canImport(MPVKit)
import MPVKit
#endif

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("MPVKit Pod Demo")
                .font(.largeTitle)
                .padding()
            
            Text("This is a simple test app to verify that the MPVKit pod is working")
                .multilineTextAlignment(.center)
                .padding()
            
            #if canImport(MPVKit)
            Text("MPVKit is available ✅")
                .foregroundColor(.green)
            #else
            Text("MPVKit is not available ❌")
                .foregroundColor(.red)
            #endif
        }
        .padding()
    }
} 