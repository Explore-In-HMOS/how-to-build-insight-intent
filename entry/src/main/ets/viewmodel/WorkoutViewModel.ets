import { WorkoutRepository } from '../model/WorkoutRepository';

@ObservedV2
export class WorkoutViewModel {
  @Trace running: boolean = false;
  @Trace elapsedSeconds: number = 0;
  private readonly repository: WorkoutRepository = WorkoutRepository.getInstance();
  private timerId: number = -1;

  public start(): void {
    this.repository.startRunning();
    this.running = this.repository.isRunning();
    this.elapsedSeconds = this.repository.getElapsedSeconds();

    if (this.timerId === -1) {
      this.timerId = setInterval(() => {
        this.repository.tick();
        this.elapsedSeconds = this.repository.getElapsedSeconds();
      }, 1000);
    }
  }

  public stop(): void {
    this.repository.stop();
    this.running = this.repository.isRunning();
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }
}