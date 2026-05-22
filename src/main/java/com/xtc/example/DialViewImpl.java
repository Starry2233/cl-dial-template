package com.xtc.example;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Typeface;
import android.view.View;
import com.xtc.common.BaseDial;

/**
 * Entry point for the watch face.
 * Launcher calls getDialView() to obtain the dial View.
 */
public class DialViewImpl {
    public static BaseDial getDialView(Context context, String sourceName) {
        return new ClockDial(context);
    }

    static class ClockDial extends BaseDial {
        private final Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);
        private String timeText = "12:00";

        public ClockDial(Context context) {
            super(context);
            paint.setColor(Color.WHITE);
            paint.setTextSize(48);
            paint.setTypeface(Typeface.DEFAULT_BOLD);
            paint.setTextAlign(Paint.Align.CENTER);
        }

        @Override
        protected void onDraw(Canvas canvas) {
            super.onDraw(canvas);
            int cx = getWidth() / 2;
            int cy = getHeight() / 2;
            canvas.drawColor(Color.parseColor("#22000000"));
            canvas.drawText(timeText, cx, cy + 16, paint);
        }

        @Override
        public void updateTime() {
            java.text.SimpleDateFormat sdf =
                new java.text.SimpleDateFormat("HH:mm", java.util.Locale.getDefault());
            this.timeText = sdf.format(new java.util.Date());
            invalidate();
        }

        @Override
        public void setShow(boolean show) {
            setVisibility(show ? VISIBLE : GONE);
        }

        @Override
        public String[] getMethodString() {
            return new String[]{"updateTime", "setShow"};
        }
    }
}
