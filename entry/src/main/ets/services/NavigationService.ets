// NavigationService.ets
// Path: entry/src/main/ets/services/NavigationService.ets
// Singleton NavPathStack service - same pattern as previous projects.

@ObservedV2
export class NavigationService {
  static _instance: NavigationService;
  @Trace pageInfos: NavPathStack = new NavPathStack();

  static getInstance(): NavigationService {
    if (!NavigationService._instance) {
      NavigationService._instance = new NavigationService();
    }
    return NavigationService._instance;
  }

  navigateTo(name: string): void {
    this.pageInfos.pushPath({ name: name });
  }

  navigateToWithArgs(name: string, param: string): void {
    this.pageInfos.pushPath({ name: name, param: param });
  }

  back(): void {
    this.pageInfos.pop();
  }

  clearStackAndNavigate(name: string): void {
    this.pageInfos.clear();
    this.pageInfos.pushPath({ name: name });
  }
}

export enum Page {
  HOME_PAGE = 'HomePage',
  HEART_RATE_PAGE = 'HeartRatePage',
  WORKOUT_PAGE = 'WorkoutPage',
  EMERGENCY_PAGE = 'EmergencyPage'
}