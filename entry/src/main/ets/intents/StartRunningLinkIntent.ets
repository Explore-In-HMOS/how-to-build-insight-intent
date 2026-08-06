import { InsightIntentLink, LinkParamCategory } from '@kit.AbilityKit';

@InsightIntentLink({
  intentName: 'StartRunning',
  domain: 'FitnessDomain',
  intentVersion: '1.0.1',
  displayName: 'Start Running',
  displayDescription: 'Start a running workout',
  icon: $r('app.media.startIcon'),
  llmDescription: 'Starts a running workout and opens the workout tracker',
  keywords: ['start running', 'run', 'workout'],
  paramMappings: [{
    paramName: 'activityType',
    paramMappingName: 'activity',
    paramCategory: LinkParamCategory.LINK
  }],
  parameters: {
    'type': 'object',
    'title': 'StartRunning Schema',
    'description': 'Parameters for starting a running workout',
    'properties': {
      'activityType': {
        'type': 'string',
        'description': 'The type of activity, e.g. running',
        'minLength': 1,
        'maxLength': 50
      }
    },
    'required': ['activityType'],
    'additionalProperties': false
  }
})
export class StartRunningLink {
  private _activityType: string = 'running';

  public set activityType(value: string) {
    this._activityType = value;
  }

  public get activityType(): string {
    return this._activityType;
  }
}