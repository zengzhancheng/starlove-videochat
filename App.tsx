import React from 'react';
import { StyleSheet, Text, View } from 'react-native';

export default function App() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>星恋</Text>
      <Text style={styles.subtitle}>让每一颗心都找到属于自己的星星</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#1a1a2e',
    alignItems: 'center',
    justifyContent: 'center',
  },
  title: {
    fontSize: 32,
    fontWeight: 'bold',
    color: '#FF6B6B',
    marginBottom: 20,
  },
  subtitle: {
    fontSize: 16,
    color: '#4ECDC4',
    textAlign: 'center',
  },
});
