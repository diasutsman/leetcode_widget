package com.example.leetcode_widget

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.net.Uri
import android.widget.RemoteViews

// New import.
import es.antonborri.home_widget.HomeWidgetPlugin
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider


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
                setTextViewText(R.id.headline_title, title ?: "No title set")

                val description = widgetData.getString("problem_difficulty", null)
                setTextViewText(R.id.headline_description, description ?: "No description set")

                val accRate = widgetData.getString("problem_acc_rate", null)
                setTextViewText(R.id.problem_acc_rate, accRate ?: "No acceptance rate")

                val problemLink = widgetData.getString("problem_link", null);
                val uri = Uri.parse(problemLink)
                // Pending intent to update counter on button click
                // val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(context,
                //         Uri.parse("dailyProblemWidget://launchLeetcode"))
                // setOnClickPendingIntent(R.id.widget_container, backgroundIntent)

                val pendingIntentWithData = HomeWidgetLaunchIntent.getActivity(
                        context,
                        MainActivity::class.java,
                        Uri.parse("dailyProblemWidget://")
                        )
                setOnClickPendingIntent(R.id.widget_container, pendingIntentWithData)
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