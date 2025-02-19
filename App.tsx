/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React, { useEffect, useState } from "react";
import {
  StyleSheet,
  Text,
  useColorScheme,
  View,
  Button,
  AppState,
} from "react-native";
import { MMKV, Mode } from "react-native-mmkv";

import { Colors } from "react-native/Libraries/NewAppScreen";

const mmkv = new MMKV({
  id: `mmkv.default`,
  mode: Mode.MULTI_PROCESS,
  readOnly: false,
});

function App(): React.JSX.Element {
  const isDarkMode = useColorScheme() === "dark";

  const [count, setCount] = useState(mmkv.getNumber("counter") || 0);

  useEffect(() => {
    mmkv.set("counter", count);
  }, [count]);

  useEffect(() => {
    const subscription = AppState.addEventListener("change", (nextAppState) => {
      if (nextAppState === "active") {
        // Refresh is Widget changed the counter
        setCount(mmkv.getNumber("counter") || 0);
      }
    });

    return () => {
      subscription.remove();
    };
  }, []);

  const incrementCounter = () => {
    setCount((prevCount) => prevCount + 1);
  };

  return (
    <View style={styles.container}>
      <Text
        style={{ fontSize: 32, color: isDarkMode ? Colors.white : Colors.dark }}
      >
        Count: {count}
      </Text>
      <Button title="Increment" onPress={incrementCounter} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, alignItems: "center", justifyContent: "center" },
});

export default App;
