import { NativeModules } from "react-native";

const { DirectoryPicker } = NativeModules;

const selectDirectory = () => {
    return DirectoryPicker.selectDirectory();
};

export { selectDirectory };
