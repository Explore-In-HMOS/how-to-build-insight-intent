import { EmergencyViewModel } from '../viewmodel/EmergencyViewModel';
import { WatchSpacing } from '../common/WatchSpacing';

@ComponentV2
export struct EmergencyCallPage {
  @Local vm: EmergencyViewModel = new EmergencyViewModel();
  @Local pulse: number = 1.0;

  aboutToAppear(): void {
    this.vm.load();
    this.vm.startCall();
    this.pulse = 1.12;
  }

  aboutToDisappear(): void {
    this.vm.endCall();
  }

  private statusText(): string {
    if (!this.vm.calling) {
      return 'Call ended';
    }
    if (this.vm.status === 'Connecting…') {
      return 'Connecting…';
    }
    return `In call · ${this.vm.callSeconds}s`;
  }

  build() {
    NavDestination() {
      Column({ space: WatchSpacing.itemGap }) {
        Stack() {
          Circle({ width: 68, height: 68 })
            .fill('#3A0E0E')
            .scale({ x: this.pulse, y: this.pulse })
            .animation({
              duration: 900,
              iterations: -1,
              curve: Curve.EaseInOut,
              playMode: PlayMode.Alternate
            })
          Circle({ width: 60, height: 60 })
            .fill('#FF3B30')
          Text(this.vm.contactName.length > 0 ? this.vm.contactName.substring(0, 1) : '!')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }

        Text(this.vm.contactName)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.statusText())
          .fontSize(13)
          .fontColor(this.vm.calling ? '#30D158' : Color.Gray)

        Button('End')
          .width('86%')
          .height(40)
          .fontSize(14)
          .fontColor(Color.White)
          .backgroundColor('#FF3B30')
          .borderRadius(20)
          .onClick(() => {
            this.vm.endCall();
          })
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