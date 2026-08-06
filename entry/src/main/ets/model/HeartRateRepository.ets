export class HeartRateRepository {
  private static instance: HeartRateRepository | null = null;
  private readonly baseBpm: number = 72;

  private constructor() {
  }

  public static getInstance(): HeartRateRepository {
    if (HeartRateRepository.instance === null) {
      HeartRateRepository.instance = new HeartRateRepository();
    }
    return HeartRateRepository.instance;
  }

   public getCurrentBpm(): number {
    const jitter: number = (Date.now() / 1000) % 7 - 3;
    return this.baseBpm + Math.round(jitter);
  }
}
