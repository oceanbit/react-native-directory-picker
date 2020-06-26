declare module "react-native-directory-picker" {
    export function selectDirectory(
        onDone: (path: string) => void,
    ): void;
}
