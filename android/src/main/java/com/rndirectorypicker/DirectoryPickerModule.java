package com.rndirectorypicker;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.uimanager.IllegalViewOperationException;

import static android.app.Activity.RESULT_OK;

public class DirectoryPickerModule extends ReactContextBaseJavaModule {
    private static final String ERROR_NO_ACTIVITY = "E_NO_ACTIVITY";
    private static final String ERROR_NO_ACTIVITY_MESSAGE = "Tried to change the navigation bar while not attached to an Activity";

    private Callback onDone;

    private static final int RQS_OPEN_DOCUMENT_TREE = 2;

    public DirectoryPickerModule(ReactApplicationContext reactContext) {
        super(reactContext);

        getReactApplicationContext().addActivityEventListener(new ActivityEventListener());
    }

    @Override
    public String getName() {
        return "DirectoryPicker";
    }

    @ReactMethod
    public void selectDirectory(final Callback onDone) {
        Activity activity = getCurrentActivity();
        if (activity == null) {
            return;
        }
        Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT_TREE);
        intent.putExtra(Intent.EXTRA_LOCAL_ONLY, true);
        activity.startActivityForResult(intent, RQS_OPEN_DOCUMENT_TREE);

        this.onDone = onDone;
    }


    private class ActivityEventListener implements com.facebook.react.bridge.ActivityEventListener {

        @Override
        public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {
           this.onActivityResult(requestCode, resultCode, data);
        }

        public void onActivityResult(int requestCode, int resultCode, Intent data) {
            Log.i("MYTAG", String.format("requestCode %s", requestCode));
            Log.i("MYTAG", String.format("resultCode %s", resultCode));

            if(resultCode == RESULT_OK && requestCode == RQS_OPEN_DOCUMENT_TREE){
                Uri uriTree = data.getData();

                Log.i("MYTAG", String.format("uriTree %s", uriTree.toString()));
            }
        }

        @Override
        public void onNewIntent(Intent intent) {
        }
    }
}
