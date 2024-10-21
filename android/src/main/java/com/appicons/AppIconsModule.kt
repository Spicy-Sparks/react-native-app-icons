package com.appicons

import android.content.ComponentName
import android.content.pm.PackageManager
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReadableArray

class AppIconsModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  override fun getName(): String {
    return NAME
  }

  private var iconNames: Array<String> = arrayOf()

  @ReactMethod
  fun configure(iconNames: ReadableArray) {
    this.iconNames = arrayOf()
    for (i in 0 until iconNames.size()) {
      this.iconNames += iconNames.getString(i)
    }
  }

  @ReactMethod
  fun setAppIcon(appIcon: String, promise: Promise) {
    try {
      val packageManager = reactApplicationContext.packageManager

      iconNames.filterNot { it == appIcon }.forEach {
        packageManager.setComponentEnabledSetting(
          ComponentName(reactApplicationContext, it),
          PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
          PackageManager.DONT_KILL_APP
        )
      }

      packageManager.setComponentEnabledSetting(
        ComponentName(reactApplicationContext, appIcon),
        PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
        PackageManager.DONT_KILL_APP
      )

      promise.resolve(null)
    }
    catch (err: Exception) {
      promise.reject(err)
    }
  }

  @ReactMethod
  fun resetAppIcon(promise: Promise) {
    try {
      val packageManager = reactApplicationContext.packageManager

      iconNames.forEach {
        packageManager.setComponentEnabledSetting(
          ComponentName(reactApplicationContext, it),
          PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
          PackageManager.DONT_KILL_APP
        )
      }

      promise.resolve(null)
    }
    catch (err: Exception) {
      promise.reject(err)
    }
  }

  companion object {
    const val NAME = "AppIcons"
  }
}
