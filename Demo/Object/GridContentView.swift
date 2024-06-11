//
//  GridContentView.swift
//  Demo
//
//  Created by CLships on 2024/6/12.
//

import SwiftUI

struct TestView1: View {
    var body: some View {
        
        Grid {
            GridRow {
                Text("Row 1")
                ForEach(0..<3) { _ in Circle().foregroundColor(.red) }
            }
            GridRow {
                Text("Row 2")
                ForEach(0..<5) { _ in Circle().foregroundColor(.green) }
            }
            GridRow {
                Text("Row 3")
                ForEach(0..<4) { _ in Circle().foregroundColor(.mint) }
            }
        }
    }
}

struct TestView2: View {
    var body: some View {
        
        Grid {
            GridRow {
                Color.pink.gridCellColumns(2)
                Grid {
                    Color.blue
                    Color.purple
                    Color.brown
                }.gridCellColumns(2)
            }
            GridRow {
                Color.orange
                Color.indigo
                Grid {
                    GridRow {
                        Color.cyan
                        Color.yellow
                    }
                    Color.mint
                    Color.green
                }.gridCellColumns(2)
            }
            GridRow {
                Grid {
                    Color.blue
                    Color.purple
                    Color.brown
                }
                Color.pink.gridCellColumns(3)
            }
        }
    }
}

#Preview {
    TestView2()
}
