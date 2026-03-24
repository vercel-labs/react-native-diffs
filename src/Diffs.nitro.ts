import type {
  HybridView,
  HybridViewMethods,
  HybridViewProps,
} from 'react-native-nitro-modules';

export interface DiffsProps extends HybridViewProps {
  color: string;
}
export interface DiffsMethods extends HybridViewMethods {}

export type Diffs = HybridView<
  DiffsProps,
  DiffsMethods
>;
