import { EmergencyContact, EmergencyContactRepository } from '../model/EmergencyContactRepository';

@ObservedV2
export class EmergencyViewModel {
  @Trace contactName: string = '';
  @Trace contactPhone: string = '';
  @Trace calling: boolean = false;
  @Trace status: string = 'Idle';
  @Trace callSeconds: number = 0;
  private readonly repository: EmergencyContactRepository = EmergencyContactRepository.getInstance();
  private connectId: number = -1;
  private tickId: number = -1;

  public load(): void {
    const c: EmergencyContact = this.repository.getContact();
    this.contactName = c.name;
    this.contactPhone = c.phone;
  }

  // MOCK FLOW: Connecting… -> (1.5s) Calling… + running second counter.
  public startCall(): void {
    this.endCall();

    this.calling = true;
    this.status = 'Connecting…';
    this.callSeconds = 0;

    this.connectId = setTimeout(() => {
      this.status = 'Calling…';
      this.tickId = setInterval(() => {
        this.callSeconds += 1;
      }, 1000);
    }, 1500);
  }

  public endCall(): void {
    this.calling = false;
    this.status = 'Idle';
    this.callSeconds = 0;
    if (this.connectId !== -1) {
      clearTimeout(this.connectId);
      this.connectId = -1;
    }
    if (this.tickId !== -1) {
      clearInterval(this.tickId);
      this.tickId = -1;
    }
  }
}