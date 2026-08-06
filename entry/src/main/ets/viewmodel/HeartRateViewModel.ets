import { HeartRateRepository } from '../model/HeartRateRepository';

@ObservedV2
export class HeartRateViewModel {
  @Trace bpm: number = 0;
  private readonly repository: HeartRateRepository = HeartRateRepository.getInstance();

  // Pulls the latest mock BPM into the observable state.
  public refresh(): void {
    this.bpm = this.repository.getCurrentBpm();
  }
}