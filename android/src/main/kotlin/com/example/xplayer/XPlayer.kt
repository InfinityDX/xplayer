package com.example.xplayer

import android.content.Context
import androidx.annotation.OptIn
import androidx.media3.common.MediaItem
import androidx.media3.common.Player
import androidx.media3.common.util.UnstableApi
import androidx.media3.database.StandaloneDatabaseProvider
import androidx.media3.datasource.DataSource
import androidx.media3.datasource.DefaultHttpDataSource
import androidx.media3.datasource.cache.CacheDataSource
import androidx.media3.datasource.cache.LeastRecentlyUsedCacheEvictor
import androidx.media3.datasource.cache.SimpleCache
import androidx.media3.exoplayer.DefaultLoadControl
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.exoplayer.hls.HlsMediaSource
import androidx.media3.ui.PlayerView
import com.example.xplayer.models.XPlayerValue
import com.example.xplayer.observers.XPlayerObserver
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

@OptIn(UnstableApi::class)
class XPlayer : StreamHandler {
    private val MAX_CAHCE_SIZE = 100L * 1024 * 1024 // in MB, in this case is 100MB

    private var isInitialized = false;

    private lateinit var player: ExoPlayer
    private lateinit var context: Context

    private lateinit var dataSource: DefaultHttpDataSource.Factory
    private lateinit var cache: SimpleCache
    private lateinit var cacheDataSource: DataSource.Factory
    private lateinit var databaseProvider: StandaloneDatabaseProvider
    private var xPlayerObserver: XPlayerObserver? = null

    lateinit var playerViewController: PlayerViewController;

    fun init(context: Context): Boolean {
        return try {
            this.context = context
            playerViewController = PlayerViewController(context);
            dataSource = DefaultHttpDataSource.Factory();
            databaseProvider = StandaloneDatabaseProvider(context);
            cache = SimpleCache(
                context.cacheDir,
                LeastRecentlyUsedCacheEvictor(MAX_CAHCE_SIZE),
                databaseProvider
            )
            cacheDataSource =
                CacheDataSource.Factory().setCache(cache).setUpstreamDataSourceFactory(dataSource)

            val loadControl = DefaultLoadControl.Builder().setBufferDurationsMs(
                5000, 10000, 2000, 2000
            ).build();
            player = ExoPlayer.Builder(context).setLoadControl(loadControl).build()
            player.repeatMode = Player.REPEAT_MODE_ONE
            player.prepare();
            if (xPlayerObserver != null) player.addListener(xPlayerObserver!!)

            true
        } catch (e: Exception) {
            e
            false
        }
    }

    fun claimPlayer(call: MethodCall) {
        val viewId = call.arguments as String? ?: return
        val oldPlayerView = playerViewController.getCurrentView()
        val newPlayerView = playerViewController.getPlayerViewById(viewId) ?: return
        PlayerView.switchTargetView(player, oldPlayerView, newPlayerView)
        playerViewController.setCurrentPlayerViewId(viewId)
    }

    fun play() {
        player.play();
    }

    fun pause() {
        player.pause();
    }

    fun setPlayBackSpeed(call: MethodCall) {
        val speed = call.arguments as Double? ?: 1
        player.setPlaybackSpeed(speed.toFloat())
        player.seekTo(2L)
    }

    fun seekTo(call: MethodCall) {
        val position = call.arguments as Long? ?: 0L
        player.seekTo(position)
    }


    fun seekToNext() {
        player.seekToNext()
    }

    fun seekToPreviousMediaItem() {
        player.seekToPreviousMediaItem()
    }

    fun clearAllMediaSource() {
        player.clearMediaItems()
    }


    fun addMediaSource(call: MethodCall) {
        val arg: Any = call.arguments ?: return;
        if (arg !is HashMap<*, *>) return;

        val url = arg["url"] as String? ?: ""
        val mediaItem = MediaItem.fromUri(url)

        val hlsMediaSource = HlsMediaSource.Factory(cacheDataSource).createMediaSource(mediaItem)

        player.addMediaSource(hlsMediaSource)
    }

    fun addMediaSources(call: MethodCall, result: MethodChannel.Result) {
        val arg: Any = call.arguments ?: return;
        if (arg !is List<*>) {
            result.success("Data is not List");
            return;
        }
        try {
            val medias = mutableListOf<HlsMediaSource>();
            arg.forEach {
                it as Map<*, *>
                val url = it["url"] as String? ?: ""
                val mediaItem = MediaItem.fromUri(url)
                val hlsSource = HlsMediaSource.Factory(cacheDataSource).createMediaSource(mediaItem)

                medias.add(hlsSource)
            }
            player.addMediaSources(medias.toList())
            result.success("Success")
        } catch (e: Exception) {
            result.success("Fail")
        }
    }

    fun setMediaSource(call: MethodCall) {
        val arg: Any = call.arguments ?: return;
        if (arg !is HashMap<*, *>) return;

        val url = arg["url"] as String? ?: ""
        val mediaItem = MediaItem.fromUri(url)

        val hlsMediaSource = HlsMediaSource.Factory(cacheDataSource).createMediaSource(mediaItem)

        player.setMediaSource(hlsMediaSource)
    }

