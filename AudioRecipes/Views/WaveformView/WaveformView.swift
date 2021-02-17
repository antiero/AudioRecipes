import AudioKit
import SwiftUI

class WaveformModel: ObservableObject {
    
    static let bufferSize = 256
    private var NUM_POINTS = 256
    
    @Published var waveformBuffer: [Float] = Array(repeating: 0.0, count: bufferSize)
    
    var nodeTap: RawDataTap!
    var node: Node?
    var stereoMode : StereoMode
    
    var bottomAmp: CGFloat = -1.0
    var topAmp: CGFloat = 1.0
    
    init(stereoMode: StereoMode = .center) {
        self.stereoMode = stereoMode
    }
    
    func updateNode(_ node: Node) {
        if node !== self.node {
            self.node = node
            nodeTap = RawDataTap(node,bufferSize: UInt32(NUM_POINTS)) { bufferData in
                DispatchQueue.main.async {
                    self.pushData(bufferData)
                }
            }
            nodeTap.start()
        }
    }

    func pushData(_ data: [Float]) {
        // validate data
        // extra array necessary?
        waveformBuffer = data
    }

}

struct WaveformView: View {
    @StateObject var waveformModel = WaveformModel()
    var node: Node
    @State var stereoMode : StereoMode = .center
    //@State var numberOfSegments: Int
    
    @State var shouldPlotPoints: Bool = false
    @State var shouldStroke: Bool = true
    @State var shouldFill: Bool = true
    
    @State var backgroundColor: Color = Color.black
    @State var plotPointColor: Color = Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 0.8)
    @State var strokeColor: Color = Color.white
    @State var fillColor: Color = Color(.systemBackground)
    
    @State var shouldDisplayAxisLabels: Bool = false
    
    
    init(_ node: Node,stereoMode : StereoMode = .center, numberOfSegments: Int = 20){
        self.node = node
        self._stereoMode = State(initialValue: stereoMode)
    }
//    init(_ node: Node, color: Color,stereoMode : StereoMode = .center, numberOfSegments: Int = 20){
//        self.node = node
//        self._stereoMode = State(initialValue: stereoMode)
//    }
//    init(_ node: Node, colors: Gradient,stereoMode : StereoMode = .center, numberOfSegments: Int = 20){
//        self.node = node
//        self._stereoMode = State(initialValue: stereoMode)
//    }
    
    var body: some View {
       
        GeometryReader{ geometry in
            createGraphView(width: geometry.size.width, height: geometry.size.height)
                .drawingGroup()
                .onAppear {
                    waveformModel.updateNode(node)
                }
        }
        
    }
    
    private func createGraphView(width: CGFloat, height: CGFloat) -> some View {
        return ZStack{
            backgroundColor
            if shouldStroke || shouldFill {
                createWaveformShape(width: width, height: height)
            }
            
            HorizontalAxis(minX: 0, maxX: 1024, isLogarithmicScale: false, shouldDisplayAxisLabel: shouldDisplayAxisLabels)
            VerticalAxis(minY: $waveformModel.bottomAmp, maxY: $waveformModel.topAmp, shouldDisplayAxisLabel: shouldDisplayAxisLabels)
        }
    }
    
    func createWaveformShape(width: CGFloat, height: CGFloat) -> some View {
        
        var mappedPoints = Array(repeating: CGPoint(x: 0.0, y: 0.0), count: WaveformModel.bufferSize)
        var mappedIndexedDoubles: [Double] = Array(repeating: 0.0, count: WaveformModel.bufferSize*2)
        
        // I imagine this is not good computationally
        for i in 0..<waveformModel.waveformBuffer.count {
            // TIME
            let mappedTime = map(n: Double(i), start1: 0, stop1: 256, start2: 0.0, stop2: 1.0)
            let mappedAmplitude = map(n: Double(waveformModel.waveformBuffer[i]), start1: Double(waveformModel.bottomAmp), stop1: Double(waveformModel.topAmp), start2: 1.0, stop2: 0.0)
        
            mappedIndexedDoubles[2*i] = mappedTime
            mappedIndexedDoubles[2*i+1] = mappedAmplitude
            
            mappedPoints[i] = CGPoint(x: mappedTime, y: mappedAmplitude)
            mappedIndexedDoubles[2*i+1] = mappedAmplitude
        }
       
        return ZStack{
            if shouldStroke {
                MorphableShape(controlPoints: AnimatableVector(with: mappedIndexedDoubles))
                    .stroke(strokeColor, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                    .animation(.easeInOut(duration: 0.1))
            }
            
            if shouldFill {
                MorphableShape(controlPoints: AnimatableVector(with: mappedIndexedDoubles))
                    .fill(fillColor)
                    .animation(.easeInOut(duration: 0.1))
            }
        }
    }
    
}

struct WaveformView_Previews: PreviewProvider {
    static var previews: some View {
        WaveformView(Mixer())
            .previewLayout(.fixed(width: 40, height: 500))
    }
}
