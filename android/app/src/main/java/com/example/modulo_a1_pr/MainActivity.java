package com.example.modulo_a1_pr;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;

public class MainActivity extends FlutterActivity {

    String caminhoCanal = "com.example.modulo_a1_pr";
    private BroadcastReceiver broadInternet;
    private EventChannel.EventSink eventInternet;

    @Override
    protected void onDestroy() {
        unregisterReceiver(broadInternet);
        super.onDestroy();
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        broadInternet = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                eventInternet.success(verificarConexao());
            }
        };

        new EventChannel(flutterEngine.getDartExecutor(), caminhoCanal + "/internet").setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object arguments, EventChannel.EventSink events) {
                eventInternet = events;
                registerReceiver(broadInternet, new IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION));
                events.success(verificarConexao());
            }

            @Override
            public void onCancel(Object arguments) {

            }
        });

    }

    private boolean verificarConexao() {

        ConnectivityManager connectivityManager = (ConnectivityManager) getSystemService(CONNECTIVITY_SERVICE);
        NetworkInfo networkInfo = connectivityManager.getActiveNetworkInfo();

        if (networkInfo != null) {

            switch (networkInfo.getState()) {

                case  CONNECTED:
                    return  true;

            }

        }

        return  false;

    }

}