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
  selectionBackground?: string;
  lineSelectionBackground?: string;
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

export type DiffDisplayMode = 'unified' | 'sideBySide';

export type DiffScrollBehavior = 'horizontalOnly' | 'bothAxes';

export type DiffChangeHighlightStyle = 'lineOnly' | 'inlineOnly' | 'both';

export interface ThemeDiff {
  displayMode?: DiffDisplayMode;
  scrollBehavior?: DiffScrollBehavior;
  changeHighlightStyle?: DiffChangeHighlightStyle;
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
  fileHeaderBackground?: string;
  fileHeaderText?: string;
  fileMetadataText?: string;
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

export interface CustomMenuItem {
  id: string;
  title: string;
  systemImage?: string;
}

export interface SelectionContext {
  text: string;
  startLine: number;
  endLine: number;
}

export interface CustomMenuEvent {
  itemId: string;
  text: string;
  startLine: number;
  endLine: number;
}

export interface LineSelectionInfo {
  startLine: number;
  endLine: number;
  contents: string[];
  language?: string;
}

export interface DiffsProps extends HybridViewProps {
  content: string;
  colorScheme: string;
  contentInset?: ContentInset;
  showsBlockHeaders?: boolean;
  theme?: Theme;
  customMenuItems?: CustomMenuItem[];
  onCustomMenuAction?: (event: CustomMenuEvent) => void;
  onLineSelection?: (info: LineSelectionInfo | undefined) => void;
}
export interface DiffsMethods extends HybridViewMethods {}

export type Diffs = HybridView<DiffsProps, DiffsMethods>;
