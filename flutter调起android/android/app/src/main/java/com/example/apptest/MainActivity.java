package com.example.apptest;


import android.app.AlertDialog;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);//1

    MethodChannel methodChannel = new MethodChannel(getFlutterView(), "com.example.platform_channel/dialog");//2
    methodChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {//3
      @Override
      public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if ("dialog".equals(methodCall.method)) {
          if (methodCall.hasArgument("content")) {
            showAlertDialog();
            result.success("弹出成功");
          } else {
            result.error("error", "弹出失败", "content is null");
          }
        } else {
          result.notImplemented();
        }
      }
      private void showAlertDialog() {
        AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);
        builder.setPositiveButton("确定", null);
        builder.setTitle("Flutter调用Android");
        builder.show();
      }
    });
  }
}