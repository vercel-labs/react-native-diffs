import type {
  HybridView,
  HybridViewMethods,
  HybridViewProps,
} from 'react-native-nitro-modules';

export interface ContentInset {
  top: number;
  bottom: number;
}

export interface ThemeFonts {
  bodySize?: number;
  codeSize?: number;
  codeInlineSize?: number;
  titleSize?: number;
  largeTitleSize?: number;
  footnoteSize?: number;
}

export interface ThemeColors {
  body?: string;
  highlight?: string;
  emphasis?: string;
  code?: string;
  codeBackground?: string;
  selectionTint?: string;
}

export interface ThemeSpacings {
  final?: number;
  general?: number;
  list?: number;
  cell?: number;
}

export interface ThemeSizes {
  bullet?: number;
}

export interface ThemeTable {
  cornerRadius?: number;
  borderWidth?: number;
  borderColor?: string;
  headerBackgroundColor?: string;
  cellBackgroundColor?: string;
  stripeCellBackgroundColor?: string;
}

export interface ThemeImage {
  cornerRadius?: number;
  maxWidthFraction?: number;
  placeholderColor?: string;
}

export enum DiffDisplayMode {
  UNIFIED = 'unified',
  SIDE_BY_SIDE = 'sideBySide',
}

export enum DiffScrollBehavior {
  HORIZONTAL_ONLY = 'horizontalOnly',
  BOTH_AXES = 'bothAxes',
}

export interface ThemeDiff {
  displayMode?: DiffDisplayMode;
  scrollBehavior?: DiffScrollBehavior;
  contextCollapseThreshold?: number;
  visibleContextLines?: number;
  gutterBackground?: string;
  gutterText?: string;
  backgroundColor?: string;
  addedLineBackground?: string;
  removedLineBackground?: string;
  addedHighlightBackground?: string;
  removedHighlightBackground?: string;
  hunkHeaderBackground?: string;
  hunkHeaderText?: string;
  separatorColor?: string;
  borderWidth?: number;
  borderColor?: string;
}

export interface Theme {
  fonts?: ThemeFonts;
  colors?: ThemeColors;
  spacings?: ThemeSpacings;
  sizes?: ThemeSizes;
  table?: ThemeTable;
  image?: ThemeImage;
  diff?: ThemeDiff;
}

export interface DiffsProps extends HybridViewProps {
  content: string;
  colorScheme: string;
  contentInset?: ContentInset;
  showsBlockHeaders?: boolean;
  theme?: Theme;
}
export interface DiffsMethods extends HybridViewMethods {}

export type Diffs = HybridView<DiffsProps, DiffsMethods>;
