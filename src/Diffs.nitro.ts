import type {
  HybridView,
  HybridViewMethods,
  HybridViewProps,
} from 'react-native-nitro-modules';

export interface ContentInset {
  top: number;
  bottom: number;
}

export interface DiffsProps extends HybridViewProps {
  content: string;
  colorScheme: string;
  contentInset?: ContentInset;
  showsBlockHeaders?: boolean;
}
export interface DiffsMethods extends HybridViewMethods {}

export type Diffs = HybridView<DiffsProps, DiffsMethods>;
