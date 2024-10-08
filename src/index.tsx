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

export function setAppIcon(iconName: string): Promise<void> {
  return AppIcons.setAppIcon(iconName);
}

export function resetAppIcon(): Promise<void> {
  return AppIcons.resetAppIcon();
}
