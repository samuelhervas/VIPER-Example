
import Foundation

/**
 Resource keys avaiable for the app. Use this keys to access:
 - Images (Asset)
 - Storyboards (Storyboard)
 - Views in  corresponding Storyboards (View)
 */
enum ResourceKey {
    
    
    enum Storyboard : String {
        case
        main = "Main"
    }
    
    
    enum View : String {
        case mainNavigationController = "MainNavigatorController"
        case splash = "SplashView"
        case sneakersList = "SneakersListView"
        case filter = "FilterView"
    }
}
