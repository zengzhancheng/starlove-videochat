import React, { useEffect, useState } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import * as Font from 'expo-font';
import * as SplashScreen from 'expo-splash-screen';

import LoginScreen from './src/screens/LoginScreen';
import RegisterScreen from './src/screens/RegisterScreen';
import MainScreen from './src/screens/MainScreen';
import ProfileScreen from './src/screens/ProfileScreen';
import ChatScreen from './src/screens/ChatScreen';
import VideoCallScreen from './src/screens/VideoCallScreen';
import SettingsScreen from './src/screens/SettingsScreen';
import EditProfileScreen from './src/screens/EditProfileScreen';

import AuthService from './src/services/AuthService';
import ChatService from './src/services/ChatService';
import VideoCallService from './src/services/VideoCallService';
import NotificationService from './src/services/NotificationService';

import { RootStackParamList } from './src/types';

const Stack = createStackNavigator<RootStackParamList>();

// 保持启动画面可见
SplashScreen.preventAutoHideAsync();

export default function App() {
  const [isReady, setIsReady] = useState(false);
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  useEffect(() => {
    async function prepare() {
      try {
        // 预加载字体
        await Font.loadAsync({
          'Roboto': require('./assets/fonts/Roboto-Regular.ttf'),
          'Roboto-Bold': require('./assets/fonts/Roboto-Bold.ttf'),
        });

        // 检查用户认证状态
        const authenticated = await AuthService.isAuthenticated();
        setIsAuthenticated(authenticated);

        // 初始化服务
        if (authenticated) {
          await initializeServices();
        }

        // 注册推送通知
        await NotificationService.registerForPushNotifications();
      } catch (e) {
        console.warn('App initialization error:', e);
      } finally {
        setIsReady(true);
        await SplashScreen.hideAsync();
      }
    }

    prepare();
  }, []);

  const initializeServices = async () => {
    try {
      // 连接聊天服务
      await ChatService.connectSocket();
      
      // 连接视频通话服务
      await VideoCallService.connectSocket();
    } catch (error) {
      console.error('Service initialization failed:', error);
    }
  };

  if (!isReady) {
    return null;
  }

  return (
    <SafeAreaProvider>
      <NavigationContainer>
        <StatusBar style="auto" />
        <Stack.Navigator
          screenOptions={{
            headerStyle: {
              backgroundColor: '#FF6B6B',
            },
            headerTintColor: '#fff',
            headerTitleStyle: {
              fontWeight: 'bold',
            },
          }}
        >
          {isAuthenticated ? (
            // 已登录用户
            <>
              <Stack.Screen 
                name="Main" 
                component={MainScreen}
                options={{ headerShown: false }}
              />
              <Stack.Screen 
                name="Profile" 
                component={ProfileScreen}
                options={{ title: '个人资料' }}
              />
              <Stack.Screen 
                name="Chat" 
                component={ChatScreen}
                options={{ title: '聊天' }}
              />
              <Stack.Screen 
                name="VideoCall" 
                component={VideoCallScreen}
                options={{ 
                  title: '视频通话',
                  headerShown: false 
                }}
              />
              <Stack.Screen 
                name="Settings" 
                component={SettingsScreen}
                options={{ title: '设置' }}
              />
              <Stack.Screen 
                name="EditProfile" 
                component={EditProfileScreen}
                options={{ title: '编辑资料' }}
              />
            </>
          ) : (
            // 未登录用户
            <>
              <Stack.Screen 
                name="Login" 
                component={LoginScreen}
                options={{ headerShown: false }}
              />
              <Stack.Screen 
                name="Register" 
                component={RegisterScreen}
                options={{ headerShown: false }}
              />
            </>
          )}
        </Stack.Navigator>
      </NavigationContainer>
    </SafeAreaProvider>
  );
}
