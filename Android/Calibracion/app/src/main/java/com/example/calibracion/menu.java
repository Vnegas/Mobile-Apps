// Copyright 2023-2024 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
package com.example.calibracion;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class menu extends AppCompatActivity {
    ImageView background;
    Button herbicidas;
    Button fungicidas;
    Button dosificacion;
    TextView ayuda;
    TextView atras;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_menu);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        herbicidas = findViewById(R.id.herbicidas);
        herbicidas.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Intent intent = new Intent(menu.this, herbicidas.class);
                startActivity(intent);

            }
        });

        fungicidas = findViewById(R.id.fungicidas);
        fungicidas.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Intent intent = new Intent(menu.this, fungicidas.class);
                startActivity(intent);

            }
        });

        dosificacion = findViewById(R.id.dosificacion);
        dosificacion.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Intent intent = new Intent(menu.this, dosificacion.class);
                startActivity(intent);

            }
        });

        ayuda = findViewById(R.id.buttonAyuda);
        ayuda.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                goToUrl("https://www.youtube.com/watch?v=ufisItmEEpU&ab_channel=Malezas%26Arvenses");

            }
        });

        atras = findViewById(R.id.buttonAtras);
        atras.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(menu.this, MainActivity.class);
                startActivity(intent);
            }
        });

        background = findViewById(R.id.imageView);

        // set background image to screen width and height
        DisplayMetrics displayMetrics = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);
        int height = displayMetrics.heightPixels;
        int width = displayMetrics.widthPixels;

        // Create LayoutParams with the desired width
        ViewGroup.LayoutParams params = background.getLayoutParams();
//        params.height = (height / 4);
//        params.width = width + (width / 4);
//        background.setLayoutParams(params);

    }

    private void goToUrl(String s) {
        Uri uri = Uri.parse(s);
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
        startActivity(intent);
    }
}