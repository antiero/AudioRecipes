import SwiftUI

struct CircleCursorView: View {
    //@State private var animationAmount: CGFloat = 1
    @State var cursorColor: Color = Color.yellow
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Circle()
                    .fill(cursorColor)
                    .opacity(0.3)
                    .shadow(color: cursorColor, radius: geo.size.width * 0.01)
                Circle()
                    .fill(cursorColor)
                    .opacity(0.6)
                    .padding(geo.size.width * 0.05)
                Circle()
                    .fill(cursorColor)
                    .shadow(color: cursorColor, radius: geo.size.width * 0.1)
                    .padding(geo.size.width * 0.1)
            }
        }
    }
}

struct CircleCursorView_Previews: PreviewProvider {
    static var previews: some View {
        CircleCursorView()
    }
}