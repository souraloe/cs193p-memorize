//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Vlad Ovcharov on 02.02.2021.
//

import SwiftUI

struct ThemeEditor: View {
    var themesStore: ThemeViewModel
    
    @Binding var chosenTheme: GameTheme
    @Binding var isShowing: Bool
    
    @State private var themeName: String = ""
    @State private var newEmoji: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text(chosenTheme.name).font(.headline).padding()
                HStack {
                    Spacer()
                    Button(action: {
                        self.isShowing = false
                        self.themesStore.update(theme: self.chosenTheme)
                    }) {
                        Text("Done")
                    }.padding()
                }
            }
            Divider()
            Form {
                Section {
                    TextField("Theme Name", text: self.$themeName, onEditingChanged: { began in
                        if !began {
                            self.chosenTheme.name = self.themeName
                        }
                    })
                }
                Section (header: SectionHeader("Add Emoji")) {
                    HStack {
                        TextField("Emoji", text: self.$newEmoji)
                        Spacer()
                        Button(action: {
                            if !self.newEmoji.isEmpty {
                                self.chosenTheme.cards.append(self.newEmoji)
                                self.newEmoji = ""
                            }
                        }) {
                            Text("Add")
                        }
                    }
                }
                Section (header: SectionHeader(title: "Emojis", hint: "tap to remove")) {
                    Grid(self.chosenTheme.cards.map { String($0) }, id: \.self) { emoji in
                        Text(emoji)
                            .font(Font.system(size: self.fontSize))
                            .onTapGesture {
                                if let emojiIndex = self.chosenTheme.cards.firstIndex(of: emoji) {
                                    self.chosenTheme.cards.remove(at: emojiIndex)
                                }
                            }
                    }
                    .frame(height: self.height)
                }
                Section (header: SectionHeader("Color")) {
                    ScrollView (.horizontal) {
                        HStack {
                            ForEach(self.colors, id: \.self) { color in
                                ZStack {
                                    if color.isEqual(UIColor(self.chosenTheme.color)) {
                                        Image(systemName: "tag")
                                            .imageScale(.large)
                                            .zIndex(1)
                                    }
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color(color))
                                        .padding(2)
                                        .frame(width: 50, height: 50)
                                        .onTapGesture {
                                            self.chosenTheme.color = color.rgb
                                        }
                                        .zIndex(-1)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var colors: [UIColor] {
        [UIColor.purple,
         UIColor.red,
         UIColor.blue,
         UIColor.black,
         UIColor.green,
         UIColor.yellow,
         UIColor.orange,
         UIColor.gray]
    }
    
    // MARK: - Drawing Constants
    
    private var height: CGFloat {
        CGFloat((chosenTheme.cards.count - 1) / 6) * 70 + 70
    }
    private let fontSize: CGFloat = 40
}

struct SectionHeader: View {
    var title = ""
    var hint = ""
    
    var body: some View {
        HStack {
            Text(self.title)
            Spacer()
            Text(self.hint).font(.caption)
        }
    }
    
    init(_ title: String) {
        self.title = title
    }
    
    init(title: String, hint: String) {
        self.init(title)
        self.hint = hint
    }
}

