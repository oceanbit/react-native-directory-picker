package com.rndirectorypicker;

import android.os.Build;
import android.graphics.Color;
import android.view.View;
import android.view.Window;
import android.app.Activity;

public class DirectoryPicker {
    /**
     * For usage in the React Module
     */
    public static void changeBarColors(final Activity activity, final Boolean isDarkMode, final String translucentLightStr, final String translucentDarkStr) {
        if (activity == null) {
            return;
        }
        final Window window = activity.getWindow();

    }
}
