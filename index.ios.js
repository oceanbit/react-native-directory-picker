import { NativeModules } from "react-native";

const { DirectoryPicker } = NativeModules;

const selectDirectory = () => {
    return DirectoryPicker.pickFolder();
};

export { selectDirectory };
