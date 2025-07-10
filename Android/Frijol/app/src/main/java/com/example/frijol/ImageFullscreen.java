package com.example.frijol;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.FrameLayout;

import androidx.appcompat.app.AppCompatActivity;
import androidx.viewpager2.widget.ViewPager2;

import com.example.frijol.adapters.FullscreenImageAdapter;

import java.util.ArrayList;

public class ImageFullscreen extends AppCompatActivity implements FullscreenImageAdapter.OnOutsideImageClickListener {

    private ViewPager2 viewPager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_image_fullscreen);

        viewPager = findViewById(R.id.fullscreen_viewpager);

        Intent intent = getIntent();
        ArrayList<String> imagePaths = intent.getStringArrayListExtra("images");
        int startPosition = intent.getIntExtra("position", 0);

        FullscreenImageAdapter adapter = new FullscreenImageAdapter(this, imagePaths, this);
        viewPager.setAdapter(adapter);
        viewPager.setCurrentItem(startPosition, false);
    }

    @Override
    public void onOutsideImageClicked() {
        // Aquí cerramos la actividad cuando se toque fuera de la imagen
        finish();
    }
}
