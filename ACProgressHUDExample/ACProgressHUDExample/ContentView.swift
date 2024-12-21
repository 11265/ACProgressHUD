import SwiftUI

struct ContentView: View {
    @State private var showLoading = false
    @State private var showSuccess = false
    @State private var showError = false
    @State private var showToast = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show Loading") {
                showLoading.toggle()
            }
            
            Button("Show Success") {
                showSuccess = true
            }
            
            Button("Show Error") {
                showError = true
            }
            
            Button("Show Toast") {
                showToast = true
            }
        }
        .progressHUD(isPresented: $showLoading, 
                    message: "Loading...",
                    type: .loading)
        .progressHUD(isPresented: $showSuccess,
                    message: "Success!",
                    type: .success)
        .progressHUD(isPresented: $showError,
                    message: "Error occurred",
                    type: .error)
        .progressHUD(isPresented: $showToast,
                    message: "This is a toast message",
                    type: .toast)
    }
} 