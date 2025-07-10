package com.example.frijol;

import android.content.Intent;
import android.os.Bundle;
import android.text.util.Linkify;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class AboutUs extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_about_us);

        TextView emailText = findViewById(R.id.emailText);
        TextView phoneText = findViewById(R.id.phoneText);
        TextView webText = findViewById(R.id.webText);

        Linkify.addLinks(emailText, Linkify.EMAIL_ADDRESSES);
        Linkify.addLinks(phoneText, Linkify.PHONE_NUMBERS);
        Linkify.addLinks(webText, Linkify.WEB_URLS);

        Button volver = findViewById(R.id.volver_button);
        volver.setOnClickListener(v -> {
            // Create an Intent to go back to MainActivity
            Intent intent = new Intent(this, MenuTabs.class);
            startActivity(intent);
            finish();
        });
    }
}
