import { NavigationService, Page } from '../services/NavigationService';
import { HomeScreen } from './HomeScreen';
import { HeartRateDashboardPage } from './HeartRateDashboardPage';
import { WorkoutPage } from './WorkoutPage';
import { EmergencyCallPage } from './EmergencyCallPage';

@Entry
@ComponentV2
struct NavigationPage {
  navigationService: NavigationService = NavigationService.getInstance();

  @Builder
  routeMap(name: string) {
    if (name === Page.HOME_PAGE) {
      HomeScreen()
    } else if (name === Page.HEART_RATE_PAGE) {
      HeartRateDashboardPage()
    } else if (name === Page.WORKOUT_PAGE) {
      WorkoutPage()
    } else if (name === Page.EMERGENCY_PAGE) {
      EmergencyCallPage()
    }
  }

  build() {
    Navigation(this.navigationService.pageInfos)
      .id('mainNav')                         // <-- matches @InsightIntentPage navigationId
      .onAppear(() => {
        this.navigationService.navigateTo(Page.HOME_PAGE);
      })
      .mode(NavigationMode.Stack)
      .navDestination(this.routeMap)
      .hideTitleBar(true)
      .width('100%')
      .height('100%')
      .backgroundColor(Color.Black)
  }
}