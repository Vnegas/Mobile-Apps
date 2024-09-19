// Copyright 2023-2024 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
package com.example.calibracion;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class herbicidas_vol_apl extends AppCompatActivity {

    Button calcular;
    ImageView herbIcon;
    ImageView fungIcon;
    ImageView dosIcon;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_herbicidas_vol_apl);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        calcular = findViewById(R.id.buttonCalcular);
        calcular.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                calculate(v);
            }
        });

        herbIcon = findViewById(R.id.imageHerbIcon);
        herbIcon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(herbicidas_vol_apl.this, herbicidas.class);
                startActivity(intent);
            }
        });

        fungIcon = findViewById(R.id.imageFungIcon);
        fungIcon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(herbicidas_vol_apl.this, fungicidas.class);
                startActivity(intent);
            }
        });

        dosIcon = findViewById(R.id.imageDosIcon);
        dosIcon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(herbicidas_vol_apl.this, dosificacion.class);
                startActivity(intent);
            }
        });
    }

    float readNumber(int id) {
        return Float.parseFloat(((EditText)findViewById(id)).getText().toString());
    }

    boolean isEmpty (int id) {
        return ((EditText) findViewById(id)).getText().toString().trim().isEmpty();
    }

    public void calculate(View view) {
        int all = 0;
        float area = 0; float volI = 0; float volF = 0;
        if (!isEmpty(R.id.inputArea)) {
            area = readNumber(R.id.inputArea);
            all++;
        } else {
            ((TextView)findViewById(R.id.inputArea)).setHint("Agregar Dato");
            ((TextView)findViewById(R.id.inputArea)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (!isEmpty(R.id.inputArea) && area == 0) {
            all--;
            ((TextView)findViewById(R.id.inputArea)).setText("");
            ((TextView)findViewById(R.id.inputArea)).setHint("No puede ser 0");
            ((TextView)findViewById(R.id.inputArea)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (!isEmpty(R.id.inputVolumenInicial)) {
            volI = readNumber(R.id.inputVolumenInicial);
            all++;
        } else {
            ((TextView)findViewById(R.id.inputVolumenInicial)).setHint("Agregar Dato");
            ((TextView)findViewById(R.id.inputVolumenInicial)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (!isEmpty(R.id.inputVolumenFinal)) {
            volF = readNumber(R.id.inputVolumenFinal);
            all++;
        } else {
            ((TextView)findViewById(R.id.inputVolumenFinal)).setHint("Agregar Dato");
            ((TextView)findViewById(R.id.inputVolumenFinal)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (all == 3) {
            float result = ((volI - volF) * 10000) / area;
            ((TextView)findViewById(R.id.textResultado)).setText(Float.toString(result));
        } else {
            ((TextView)findViewById(R.id.textResultado)).setText("");
            ((TextView)findViewById(R.id.textResultado)).setHint("Resultado");
            ((TextView)findViewById(R.id.textResultado)).setHintTextColor(Color.parseColor("#FF000000"));
        }
    }
}