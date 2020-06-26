import { NativeModules } from "react-native";

const { DirectoryPicker } = NativeModules;

const selectDirectory = (onDone) => {
    DirectoryPicker.selectDirectory(onDone);
};

export { selectDirectory };
