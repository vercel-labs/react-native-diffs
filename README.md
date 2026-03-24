# React Native Diffs

<img width="2304" height="1076" alt="CleanShot 2026-03-24 at 15 15 47@2x" src="https://github.com/user-attachments/assets/ea918afe-35ca-4627-9eb7-b16640017742" />

Diff library for React Native, powered by [MarkdownView](https://github.com/HumanInterfaceDesign/MarkdownView).

## Installation

```sh
npm install react-native-diffs react-native-nitro-modules
```

## Usage

```tsx
import { DiffsView } from 'react-native-diffs';

const diff = `\`\`\`diff
@@ -11,7 +11,7 @@ export default function Home() {
 <div>
-  <h2>Design Engineer</h2>
+  <h2>Designer</h2>
 </div>
\`\`\``;

export default function App() {
  return (
    <DiffsView
      content={diff}
      colorScheme="dark"
      style={{ flex: 1 }}
    />
  );
}
```

## Examples

### Basic diff

```tsx
import { DiffsView } from 'react-native-diffs';

<DiffsView
  content={diff}
  colorScheme="dark"
  style={{ flex: 1 }}
/>
```

### Custom dark theme

```tsx
import { DiffsView, DiffDisplayMode, type Theme } from 'react-native-diffs';

const theme: Theme = {
  fonts: {
    codeSize: 15,
  },
  colors: {
    body: '#E1E2E5',
    code: '#D4D4D8',
    codeBackground: '#18181B',
    highlight: '#60A5FA',
    emphasis: '#A1A1AA',
    selectionTint: '#34D399',
  },
  diff: {
    displayMode: DiffDisplayMode.UNIFIED,
    backgroundColor: '#000000',
    gutterBackground: '#0A0A0A',
    gutterText: '#52525B',
    addedLineBackground: '#22C55E33',
    removedLineBackground: '#DC262620',
    addedHighlightBackground: '#4ADE8066',
    removedHighlightBackground: '#DC262650',
    hunkHeaderBackground: '#27272A',
    hunkHeaderText: '#71717A',
    separatorColor: '#27272A',
    borderWidth: 0,
  },
};

<DiffsView
  content={diff}
  colorScheme="dark"
  showsBlockHeaders={false}
  theme={theme}
  style={{ flex: 1, backgroundColor: '#000000' }}
/>
```

### Multiple diffs

```tsx
import { SafeAreaView, StyleSheet } from 'react-native';
import { DiffsView, DiffDisplayMode, type Theme } from 'react-native-diffs';

const d1 = `\`\`\`diff
@@ -3,9 +3,12 @@ import { useState } from 'react';
 export default function App() {
-  const [count, setCount] = useState(0);
+  const [count, setCount] = useState<number>(0);
+  const [name, setName] = useState<string>('');

   return (
     <div>
-      <button onClick={() => setCount(count + 1)}>
+      <input value={name} onChange={(e) => setName(e.target.value)} />
+      <button onClick={() => setCount((prev) => prev + 1)}>
         Count: {count}
       </button>
     </div>
\`\`\``;

const d2 = `\`\`\`diff
@@ -11,7 +11,7 @@ export default function Home() {
 <div>
-  <h2>Design Engineer</h2>
+  <h2>Designer</h2>
 </div>
\`\`\``;

const theme: Theme = {
  fonts: {
    codeSize: 15,
  },
  colors: {
    body: '#E1E2E5',
    code: '#D4D4D8',
    codeBackground: '#18181B',
    highlight: '#60A5FA',
    emphasis: '#A1A1AA',
    selectionTint: '#34D399',
  },
  diff: {
    displayMode: DiffDisplayMode.UNIFIED,
    backgroundColor: '#000000',
    gutterBackground: '#0A0A0A',
    gutterText: '#52525B',
    addedLineBackground: '#22C55E33',
    removedLineBackground: '#DC262620',
    addedHighlightBackground: '#4ADE8066',
    removedHighlightBackground: '#DC262650',
    hunkHeaderBackground: '#27272A',
    hunkHeaderText: '#71717A',
    separatorColor: '#27272A',
    borderWidth: 0,
  },
  table: {
    cornerRadius: 8,
    borderColor: '#27272A',
    headerBackgroundColor: '#1C1C1F',
    cellBackgroundColor: '#18181B',
    stripeCellBackgroundColor: '#1C1C1F',
  },
  image: {
    cornerRadius: 6,
  },
  spacings: {
    general: 10,
    list: 6,
  },
  sizes: {
    bullet: 4,
  },
};

export default function App() {
  return (
    <SafeAreaView style={styles.container}>
      <DiffsView
        content={d1}
        colorScheme="dark"
        style={styles.container}
        showsBlockHeaders={false}
        theme={theme}
      />
      <DiffsView
        content={d2}
        colorScheme="dark"
        style={styles.container}
        showsBlockHeaders={false}
        theme={theme}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#000000',
  },
});
```

## Props

| Prop | Type | Required | Description |
|------|------|----------|-------------|
| `content` | `string` | Yes | Markdown or diff content to render |
| `colorScheme` | `string` | Yes | Color scheme (`"dark"` or `"light"`) |
| `contentInset` | `ContentInset` | No | Scroll view content inset `{ top, bottom }` |
| `showsBlockHeaders` | `boolean` | No | Show code/diff block headers with copy button (default `true`) |
| `theme` | `Theme` | No | Custom theme configuration |

## Theming

Pass a `theme` prop to customize the appearance. All fields are optional — only override what you need. Colors are hex strings with optional alpha (e.g. `"#FF0000"` or `"#FF000080"`). Colors are rendered in the Display P3 color space for wider gamut on supported devices.

### Theme Structure

#### `ThemeFonts`

| Property | Type | Description |
|----------|------|-------------|
| `bodySize` | `number` | Body text font size |
| `codeSize` | `number` | Code block font size |
| `codeInlineSize` | `number` | Inline code font size |
| `titleSize` | `number` | Title font size |
| `largeTitleSize` | `number` | Large title font size |
| `footnoteSize` | `number` | Footnote font size |

#### `ThemeColors`

| Property | Type | Description |
|----------|------|-------------|
| `body` | `string` | Main text color |
| `highlight` | `string` | Highlight/accent color |
| `emphasis` | `string` | Emphasis color |
| `code` | `string` | Code text color |
| `codeBackground` | `string` | Code block background color |
| `selectionTint` | `string` | Text selection tint color |

#### `ThemeSpacings`

| Property | Type | Description |
|----------|------|-------------|
| `final` | `number` | Final spacing (default `16`) |
| `general` | `number` | General inter-block spacing (default `8`) |
| `list` | `number` | List item spacing (default `8`) |
| `cell` | `number` | Cell spacing (default `32`) |

#### `ThemeSizes`

| Property | Type | Description |
|----------|------|-------------|
| `bullet` | `number` | Bullet point size (default `4`) |

#### `ThemeTable`

| Property | Type | Description |
|----------|------|-------------|
| `cornerRadius` | `number` | Table corner radius (default `8`) |
| `borderWidth` | `number` | Table border width (default `1`) |
| `borderColor` | `string` | Border color |
| `headerBackgroundColor` | `string` | Table header background |
| `cellBackgroundColor` | `string` | Cell background |
| `stripeCellBackgroundColor` | `string` | Alternating row background |

#### `ThemeImage`

| Property | Type | Description |
|----------|------|-------------|
| `cornerRadius` | `number` | Image corner radius (default `4`) |
| `maxWidthFraction` | `number` | Max width as fraction of container (default `1.0`) |
| `placeholderColor` | `string` | Loading placeholder color |

#### `ThemeDiff`

| Property | Type | Description |
|----------|------|-------------|
| `displayMode` | `DiffDisplayMode` | `UNIFIED` or `SIDE_BY_SIDE` |
| `scrollBehavior` | `DiffScrollBehavior` | `HORIZONTAL_ONLY` or `BOTH_AXES` |
| `contextCollapseThreshold` | `number` | Lines before context is collapsed (default `8`) |
| `visibleContextLines` | `number` | Visible context lines around changes (default `2`) |
| `gutterBackground` | `string` | Gutter background color |
| `gutterText` | `string` | Gutter text color |
| `backgroundColor` | `string` | Overall diff background |
| `addedLineBackground` | `string` | Added line row color |
| `removedLineBackground` | `string` | Removed line row color |
| `addedHighlightBackground` | `string` | Word-level added highlight |
| `removedHighlightBackground` | `string` | Word-level removed highlight |
| `hunkHeaderBackground` | `string` | Hunk header background |
| `hunkHeaderText` | `string` | Hunk header text color |
| `separatorColor` | `string` | Separator color |
| `borderWidth` | `number` | Diff border width (set `0` to remove) |
| `borderColor` | `string` | Diff border color |

## Contributing

- [Development workflow](CONTRIBUTING.md#development-workflow)
- [Sending a pull request](CONTRIBUTING.md#sending-a-pull-request)
- [Code of conduct](CODE_OF_CONDUCT.md)

## License

MIT
