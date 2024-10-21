import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-app-icons' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const AppIcons = NativeModules.AppIcons
  ? NativeModules.AppIcons
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function configure(iconNames: Array<string>): Promise<void> {
  if (Platform.OS === 'ios' || Platform.OS === 'macos')
    return Promise.resolve();
  return AppIcons.configure(iconNames);
}

export function setAppIcon(iconName: string): Promise<void> {
  return AppIcons.setAppIcon(iconName);
}

export function resetAppIcon(): Promise<void> {
  return AppIcons.resetAppIcon();
}
