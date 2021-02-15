import SwiftUI

struct WaveformExampleView: View {
    @EnvironmentObject var conductor: Conductor
    //@State var variationType : VariationType = .defaultAmplitudeView
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                    HStack{
                        VStack{
                            WaveformView(conductor.panner, stereoMode: .left)
                            Text("Left")
                                .foregroundColor(.white)
                        }
                        VStack{
                            WaveformView(conductor.secondCombinationMixer, stereoMode: .right)
                            Text("Right")
                                .foregroundColor(.white)
                        }
                    }
//                    Slider(value: $conductor.pan, in: -1.0...1.0)
//                    Text("Panning: \(conductor.pan, specifier: "%.2f")")
//                        .foregroundColor(.white)
            }
        }
        .background(Color.black)
        .navigationBarTitle(Text("Waveform View"), displayMode: .inline)
    }
}

struct WaveformExampleView_Previews: PreviewProvider {
    static var previews: some View {
        WaveformExampleView().environmentObject(Conductor.shared)
    }
}
