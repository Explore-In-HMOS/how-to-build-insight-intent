import { InsightIntentFunction, InsightIntentFunctionMethod } from '@kit.AbilityKit';
import { HeartRateRepository } from '../model/HeartRateRepository';

@InsightIntentFunction()
export class HeartRateFunction {
  @InsightIntentFunctionMethod({
    intentName: 'GetHeartRate',
    domain: 'HealthDomain',
    intentVersion: '1.0.1',
    displayName: 'Get Heart Rate',
    displayDescription: 'Return the current heart rate value',
    icon: $r('app.media.startIcon'),
    llmDescription: 'Returns the current heart rate in beats per minute',
    parameters: {
      'type': 'object',
      'title': 'GetHeartRate Schema',
      'description': 'No input parameters are required',
      'properties': {},
      'additionalProperties': false
    },
    result: {
      'type': 'object',
      'properties': {
        'bpm': {
          'type': 'number',
          'description': 'Current heart rate in beats per minute'
        }
      },
      'required': ['bpm']
    }
  })
  static getHeartRate(): number {
    return HeartRateRepository.getInstance().getCurrentBpm();
  }
}