//
//  CheckBoxStyle.swift
//  Devote
//
//  Created by Mabast on 4/11/21.
//

import SwiftUI

struct CheckBoxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .bold, design: .rounded))
            configuration.label
        }
        .onTapGesture {
            feedback.notificationOccurred(.success)
            configuration.isOn.toggle()
            if configuration.isOn {
                playSound(sound: "sound-rise", type: "mp3")
            } else {
                playSound(sound: "sound-tap", type: "mp3")
            }
        }
    }
}

struct CheckBoxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("PlaceHolder", isOn: .constant(true))
            .toggleStyle(CheckBoxStyle())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
