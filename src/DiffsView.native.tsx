import { getHostComponent } from 'react-native-nitro-modules';
const DiffsConfig = require('../nitrogen/generated/shared/json/DiffsConfig.json');
import type { DiffsMethods, DiffsProps } from './Diffs.nitro';

export const DiffsView = getHostComponent<DiffsProps, DiffsMethods>(
  'Diffs',
  () => DiffsConfig
);
