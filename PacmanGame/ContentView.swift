//
//  ContentView.swift
//  PacmanGame
//
//  Created by MAC on 18/03/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var currentPosition: (CGFloat, CGFloat) = (2, 3)
    @State private var nameMount = "mieng_right"
    @State private var arrFoods: [(CGFloat, CGFloat)] = []
    let arrBarrier: [(CGFloat, CGFloat)] = [(3, 4), (3, 5),
                                            (3, 7), (3, 8), (3, 9), (4, 9),
                                            (6, 4), (7, 4), (8, 4), (9, 4), (10, 4), (11, 4),
                                            (8, 6), (9, 6), (7, 7), (8, 7), (9, 7), (10, 7),
                                            (6, 9), (7, 9), (8, 9), (9, 9), (10, 9), (11, 9),
                                            (14, 4), (14, 5),
                                            (14, 7), (14, 8), (14, 9), (13, 9)]
    
    
    let width: CGFloat = 320
    
    var paddingGame: CGFloat {
        return (widthDevice - width) / 2
    }
    
    var widthMouth: CGFloat {
        return width / 17 * 0.86    // Dài: Chia làm 17 khoảng, 0.86 = size cua mouth / size dien tich
    }
    
    var spacing: CGFloat {
        return width / 17
    }
    
    init() {
        var count = 6
        var arrGif: [(CGFloat, CGFloat)] = []
        while count > 0 {
            print("DEBUG: siu")
            guard let x = (2...15).randomElement() else {continue}
            guard let y = (3...9).randomElement() else {continue}
            
            let point: (CGFloat, CGFloat) = (CGFloat(x), CGFloat(y))
            if arrBarrier.contains(where: { value in
                if value == point {
                    return true
                }
                
                return false
            }) || point == (2, 3) {
                continue
            }
            
            arrGif.append(point)
            count -= 1
        }
        
        self._arrFoods = .init(wrappedValue: arrGif)
    }
    
    var body: some View {
        VStack {
 
            Image("PACMAN-01")
                .resizable()
                .scaledToFill()
                .frame(width: width, height: width)
                .overlay(alignment: .topLeading, content: {
                    ForEach(0..<arrFoods.count, id: \.self) { index in
                        Image("dong_xu")
                            .resizable()
                            .scaledToFill()
                            .frame(width: widthMouth, height: widthMouth)
                            .position(x: arrFoods[index].0 * spacing, y: arrFoods[index].1 * spacing)
                    }
                })
                .overlay(alignment: .topLeading) {
                    Image(nameMount)
                        .resizable()
                        .scaledToFill()
                        .frame(width: widthMouth, height: widthMouth)
                        .background(.black)
                        .position(x: currentPosition.0 * spacing, y: currentPosition.1 * spacing)
                }
                .overlay(alignment: .topLeading) {
                    
                    // MARK: - Top Button
                    Button(action: {
                        nameMount = "mieng_top"
                        let nextPosition = (currentPosition.0,
                                            currentPosition.1 - 1)
                        if nextPosition.1 < 3 {return}
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
                        
                        removeFood(valuePoint: nextPosition)
                        
                    }, label: {
                        Image("btn_top")
                            .resizable()
                            .scaledToFill()
                            .frame(width: spacing * 2, height: spacing * 2)
                    })
                    .position(x: 13 * spacing, y: (12 + 2 / 3) * spacing)
                    
                    
                    // MARK: - Left Button
                    Button(action: {
                        nameMount = "mieng_left"
                        let nextPosition = (currentPosition.0 - 1,
                                            currentPosition.1)
                        if nextPosition.0 < 2 {return}
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
                        
                        removeFood(valuePoint: nextPosition)
                        
                    }, label: {
                        Image("btn_left")
                            .resizable()
                            .scaledToFill()
                            .frame(width: spacing * 2, height: spacing * 2)
                    })
                    .position(x: (11 + 1 / 3) * spacing, y: 14 * spacing)

                    
                   // MARK: - Right Button
                    Button(action: {
                        nameMount = "mieng_right"
                        let nextPosition = (currentPosition.0 + 1,
                                            currentPosition.1)
                        if nextPosition.0 > 15 {return}
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
                        
                        removeFood(valuePoint: nextPosition)
                    }, label: {
                        Image("btn_right")
                            .resizable()
                            .scaledToFill()
                            .frame(width: spacing * 2, height: spacing * 2)
                    })
                    .position(x: (14 + 2 / 3) * spacing, y: 14 * spacing)

                    
                    // MARK: - Bottom Button
                    Button(action: {
                        nameMount = "mieng_bottom"
                        let nextPosition = (currentPosition.0,
                                            currentPosition.1 + 1)
                        if nextPosition.1 > 10 {return}
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
                        
                        removeFood(valuePoint: nextPosition)
                    }, label: {
                        Image("btn_bottom")
                            .resizable()
                            .scaledToFill()
                            .frame(width: spacing * 2, height: spacing * 2)
  
                    })
                    .position(x: 13 * spacing, y: (15 + 1 / 3) * spacing)
                }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        .onAppear {
            print("DEBUG: \(arrFoods.count)")
        }
        
    }
    
    
    func removeFood(valuePoint: (CGFloat, CGFloat)) {
        if let index = arrFoods.firstIndex(where: { value in
            if value == valuePoint {
                return true
            }
            
            return false
        }) {
            arrFoods.remove(at: index)
        }
    }
}

#Preview {
    ContentView()
}
