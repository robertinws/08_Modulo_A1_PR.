package com.example.modulo_a1_pr;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.media.AudioManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;

public class MainActivity extends FlutterActivity {

    String caminhoCanal = "com.example.modulo_a1_pr";
    private BroadcastReceiver broadInternet, broadFones;
    private EventChannel.EventSink eventInternet, eventFones;
    private SensorManager sensorManager;
    private Sensor sensor;
    private SensorEventListener  sensorEventListener;

    @Override
    protected void onDestroy() {
        unregisterReceiver(broadFones);
        unregisterReceiver(broadInternet);
        super.onDestroy();
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        sensorManager = (SensorManager) getSystemService(SENSOR_SERVICE);
        sensor = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);

        broadInternet = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                eventInternet.success(verificarConexao());
            }
        };

        broadFones = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                eventFones.success(verificarFones());
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

        new EventChannel(flutterEngine.getDartExecutor(), caminhoCanal + "/fones").setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object arguments, EventChannel.EventSink events) {
                eventFones = events;
                registerReceiver(broadFones, new IntentFilter(AudioManager.ACTION_HEADSET_PLUG));
                events.success(verificarFones());
            }

            @Override
            public void onCancel(Object arguments) {

            }
        });

        new EventChannel(flutterEngine.getDartExecutor(), caminhoCanal + "/sensor").setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object arguments, EventChannel.EventSink events) {

                sensorEventListener = new SensorEventListener() {
                    @Override
                    public void onSensorChanged(SensorEvent event) {
                        float valor = event.values[0];
                        events.success(valor);
                    }

                    @Override
                    public void onAccuracyChanged(Sensor sensor, int accuracy) {

                    }
                };
                sensorManager.registerListener(sensorEventListener, sensor, SensorManager.SENSOR_DELAY_NORMAL);

            }

            @Override
            public void onCancel(Object arguments) {
                sensorManager.unregisterListener(sensorEventListener);
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

    private boolean verificarFones() {

        AudioManager audioManager = (AudioManager) getSystemService(AUDIO_SERVICE);

        if (audioManager.isWiredHeadsetOn()) {
            audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, ((int) (audioManager.getStreamVolume(AudioManager.STREAM_MUSIC) * 0.7)) , 0);
            return  true;
        }

        return  false;

    }

}