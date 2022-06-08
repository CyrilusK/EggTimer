import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressTimeEgg: UIProgressView!
    var player: AVAudioPlayer!
    var totalTime = 0, secondsPassed = 0
    let timesEgg = [ "Soft": 4 * 60, "Medium": 7 * 60, "Hard": 11 * 60 ]
    var timer = Timer()
    
    @IBAction func selectedHardness(_ sender: UIButton) {
        timer.invalidate()
        secondsPassed = 0
        progressTimeEgg.progress = 0.0
        
        totalTime = timesEgg[sender.currentTitle!]!
        titleLabel.text = sender.currentTitle!
        
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTime),
            userInfo: nil,
            repeats: true)
    }
    
    @objc func updateTime() -> Void {
        if secondsPassed < totalTime {
            progressTimeEgg.progress = Float(secondsPassed) / Float(totalTime)
            secondsPassed += 1
        }
        else {
            timer.invalidate()
            progressTimeEgg.progress = 1.0
            titleLabel.text = "Done"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")!
            player = try! AVAudioPlayer(contentsOf: url)
            player.play()
        }
    }
}
