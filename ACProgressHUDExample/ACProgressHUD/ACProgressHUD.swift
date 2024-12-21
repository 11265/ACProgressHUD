import SwiftUI

public struct ACProgressHUD: View {
    @Binding var isPresented: Bool
    let message: String
    let type: HUDType
    
    public enum HUDType {
        case success
        case error
        case loading
        case saving
        case custom(Image?)
        case toast
    }
    
    public init(isPresented: Binding<Bool>, 
               message: String = "",
               type: HUDType = .loading) {
        self._isPresented = isPresented
        self.message = message
        self.type = type
    }
    
    public var body: some View {
        GeometryReader { geometry in
            if isPresented {
                Group {
                    switch type {
                    case .toast:
                        toastView
                            .transition(.move(edge: .top))
                    default:
                        standardHUD
                    }
                }
                .onAppear {
                    if type == .success || type == .error || type == .toast {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                isPresented = false
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var standardHUD: some View {
        VStack(spacing: 15) {
            Group {
                switch type {
                case .success:
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                case .error:
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                case .loading:
                    ProgressView()
                case .saving:
                    ProgressView()
                case .custom(let image):
                    image
                case .toast:
                    EmptyView()
                }
            }
            .font(.system(size: 30))
            
            if !message.isEmpty {
                Text(message)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black.opacity(0.8))
        )
        .foregroundColor(.white)
        .frame(maxWidth: 200)
        .transition(.opacity)
    }
    
    private var toastView: some View {
        Text(message)
            .font(.system(size: 15))
            .multilineTextAlignment(.center)
            .padding()
            .background(Color.black.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top, 10)
    }
} 