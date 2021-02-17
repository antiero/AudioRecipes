//
//  WaveformModel.swift
//  AudioRecipes
//
//  Created by Antony Nasce on 17/02/2021.
//
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
