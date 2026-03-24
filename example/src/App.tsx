import { SafeAreaView, StyleSheet } from 'react-native';
import { DiffsView } from 'react-native-diffs';

const d = `\`\`\`diff
diff --git a/app/globals.css b/app/globals.css
index dc2aea1..03a1384 100644
--- a/app/globals.css
+++ b/app/globals.css
@@ -4,8 +4,8 @@
 @custom-variant dark (&:is(.dark *));
 :root {
-  --background: oklch(1 0 0);
-  --foreground: oklch(0.145 0 0);
+  --background: oklch(0.577 0.245 27.325);
+  --foreground: oklch(1 0 0);
   --card: oklch(1 0 0);
   --card-foreground: oklch(0.145 0 0);
   --popover: oklch(1 0 0);
\`\`\``;

export default function App() {
  return (
    <SafeAreaView style={styles.container}>
      <DiffsView
        content={d}
        colorScheme="dark"
        style={styles.container}
        showsBlockHeaders={true}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});
