//
//  ContentView.swift
//  Calibracion
//
//  Created by vnegas on 25/9/24.
//  Copyright 2023-2024 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("menu_bg")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: /*@START_MENU_TOKEN@*/500.0/*@END_MENU_TOKEN@*/, height: 980.0)
                    
                
                LazyVStack {
                    // Title
                    Text("Calibración")
                        .foregroundColor(.white)
                        .font(.custom("NotoSerifDisplay-ExtraCondensedItalic", size: 44))
                        .fontWeight(.bold)
                        .padding()
                    
                        // Button to Herbicidas
                        NavigationLink(destination: herbicidas()) {
                            // Herbicidas icon
                            Image("icon_herb")
                                .resizable(resizingMode: .stretch)
                                .frame(width: 49.4, height: 42.9)
                            
                            Text("HERBICIDAS")
                                .font(.custom("GlacialIndifference-Regular", size: 31))
                                .frame(width: 240, height: 104, alignment: .center)
                                .foregroundColor(.accent)
                                .cornerRadius(80)
                        }.background {
                            RoundedRectangle(cornerRadius: 80)
                                .fill(.white)
                                .stroke(.accent, lineWidth: 4)
                        }
                    
                    // Button to Fungicidas
                    NavigationLink(destination: herbicidas()) {
                        // Herbicidas icon
                        Image("icon_fung2")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 49.4, height: 39.0)
                        
                        Text("FUNGICIDAS E INSECTICIDAS")
                            .font(.custom("GlacialIndifference-Regular", size: 31))
                            .frame(width: 240, height: 104, alignment: .center)
                            .foregroundColor(.accent)
                            .cornerRadius(80)
                    }.background {
                        RoundedRectangle(cornerRadius: 80)
                            .fill(.white)
                            .stroke(.accent, lineWidth: 4)
                    }
                    
                    // Button to Dosificacion
                    NavigationLink(destination: herbicidas()) {
                        // Herbicidas icon
                        Image("icon_dosi")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 49.4, height: 39.0)
                        
                        Text("DOSIFICACIÓN")
                            .font(.custom("GlacialIndifference-Regular", size: 31))
                            .frame(width: 240, height: 104, alignment: .center)
                            .foregroundColor(.accent)
                            .cornerRadius(80)
                    }.background {
                        RoundedRectangle(cornerRadius: 80)
                            .fill(.white)
                            .stroke(.accent, lineWidth: 4)
                    }
                }
            }
        }
    }
    
    
    
}

#Preview {
    ContentView()
}

// FUENTES
// Cambria
// GlacialIndifference-Regular
// NotoSerifDisplay-ExtraCondensed
// NotoSerifDisplay-ExtraCondensedItalic

/*
 init() {
     for familyName in UIFont.familyNames {
         print(familyName)
         for fontName in UIFont.fontNames(forFamilyName:
                                             familyName) {
             print("-- \(fontName)")
         }
     }
 }
 */

// ATRAS BOTON
/*
 @Environment(\.presentationMode) private var
     presentationMode: Binding<PresentationMode>
 
 
 Spacer()
     .navigationBarBackButtonHidden(true)
     .toolbar(content: {
         ToolbarItem(placement:
                 .navigationBarLeading) {
                     Button(action: {
                         presentationMode.wrappedValue.dismiss()
                     }, label: {
                         Text("Atrás").foregroundColor(.black)
                     })
                            
                }
    })
 */
