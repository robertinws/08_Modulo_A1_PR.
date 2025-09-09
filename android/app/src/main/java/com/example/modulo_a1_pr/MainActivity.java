package com.example.modulo_a1_pr;

import android.app.ComponentCaller;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.media.AudioManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.util.Base64;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    String caminhoCanal = "com.example.modulo_a1_pr";
    private BroadcastReceiver broadInternet, broadFones;
    private EventChannel.EventSink eventInternet, eventFones;
    private SensorManager sensorManager;
    private Sensor sensor;
    private SensorEventListener  sensorEventListener;
    private MethodChannel.Result resultado;

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

        new MethodChannel(flutterEngine.getDartExecutor(), caminhoCanal + "/main").setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {

                List<Object> args = call.arguments();
                resultado = result;

                switch (call.method) {

                    case "imagens":

                        Intent intent = new Intent(Intent.ACTION_PICK);
                        intent.setType("image/*");
                        intent.putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true);
                        startActivityForResult(intent, 1000);

                        break;

                }

            }
        });

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

    @Override
    public void onActivityResult(int requestCode, int resultCode, @Nullable Intent data, @NonNull ComponentCaller caller) {
        super.onActivityResult(requestCode, resultCode, data, caller);

        if (requestCode == 1000 && data != null && data.getClipData() != null) {

            List<String> list = new ArrayList<>();

            for (int i = 0; i < data.getClipData().getItemCount(); i++) {

                try{

                    Uri uri = (Uri) data.getClipData().getItemAt(i).getUri();
                    if (uri != null) {

                        InputStream inputStream = getContentResolver().openInputStream(uri);
                        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                        Bitmap bitmap = BitmapFactory.decodeStream(inputStream);
                        bitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream);
                        byte[] bytes = byteArrayOutputStream.toByteArray();
                        list.add(Base64.encodeToString(bytes, Base64.NO_WRAP));

                    }

                }catch (Exception e){
                    e.printStackTrace();
                }

            }

            resultado.success(list);

        }

    }
}