//
//  ContentView.swift
//  Calibracion
//
//  Created by vnegas on 25/9/24.
//  Copyright 2023-2026 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct ContentView: View {

    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {

            menu(path: $path)

                .navigationDestination(for: AppRoute.self) { route in

                    switch route {

                    case .mainMenu:
                        menu(path: $path)

                    case .herbicidas:
                        herbicidas(path: $path)

                    case .fungicidas:
                        fungicidas(path: $path)

                    case .dosificacion:
                        dosificacion(path: $path)

                    case .ayuda:
                        ayuda(path: $path)

                    case .herbicidasVelFija:
                        herbicidas_vel_fija(path: $path)

                    case .herbicidasVolFijo:
                        herbicidas_vol_fijo(path: $path)

                    case .herbicidasVolAplic:
                        herbicidas_vol_apl(path: $path)

                    case .fungicidasArea:
                        fungicidas_area(path: $path)

                    case .fungicidasPlanta:
                        fungicidas_planta(path: $path)
                    }
                }
        }
        .navigationViewStyle(.stack)
    }
}


// MARK: - Main Menu

struct menu: View {

    @Binding var path: NavigationPath

    var body: some View {

        GeometryReader { geometry in

            ZStack {

                // MARK: Background

                Image("menu_bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height * 1.2
                    )
                    .edgesIgnoringSafeArea(.all)


                VStack(spacing: geometry.size.height * 0.05) {

                    // MARK: Title

                    Text("Calibración")
                        .foregroundColor(.white)
                        .font(
                            .custom(
                                "NotoSerifDisplay-ExtraCondensedItalic",
                                size: geometry.size.width * 0.12
                            )
                        )
                        .fontWeight(.bold)
                        .padding(.top, geometry.size.height * 0.12)


                    // MARK: Herbicidas
                    Button {
                        path.append(AppRoute.herbicidas)
                    } label: {

                        menuButton(
                            title: "HERBICIDAS",
                            icon: "icon_herb",
                            geometry: geometry
                        )
                    }


                    // MARK: Fungicidas

                    Button {
                        path.append(AppRoute.fungicidas)
                    } label: {

                        menuButton(
                            title: "FUNGICIDAS E INSECTICIDAS",
                            icon: "icon_fung2",
                            geometry: geometry
                        )
                    }


                    // MARK: Dosificación

                    Button {
                        path.append(AppRoute.dosificacion)
                    } label: {

                        menuButton(
                            title: "DOSIFICACIÓN",
                            icon: "icon_dosi",
                            geometry: geometry
                        )
                    }


                    Spacer(minLength: geometry.size.height * 0.1)


                    // MARK: Bottom Navigation

                    HStack {

                        // Back to Start

                        Button {
                            path.removeLast(path.count)
                        } label: {

                            Text("ATRÁS")
                                .font(
                                    .custom(
                                        "GlacialIndifference-Regular",
                                        size: geometry.size.width * 0.06
                                    )
                                )
                                .foregroundColor(.black)
                        }
                        Spacer()

                        // Ayuda
                        Button {
                            path.append(AppRoute.ayuda)
                        } label: {

                            Text("AYUDA")
                                .font(
                                    .custom(
                                        "GlacialIndifference-Regular",
                                        size: geometry.size.width * 0.06
                                    )
                                )
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal, geometry.size.width * 0.1)
                    .frame(maxWidth: .infinity)
                }
                .padding(.bottom, geometry.size.height * 0.27)
            }
        }
        .navigationBarBackButtonHidden(true)
    }


    // MARK: - Reusable Menu Button

    @ViewBuilder
    func menuButton(
        title: String,
        icon: String,
        geometry: GeometryProxy
    ) -> some View {

        HStack {

            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(
                    width: geometry.size.width * 0.12,
                    height: geometry.size.width * 0.1
                )
                .padding(.leading, geometry.size.width * 0.05)


            Text(title)
                .font(
                    .custom(
                        "GlacialIndifference-Regular",
                        size: geometry.size.width * 0.06
                    )
                )
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)
        }
        .frame(
            width: geometry.size.width * 0.65,
            height: geometry.size.height * 0.1
        )
        .background(
            RoundedRectangle(cornerRadius: 80)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 80)
                        .stroke(Color.accentColor, lineWidth: 4)
                )
        )
    }
}


#Preview {
    ContentView()
}


// MARK: - Color Extension

extension Color {

    init(hex: String) {

        let hex = hex.trimmingCharacters(
            in: CharacterSet.alphanumerics.inverted
        )

        var int: UInt64 = 0

        Scanner(string: hex).scanHexInt64(&int)

        let a, r, g, b: UInt64

        switch hex.count {

        case 3:
            (a, r, g, b) = (
                255,
                (int >> 8 * 17) & 0xFF,
                (int >> 4 * 17) & 0xFF,
                (int * 17) & 0xFF
            )

        case 6:
            (a, r, g, b) = (
                255,
                (int >> 16) & 0xFF,
                (int >> 8) & 0xFF,
                int & 0xFF
            )

        case 8:
            (a, r, g, b) = (
                (int >> 24) & 0xFF,
                (int >> 16) & 0xFF,
                (int >> 8) & 0xFF,
                int & 0xFF
            )

        default:
            (a, r, g, b) = (
                255,
                0,
                0,
                0
            )
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// FUENTES
// Cambria
// GlacialIndifference-Regular
// NotoSerifDisplay-ExtraCondensed
// NotoSerifDisplay-ExtraCondensedItalic
