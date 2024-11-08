//
//  fungicidas_area.swift
//  Calibracion
//
//  Created by vnegas on 13/10/24.
//  Copyright 2023-2024 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct fungicidas_area: View {
    
    @State private var input: Int? = nil
    private var inputBinding: Binding<String> {
        Binding(
            get: {
                if let input = input {
                    return String(input)
                } else {
                    return ""
                }
            },
            set: { newValue in
                if let intValue = Int(newValue) {
                    input = intValue
                } else if newValue.isEmpty {
                    input = nil
                }
            }
        )
    }
    
    //@Binding var goToMenu: Bool
    let screenWidth = UIScreen.main.bounds.size.width;
    
    var body: some View {
        LazyVStack {
            ZStack {
                Image("method_title_bg")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 500, height: 180)
                VStack {
                    // Screen Title
                    Text("Área")
                        .font(.custom("GlacialIndifference-Regular", size: 34))
                        .foregroundColor(.black) // B7373636
                        // .frame(width: 150, height: 47, alignment: .center)
                    // Method description
                    Text("Marque un área conocida y aplique allí agua a la velocidad usual.")
                        .font(.custom("GlacialIndifference-Regular", size: 24))
                        .foregroundColor(Color(hex: "#373636")) // B7373636
                        .frame(width: 364, height: 120, alignment: .center)
                }
            }
            // First input
            HStack {
                // Text input
                Text("Área aplicada (m")
                    .font(.custom("GlacialIndifference-Regular", size: 20.6))
                    .foregroundColor(Color(hex: "#373636"))
                + Text("2")
                    .baselineOffset(6.0)
                    .font(.custom("GlacialIndifference-Regular", size: 12))
                    .foregroundColor(Color(hex: "#373636"))
                + Text("):")
                    .font(.custom("GlacialIndifference-Regular", size: 20.6))
                    .foregroundColor(Color(hex: "#373636"))
                // Number Input
                TextField("Área", text: inputBinding)
                    .keyboardType(.numberPad)
                    .font(.custom("GlacialIndifference-Regular", size: 19))
                    .foregroundColor(Color(hex: "#373636")) // B7373636
                    .frame(width: 150, height: 47, alignment: .center)
                    .background {
                        RoundedRectangle(cornerRadius: 65)
                            .fill(.white)
                            .stroke(.accent, lineWidth: 2)
                    }
            }
        }
    }
}

// Allows color in hex code: "#373636"
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (24-bit)
            (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1
        )
    }
}

#Preview {
    //fungicidas_area()
}
