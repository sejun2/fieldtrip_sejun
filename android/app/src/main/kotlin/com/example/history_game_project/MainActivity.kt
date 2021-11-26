package com.example.history_game_project

import android.os.Bundle
import com.google.android.gms.ads.RequestConfiguration
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    private fun setTestDeviceIds(){
        RequestConfiguration.Builder().
        setTestDeviceIds(listOf("C2AF292DA4D38E466AE8E6D72B31BD83"))
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

//        setTestDeviceIds()
    }
}
