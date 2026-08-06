export class EmergencyContact {
  name: string = '';
  phone: string = '';
}

export class EmergencyContactRepository {
  private static instance: EmergencyContactRepository | null = null;
  private readonly contact: EmergencyContact = { name: 'Mom', phone: '+90 555 123 4567' };

  private constructor() {
  }

  public static getInstance(): EmergencyContactRepository {
    if (EmergencyContactRepository.instance === null) {
      EmergencyContactRepository.instance = new EmergencyContactRepository();
    }
    return EmergencyContactRepository.instance;
  }

  public getContact(): EmergencyContact {
    const copy: EmergencyContact = { name: this.contact.name, phone: this.contact.phone };
    return copy;
  }
}