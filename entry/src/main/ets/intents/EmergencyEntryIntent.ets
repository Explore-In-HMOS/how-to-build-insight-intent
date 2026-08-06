// "call emergency" -> @InsightIntentEntry. Shows HOW the entry flow is wired:
// onExecute routes into the app through the shared NavigationService (no router,
// no dead loadContent path). Returns the result via Promise.resolve (doc fix).

import { insightIntent, InsightIntentEntry, InsightIntentEntryExecutor } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { NavigationService, Page } from '../services/NavigationService';

const LOG_TAG: string = 'testTag-EntryIntent';

@InsightIntentEntry({
  intentName: 'CallEmergency',
  domain: 'SafetyDomain',
  intentVersion: '1.0.1',
  displayName: 'Call Emergency',
  displayDescription: 'Call the preset emergency contact',
  icon: $r('app.media.startIcon'), 
  llmDescription: 'Calls the preset emergency contact',
  keywords: ['call emergency', 'emergency', 'sos'],
  abilityName: 'EntryAbility',
  executeMode: [insightIntent.ExecuteMode.UI_ABILITY_FOREGROUND],
  parameters: {
    'type': 'object',
    'title': 'CallEmergency Schema',
    'description': 'No input parameters are required',
    'properties': {},
    'additionalProperties': false
  }
})
export default class CallEmergencyIntent extends InsightIntentEntryExecutor<string> {
  onExecute(): Promise<insightIntent.IntentResult<string>> {
    hilog.info(0x0000, LOG_TAG, 'CallEmergencyIntent onExecute, mode=%{public}s', JSON.stringify(this.executeMode));

    // HOW IT'S WIRED: route into the app via the shared NavigationService singleton.
    NavigationService.getInstance().navigateTo(Page.EMERGENCY_PAGE);

    const result: insightIntent.IntentResult<string> = {
      code: 0,
      result: 'emergency-flow-started'
    };
    return Promise.resolve(result); // FIX vs doc: resolve, not reject
  }
}