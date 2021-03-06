import SwiftUI

struct ContentView: View {
    var body: some View {
        return NavigationView{
            
            // TODO: Add a Picker to select the audio input type
            List{
                NavigationLink(destination: FFTExampleView()){
                    Image(systemName: "chart.bar.xaxis")
                    Text("FFT View")
                }
                NavigationLink(destination: SpectrumExampleView()){
                    Image(systemName: "wave.3.right.circle")
                    Text("Spectrum View")
                }
                NavigationLink(destination: FilterExampleView()){
                    Image(systemName: "f.circle")
                    Text("Filter View")
                }
                NavigationLink(destination: SpectrogramExampleView()){
                    Image(systemName: "square.stack.3d.down.right")
                    Text("Spectrogram View")
                }
                NavigationLink(destination: AmplitudeExampleView()){
                    Image(systemName: "speaker.wave.3")
                    Text("Amplitude View")
                }
                NavigationLink(destination: WavetableExampleView()){
                    Image(systemName: "waveform.path.ecg.rectangle")
                    Text("Wavetable View")
                }
                NavigationLink(destination: WavetableArrayExampleView()){
                    Image(systemName: "waveform.path.ecg.rectangle")
                    Text("Wavetable Array View")
                }
                
                NavigationLink(destination: WaveformExampleView()){
                    Image(systemName: "waveform")
                    Text("Waveform View")
                }
                
            }
            .navigationBarTitle("AudioKitUI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
