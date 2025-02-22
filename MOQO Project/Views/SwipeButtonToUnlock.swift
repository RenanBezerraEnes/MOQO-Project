//
//  MOQO Project
//  Created by Renan Bezerra.
//

import SwiftUI

struct SwipeToUnlockButton: View {
    var vehicleName: String
    @State private var offset: CGFloat = 0
    @State private var isUnlocked: Bool = false
    private let maxDragWidth: CGFloat = 250
    private let unlockThreshold: CGFloat = 150
    private let cornerRadius: CGFloat = 25
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(isUnlocked ? Color.green.opacity(0.2) : Color.black.opacity(0.2))
                .frame(height: 50)
            
            HStack(spacing: 0) {
                Spacer()
                    .frame(width: 50)
                Text("Swipe to \(isUnlocked ? "Lock " : "Unlock ")")
                    .foregroundColor(.black)
                    .bold()
                    .fixedSize(horizontal: true, vertical: false)
                Text(vehicleName)
                    .foregroundColor(.black)
                    .bold()
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            .padding(.leading, 10)
            
            HStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(isUnlocked ? Color.green : Color.black)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: isUnlocked ? "lock.open.fill" : "lock.fill")
                            .foregroundColor(.white)
                            .animation(.easeInOut(duration: 0.2), value: isUnlocked)
                    )
                    .offset(x: offset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                if gesture.translation.width > 0 && gesture.translation.width < maxDragWidth {
                                    offset = gesture.translation.width
                                }
                            }
                            .onEnded { _ in
                                if offset > unlockThreshold  {
                                    isUnlocked.toggle()
                                }
                                withAnimation(.spring()) {
                                    offset = 0
                                }
                            }
                    )
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}
