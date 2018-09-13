package com.xun.sample

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant



class MainActivity() : FlutterActivity() {

    companion object {
        val CHANNEL = "samples.flutter.io/battery"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { p0, p1 ->
            if (p0.method.equals("getBatteryLevel")) {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    p1.success(batteryLevel)
                } else {
                    p1.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                p1.notImplemented()
            }
        }

        GeneratedPluginRegistrant.registerWith(this)
    }

    private fun getBatteryLevel(): Int {
        var batteryLevel = -1
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }
        return  batteryLevel
    }
}
