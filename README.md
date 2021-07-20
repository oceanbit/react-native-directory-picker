<h1 align="center">
  React Native Directory Picker
</h1>
<div align="center">

[![Our npm path](https://badgen.net/npm/v/react-native-directory-picker)](https://www.npmjs.com/package/react-native-directory-picker/)

</div>

## Install

```
npm i --save react-native-directory-picker
```

Or

```
yarn add react-native-directory-picker
```

## Usage

### Usage in JavaScript

```jsx
import {selectDirectory} from 'react-native-directory-picker';

// ...

selectDirectory().then((path) => {
  console.log(`The path is ${path}`);
});
```
