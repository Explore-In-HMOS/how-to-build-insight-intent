export class WorkoutRepository {
  private static instance: WorkoutRepository | null = null;
  private running: boolean = false;
  private elapsedSeconds: number = 0;

  private constructor() {
  }

  public static getInstance(): WorkoutRepository {
    if (WorkoutRepository.instance === null) {
      WorkoutRepository.instance = new WorkoutRepository();
    }
    return WorkoutRepository.instance;
  }

  public startRunning(): void {
    this.running = true;
    this.elapsedSeconds = 0;
  }

  public stop(): void {
    this.running = false;
  }

  public isRunning(): boolean {
    return this.running;
  }

  public getElapsedSeconds(): number {
    return this.elapsedSeconds;
  }

  public tick(): void {
    if (this.running) {
      this.elapsedSeconds += 1;
    }
  }
}