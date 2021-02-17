import SwiftUI

struct WaveformExampleView: View {
    @EnvironmentObject var conductor: Conductor
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                HStack{
                    VStack{
                        WaveformView(conductor.panner, color: .green, stereoMode: .left)
                        Text(conductor.testInputType.localizedName)
                            .foregroundColor(.white)
                    }
                    // TODO: Get a left/right channel
//                    VStack{
//                        WaveformView(conductor.secondCombinationMixer, color: .red, stereoMode: .right)
//                        Text("Right")
//                            .foregroundColor(.red)
//                    }
                }
                Slider(value: $conductor.masterFaderGain, in: 0...1.0)
                Text("Master Gain: \(conductor.masterFaderGain, specifier: "%.2f")")
                    .foregroundColor(.white)
                
                Slider(value: $conductor.pan, in: -1.0...1.0)
                Text("Panning: \(conductor.pan, specifier: "%.2f")")
                    .foregroundColor(.white)
                
                Picker("Audio Source", selection: $conductor.testInputType) {
                    ForEach(Conductor.TestInputType.allCases, id: \.self) { value in
                        Text(value.localizedName)
                            .tag(value)
                    }
                }
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
