//
//  LoadingView.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 15/7/25.
//

import SwiftUI

struct LoadingView: View {

    var body: some View {
        TimelineView(.animation) { timeline in
            VStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.accentColor)
                    .frame(width: 60, height: 6)

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.accentColor)
                    .frame(width: 40, height: 6)

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.accentColor)
                    .frame(width: 80, height: 6)

                Text("Cargando MadridLoop…")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                Text("Si es la primera vez que accede esto puede tardar unos segundos.")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .padding()
        }
    }
}
