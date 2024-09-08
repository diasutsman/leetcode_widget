package com.example.leetcode_widget

// New import.
import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin


/**
 * Implementation of App Widget functionality.
 */
class DailyProblemWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        for (appWidgetId in appWidgetIds) {
            // Get reference to SharedPreferences
            val widgetData = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName, R.layout.daily_problem_widget).apply {

                val title = widgetData.getString("problem_title", null)
                setTextViewText(R.id.problem_title, title ?: "No title set")

                val description = widgetData.getString("problem_difficulty", null)
                setTextViewText(R.id.problem_difficulty, description ?: "No description set")

                val accRate = widgetData.getString("problem_acc_rate", null)
                setTextViewText(R.id.problem_acc_rate, accRate ?: "No acceptance rate")
                
                val dailyStreak = widgetData.getString("streak_count", null)
                setTextViewText(R.id.daily_streak, dailyStreak ?: "No daily streak")

                val problemLink = widgetData.getString("problem_link", null);

                val uri = Uri.parse(problemLink)
                // Create an Intent to open the link in a browser
                val intent = Intent(Intent.ACTION_VIEW, uri)

                // Create a PendingIntent to open the URL in a browser
                val pendingIntent = PendingIntent.getActivity(
                    context,
                    0,
                    intent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )

                setOnClickPendingIntent(R.id.widget_container, pendingIntent)

            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }

    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}