import AVFoundation

/**
 Helper class used to play various sounds used within the application
 */
class AudioPlayer {
    /**
     The sound which is played when a user likes a cat.
     */
    private static let likeSound: SystemSoundID = 1111
    
    /**
     The sound which is played when a user dislikes a cat.
     */
    private static let dislikeSound: SystemSoundID = 1112
    
    /**
     The sound which is played when a user clicks on a generic
     button throughout the application.
     */
    private static let genericButtonSound: SystemSoundID = 1104
    
    /**
     Play the like button sound effect.
     */
    public static func playLikeSound() {
        AudioServicesPlaySystemSound(likeSound)
    }
    
    /**
     Play the dislike button sound effect.
     */
    public static func playDislikeSound() {
        AudioServicesPlaySystemSound(dislikeSound)
    }
    
    /**
     Play the generic button press sound effect.
     */
    public static func playGenericButtonSound() {
        AudioServicesPlaySystemSound(genericButtonSound)
    }
}
