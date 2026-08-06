import { WorkoutViewModel } from '../viewmodel/WorkoutViewModel';
import { WatchSpacing } from '../common/WatchSpacing';

@ComponentV2
export struct WorkoutPage {
  @Local vm: WorkoutViewModel = new WorkoutViewModel();

  aboutToAppear(): void {
    this.vm.start();
  }

  aboutToDisappear(): void {
    this.vm.stop();
  }

  private formatTime(totalSeconds: number): string {
    const m: number = Math.floor(totalSeconds / 60);
    const s: number = totalSeconds % 60;
    const mm: string = m < 10 ? `0${m}` : `${m}`;
    const ss: string = s < 10 ? `0${s}` : `${s}`;
    return `${mm}:${ss}`;
  }

  build() {
    NavDestination() {
      Column({ space: WatchSpacing.itemGap }) {
        Stack() {
          Progress({
            value: this.vm.elapsedSeconds % 60,
            total: 60,
            type: ProgressType.Ring
          })
            .width(128)
            .height(128)
            .color('#30D158')
            .style({ strokeWidth: 8 })

          Column({ space: 2 }) {
            Text(this.formatTime(this.vm.elapsedSeconds))
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
            Text('RUN')
              .fontSize(11)
              .fontColor(Color.Gray)
          }
        }

        Button(this.vm.running ? 'Stop' : 'Start')
          .width('86%')
          .height(40)
          .fontSize(14)
          .fontColor(Color.White)
          .backgroundColor('#1C1C1E')
          .borderRadius(20)
          .onClick(() => {
            if (this.vm.running) {
              this.vm.stop();
            } else {
              this.vm.start();
            }
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