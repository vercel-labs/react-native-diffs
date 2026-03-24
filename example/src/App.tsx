import { SafeAreaView, StyleSheet } from 'react-native';
import { DiffsView, type Theme } from 'react-native-diffs';

const d1 = `\`\`\`diff
@@ -3,9 +3,12 @@ import { useState } from 'react';
 export default function App() {
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
    displayMode: 'unified',
    changeHighlightStyle: 'both',
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