    fun setMediaSources(call: MethodCall, result: MethodChannel.Result) {
        val arg: Any = call.arguments ?: return;
        if (arg !is List<*>) {
            result.success("Data is not List");
            return;
        }
        try {
            val medias = mutableListOf<HlsMediaSource>();
            arg.forEach {
                it as Map<*, *>
                val url = it["url"] as String? ?: ""
                val mediaItem = MediaItem.fromUri(url)
                val hlsSource = HlsMediaSource.Factory(cacheDataSource).createMediaSource(mediaItem)

                medias.add(hlsSource)
            }
            player.addMediaSources(medias.toList())
            result.success("Success")
        } catch (e: Exception) {
            result.success("Fail")
        }
    }

    fun dispose(result: MethodChannel.Result?) {
        try {
            player.stop()
            player.release()
            result?.success("XPlayer Disposed")
        } catch (e: Exception) {
            result?.success("Could Not Dispose XPlayer")
        }

    }

    private fun test() {

    }

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink?) {

        xPlayerObserver = XPlayerObserver(eventSink)
//        eventSink?.success(
//            Json.encodeToString(
//                XPlayerValue(
//                    1,
//                    2,
//                    3
//                )
//            )
//        )
    }

    override fun onCancel(arguments: Any?) {
        if(xPlayerObserver == null) return
        player.removeListener(xPlayerObserver!!)
    }

    // Fake data to use
    private val data = listOf<String>(
        "https://wrs.youtubes.fan/temp/0be373aa-b4f2-40ea-9131-bb72bef5d752_11f1572f-dadd-4add-b204-b7a962031a52-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/fb116823-c82b-4faa-883e-10e30062ffbf_1fdb923c-3991-4dbb-ab20-b357531e8285-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/bd2376ce-a860-4a60-bdad-294ae3f4dfed_cfe77db9-fa48-4014-be34-760872bbd980-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/2555a9b8-4964-404e-b4a1-e5efd57f87f2_6be46a14-9abb-4403-8d70-9184dd9c8c41-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/e6bff528-b70b-4c2e-8bc7-9fd304b02cc5_5e76c009-a8f8-467c-bc42-6e832fbcffb3-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/b3c0bec3-4741-4757-8022-230f0a40a373_aa21f692-7cce-4b8c-8233-e34406c0e3da-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/9f71d63f-339d-4a91-8f13-22ad538e3679_7d2b051e-a88a-40c9-98a1-dc3f94d5e27e-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/26dba1e3-41b1-4833-ba26-56d944fcc9a8_1ec6921c-a25a-49de-a9ac-a3a5913f4a8c-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/34836643-5ce6-45be-a174-43e2c0a0cba5_695e62da-aae3-4704-bbe9-75832b1e4f82-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/e6dce46f-714f-4bf2-a672-5c89015b56e1_03e456fd-f219-4fa8-bc5f-de68c60a6c74-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/3b48e20a-e95b-466d-9b50-49cba6174f68_50af2f28-1728-4930-b7e0-2682644e60a5-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/0798b557-086c-4101-8b12-9601ce3779f5_1d617d6d-3c03-4d48-b3c7-6dc63a2f95f7-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/8fffa416-6f80-41a4-b609-41174e51bd98_48f93818-c86a-461d-9d34-c43b5121780e-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/59852964-963b-4f8a-9fcd-3cd361ece5f5_c7722d32-3821-4a22-8ad0-2dbbb28bc09f-playlist.m3u8",
        "https://wrs.youtubes.fan/867853a6-2054-4635-bdbd-d5f4b325bb4d/playlist.m3u8",
        "https://wrs.youtubes.fan/c059e798-4589-4bca-bd60-4373a9614afa/playlist.m3u8",
        "https://wrs.youtubes.fan/c7325457-6402-4af6-99dd-9962bcb2267c/playlist.m3u8",
        "https://wrs.youtubes.fan/f956897b-1a30-42df-a37d-6d831154aa31/playlist.m3u8",
        "https://wrs.youtubes.fan/f3e39554-a5be-4bf9-9448-b3474c283a51/playlist.m3u8",
        "https://wrs.youtubes.fan/a71e711d-42dc-4703-baa7-c9cc2d1e5d0d/playlist.m3u8",
        "https://wrs.youtubes.fan/4f75c9be-2f8b-4191-be79-19614e12e08d/playlist.m3u8",
        "https://wrs.youtubes.fan/4d90a793-12db-4aac-b962-e00ba3e53a3d/playlist.m3u8",
        "https://wrs.youtubes.fan/temp/e8bd0a28-910b-4cf2-93ed-c09df7fd893e_8db1a9ec-aa7b-4349-afdb-a8cedf0497fc-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/596c9964-e0d4-417c-8650-c6bee39d6127_497c34e6-5e7f-4e3a-bdb7-b6f2c9206692-playlist.m3u8",
    )
}
