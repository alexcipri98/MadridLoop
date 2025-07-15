//
//  LoadingView.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 15/7/25.
//

import SwiftUI

struct LoadingView: View {

    var body: some View {
        VStack(spacing: 24) {
            HStack(spacing: 8) {
                ForEach(0..<3) { index in
                    Circle()
                        .frame(width: 10 + CGFloat(index) * 4, height: 10 + CGFloat(index) * 4)
                        .foregroundColor(.red)
                }
            }

            Text("Cargando Madrid…")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}
