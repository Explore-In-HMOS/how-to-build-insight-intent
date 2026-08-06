// "show heart rate" -> @InsightIntentPage marks this as an intent target.
// Since it's a NavDestination inside a Navigation host, we bind it the way the doc
// example does: via navDestinationName (not pagePath). navigationId matches the id
// we set on the Navigation() in the host.

import { InsightIntentPage } from '@kit.AbilityKit';
import { HeartRateViewModel } from '../viewmodel/HeartRateViewModel';
import { WatchSpacing } from '../common/WatchSpacing';

@ComponentV2
@InsightIntentPage({
  intentName: 'ShowHeartRate',
  domain: 'HealthDomain',
  intentVersion: '1.0.1',
  displayName: 'Show Heart Rate',
  displayDescription: 'Open the heart rate dashboard',
  icon: $r('app.media.startIcon'),
  llmDescription: 'Opens the heart rate health dashboard',
  keywords: ['heart rate', 'bpm', 'show heart rate'],
  uiAbility: 'EntryAbility',
  pagePath: './ets/pages/HeartRateDashboardPage',
  navigationId: 'mainNav',
  navDestinationName: 'HeartRatePage'
})
export struct HeartRateDashboardPage {
  @Local vm: HeartRateViewModel = new HeartRateViewModel();
  private timerId: number = -1;

  aboutToAppear(): void {
    this.vm.refresh();
    this.timerId = setInterval(() => {
      this.vm.refresh();
    }, 2000);
  }

  aboutToDisappear(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  build() {
    NavDestination() {
      Column({ space: WatchSpacing.itemGap }) {
        Text('Heart Rate')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(`${this.vm.bpm}`)
          .fontSize(52)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF453A')

        Text('BPM')
          .fontSize(13)
          .fontColor(Color.Gray)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .padding({
        left: WatchSpacing.edgeLeft,
        right: WatchSpacing.edgeRight,
        top: WatchSpacing.edgeTop,
        bottom: WatchSpacing.edgeBottom
      })
    }
    .hideTitleBar(true)
    .backgroundColor(Color.Black)
  }
}