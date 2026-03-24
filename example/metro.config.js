const path = require('path');
const { getDefaultConfig } = require('@react-native/metro-config');

const root = path.resolve(__dirname, '..');
const rootNodeModules = path.join(root, 'node_modules');

/**
 * Metro configuration
 * https://facebook.github.io/metro/docs/configuration
 *
 * @type {import('metro-config').MetroConfig}
 */
const config = getDefaultConfig(__dirname);

config.watchFolders = [root];

config.resolver.nodeModulesPaths = [rootNodeModules];

config.resolver.extraNodeModules = {
  'react-native-diffs': root,
};

config.resolver.resolveRequest = (context, moduleName, platform) => {
  if (moduleName.startsWith('react-native-diffs')) {
    context = {
      ...context,
      mainFields: ['source', ...context.mainFields],
      unstable_conditionNames: ['source', ...context.unstable_conditionNames],
    };
  }
  return context.resolveRequest(context, moduleName, platform);
};

module.exports = config;
