package com.isden.meal_planner;

import android.graphics.Color;
import android.view.View;
import android.view.Window;
import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCall;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "flutter.native/helper";

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    super.configureFlutterEngine(flutterEngine);

    new MethodChannel(flutterEngine.getDartExecutor(), CHANNEL).setMethodCallHandler(
      new MethodChannel.MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall call, MethodChannel.Result result) {
          if (call.method.equals("changeNavigationBarColor")) {
            changeNavigationBarColor(call.argument("color"), call.argument("dark"));
          }
        }
      }
    );
  }

  private void changeNavigationBarColor(String color, Boolean dark) {
    final Window window = getWindow();
    int flags = window.getDecorView().getSystemUiVisibility();

    if (dark) {
      flags &= ~View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR;
    } else {
      flags |= View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR;
    }

    window.setNavigationBarColor(Color.parseColor(String.valueOf(color)));
    window.getDecorView().setSystemUiVisibility(flags);
  }
}
