import SwiftUI

struct ColorPickerView: View {

    @Binding var selectedColor: Color

    let colors: [Color] = [.red, .green, .yellow, .blue, .orange]

    var body: some View {
        HStack {
            ForEach(colors, id: \.self) { color in
                ZStack {
                    Circle()
                        .fill()
                        .foregroundColor(color)
                        .padding(4)
                    Circle()
                        .strokeBorder(selectedColor == color ? .gray : .clear, lineWidth: 4)
                        .scaleEffect(CGSize(width: 1.1, height: 1.1))
                }.onTapGesture {
                    selectedColor = color
                }
            }
        }.padding()
        .frame(maxWidth: .infinity, maxHeight: 100)
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
    }
}

struct ColorPickerView_Previews: PreviewProvider {

    static var previews: some View {
        ColorPickerView(selectedColor: .constant(.red))
    }
}
