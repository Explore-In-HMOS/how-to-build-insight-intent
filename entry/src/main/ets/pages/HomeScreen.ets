// HomeScreen.ets
// Path: entry/src/main/ets/pages/HomeScreen.ets
// Home NavDestination: 3 shortcuts. Navigates via NavigationService.

import { NavigationService, Page } from '../services/NavigationService';
import { WatchSpacing } from '../common/WatchSpacing';

@ComponentV2
export struct HomeScreen {
  private nav: NavigationService = NavigationService.getInstance();

  @Builder
  shortcut(label: string, dest: string) {
    Button(label)
      .width('86%')
      .height(40)
      .fontSize(14)
      .fontColor(Color.White)
      .backgroundColor('#1C1C1E')
      .borderRadius(20)
      .onClick(() => {
        this.nav.navigateTo(dest);
      })
  }

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: WatchSpacing.itemGap }) {
          Text('Shortcuts')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .margin({ bottom: 4 })

          this.shortcut('Show Heart Rate', Page.HEART_RATE_PAGE)
          this.shortcut('Start Running', Page.WORKOUT_PAGE)
          this.shortcut('Call Emergency', Page.EMERGENCY_PAGE)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .padding({
          left: WatchSpacing.edgeLeft,
          right: WatchSpacing.edgeRight,
          top: WatchSpacing.edgeTop,
          bottom: WatchSpacing.edgeBottomScroll
        })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .hideTitleBar(true)
    .backgroundColor(Color.Black)
  }
}