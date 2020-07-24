package com.example.mastermind;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

// import io.flutter.view.FlutterMain;


import io.flutter.app.FlutterActivity;
// import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
// import io.flutter.embedding.engine.FlutterEngineCache;
// import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
  String sharedText;
  // FlutterEngine _flutterEngine;
  private static final String TAG = "MainActivity";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    Log.d(TAG, "onCreate: Was called!");
    // FlutterEngine flutterEngine = new FlutterEngine(this);
    
    FlutterEngine flutterEngine = new FlutterEngine(this);
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    // flutterEngine.getDartExecutor().executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault());

    // FlutterEngineCache.getInstance().put("2", flutterEngine);
    Intent intent = getIntent();
    String action = intent.getAction();
    String type = intent.getType();

    if (Intent.ACTION_SEND.equals(action) && type != null) {
      Log.d(TAG, "Intent.Action_SEND was entered... ");
      if ("text/plain".equals(type)) {
        Log.d(TAG, "onCreate: handleSendText was called...");
        handleSendText(intent); // Handle text being sent
      }
    }

    new MethodChannel(getFlutterView(), "app.channel.shared.data").setMethodCallHandler(new MethodChannel.MethodCallHandler() {

      @Override
      public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        Log.d(TAG, "onMethodCall: was called");
        if (methodCall.method.contentEquals("getSharedText")) {
          Log.d(TAG, "onMethodCall: if entered...");
          result.success(sharedText);
          sharedText = null;
        }
      }
    });
  }


  void handleSendText(Intent intent) {
      Log.e(TAG, "handleSendText: was called...");
      sharedText = intent.getStringExtra(Intent.EXTRA_TEXT);
  }
}