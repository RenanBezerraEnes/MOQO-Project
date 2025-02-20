//
//  MOQO Project
//  Created by Renan Bezerra.
//

import SwiftUI

struct SwipeToUnlockButton: View {
    var vehicleName: String
    @State private var offset: CGFloat = 0
    @State private var isUnlocked: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.black.opacity(0.2))
                .frame(height: 50)
            
            Text("Swipe to Unlock \(vehicleName)")
                .foregroundColor(.black)
                .bold()
            
            HStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.black)
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
                                            if gesture.translation.width > 0 && gesture.translation.width < 200 {
                                                offset = gesture.translation.width
                                            }
                                        }
                                        .onEnded { _ in
                                            if offset > 150 {
                                                isUnlocked = true
                                                print("Unlocked \(vehicleName)")
                                            } else {
                                                isUnlocked = false
                                            }
                                            withAnimation {
                                                offset = 0
                                            }
                                        }
                                )
                            Spacer()
                        }
                    }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}
