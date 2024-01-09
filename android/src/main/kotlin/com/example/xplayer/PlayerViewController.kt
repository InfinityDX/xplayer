package com.example.xplayer

import android.content.Context
import android.util.Log
import androidx.media3.ui.PlayerView
import io.flutter.plugin.common.MethodCall

class PlayerViewController(private var context: Context) {
    private var playerViews = mutableMapOf<String, PlayerView>()
    private var currentPlayerViewId: String = "";
    fun getCurrentView(): PlayerView? {
        try {
            if (playerViews.isEmpty()) return null

            return playerViews[currentPlayerViewId]

        } catch (e: Exception) {
            Log.d("XPlayer", "Failed to get current PlayerView $e")
            return null;
        }
    }

    fun registerView(id: String, view: PlayerView){
        playerViews[id] = view;
    }

    fun removeView(call: MethodCall){
        val viewId = call.arguments as String? ?: return
        playerViews.remove(viewId)
    }

    fun getCurrentPlayerViewId(): String {
        return currentPlayerViewId
    }

    fun setCurrentPlayerViewId(id: String) {
         currentPlayerViewId = id
    }

    fun getPlayerViewById(id: String): PlayerView?{
        return playerViews[id];
    }
}