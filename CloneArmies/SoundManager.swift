import AVFoundation

class SoundManager {
    static let shared = SoundManager()

    private var audioPlayer: AVAudioPlayer?

    func playSound(named: String) {
        guard let url = Bundle.main.url(forResource: named, withExtension: "wav") else { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Could not play sound: \(error)")
        }
    }

    func playMusic(named: String) {
        guard let url = Bundle.main.url(forResource: named, withExtension: "mp3") else { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely
            audioPlayer?.play()
        } catch {
            print("Could not play music: \(error)")
        }
    }
}
