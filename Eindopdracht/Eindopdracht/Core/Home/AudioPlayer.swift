import AVFoundation

class AudioPlayer {
    private static let likeSound: SystemSoundID = 1111
    private static let dislikeSound: SystemSoundID = 1112
    private static let genericButtonSound: SystemSoundID = 1104
    
    public static func playLikeSound() {
        AudioServicesPlaySystemSound(likeSound)
    }
    
    public static func playDislikeSound() {
        AudioServicesPlaySystemSound(dislikeSound)
    }
    
    public static func playGenericButtonSound() {
        AudioServicesPlaySystemSound(genericButtonSound)
    }
}
