//
//  DatePicker.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 25/7/25.
//

import Foundation
import SwiftUI

struct CustomDatePicker: View {
    let action: (_ date: Date) -> Void
    @Binding var selectedDate: Date?

    var body: some View {
        DatePicker("",
                   selection: Binding(
                    get: {
                        selectedDate ?? Date()
                    },
                    set: {
                        selectedDate = $0
                        action(selectedDate ?? Date())
                    }
                   ),
                   displayedComponents: [.date]
        )
        .labelsHidden()
        .datePickerStyle(.compact)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.orange.opacity(0.9)))
        
    }
}
