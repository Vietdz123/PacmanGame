//
//  ContentView.swift
//  PacmanGame
//
//  Created by MAC on 18/03/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var currentPosition: (CGFloat, CGFloat) = (1, 2)
//    @State private var x: CGFloat
//    @State private var y: CGFloat
    let arrBarrier: [(CGFloat, CGFloat)] = [(2, 3), (2,4),
                      (2, 6), (2, 7), (2, 8), (3, 8),
                      (5,3), (6, 3), (7, 3), (8, 3), (9, 3), (10, 3),
                      (7, 5), (7, 6), (6, 6), (7, 6), (8, 6), (9, 6),
                      (5, 8), (6,8), (7, 8), (8, 8), (9, 8), (10, 8),
                      (13, 3), (13, 4),
                      (13, 6), (13, 7), (13, 8), (12, 8)]
    
    let width: CGFloat = 320
    
    var paddingGame: CGFloat {
        return (widthDevice - width) / 2
    }
    
    var widthMouth: CGFloat {
        return width / 15 * 0.65
    }
    
    var spacing: CGFloat {
        return width / 15
    }
    
     
    
    var body: some View {
        VStack {
            
            Image("PACMAN-LINE-01")
                .resizable()
                .scaledToFill()
                .frame(width: width, height: width)
                .overlay(alignment: .topLeading) {
                    Image("mieng")
                        .resizable()
                        .scaledToFill()
                        .frame(width: widthMouth, height: widthMouth)
                        .background(.black)
                        .position(x: currentPosition.0 * spacing, y: currentPosition.1 * spacing)
                }

            // MARK: - Button
            Button(action: {
                let nextPosition = (currentPosition.0,
                                    currentPosition.1 - 1)
                if nextPosition.1 < 2 {return}
                if arrBarrier.contains(where: { value in
                    if value == nextPosition {
                        return true
                    }
                    
                    return false
                }) {
                    print("DEBUG: qqqq")
                    return
                }
                
                withAnimation {
                    currentPosition.1 -= 1
                }
            }, label: {
                Text("Top")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 80, height: 80)
                    .background(.cyan)
            })
            
            HStack(alignment: .center, spacing: 8) {
                Button(action: {
                    let nextPosition = (currentPosition.0 - 1,
                                        currentPosition.1)
                    if arrBarrier.contains(where: { value in
                        if value == nextPosition {
                            return true
                        }
                        
                        return false
                    }) {
                        print("DEBUG: qqqq")
                        return
                    }
                    
                    withAnimation {
                        currentPosition.0 -= 1
                    }
                }, label: {
                    Text("Left")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80)
                        .background(.red)
                })
                
                Button(action: {
                    let nextPosition = (currentPosition.0 + 1,
                                        currentPosition.1)
                    if arrBarrier.contains(where: { value in
                        if value == nextPosition {
                            return true
                        }
                        
                        return false
                    }) {
                        print("DEBUG: qqqq")
                        return
                    }
                    
                    withAnimation {
                        currentPosition.0 += 1
                    }
                        
                        
                }, label: {
                    Text("Right")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80)
                        .background(.blue)
                })
            }
            
            Button(action: {
                let nextPosition = (currentPosition.0,
                                    currentPosition.1 + 1)
                if arrBarrier.contains(where: { value in
                    if value == nextPosition {
                        return true
                    }
                    
                    return false
                }) {
                    print("DEBUG: qqqq")
                    return
                }
                
                withAnimation {
                    currentPosition.1 += 1
                }
            }, label: {
                Text("bottom")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 80, height: 80)
                    .background(.black)
            })
            
            Spacer()
        }
        
    }
}

#Preview {
    ContentView()
}
