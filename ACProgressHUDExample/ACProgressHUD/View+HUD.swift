import SwiftUI

extension View {
    public func hud<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        ZStack {
            self
            
            if isPresented.wrappedValue {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .transition(.opacity)
                
                content()
            }
        }
    }
    
    public func progressHUD(
        isPresented: Binding<Bool>,
        message: String = "",
        type: ACProgressHUD.HUDType = .loading
    ) -> some View {
        ZStack {
            self
            
            ACProgressHUD(isPresented: isPresented,
                         message: message,
                         type: type)
        }
    }
} 