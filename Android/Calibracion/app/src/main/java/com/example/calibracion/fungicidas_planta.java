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

public class fungicidas_planta extends AppCompatActivity {

    Button calcular;
    ImageView herbIcon;
    ImageView fungIcon;
    ImageView dosIcon;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_fungicidas_planta);
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
                Intent intent = new Intent(fungicidas_planta.this, herbicidas.class);
                startActivity(intent);
            }
        });

        fungIcon = findViewById(R.id.imageFungIcon);
        fungIcon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(fungicidas_planta.this, fungicidas.class);
                startActivity(intent);
            }
        });

        dosIcon = findViewById(R.id.imageDosIcon);
        dosIcon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(fungicidas_planta.this, dosificacion.class);
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
        float cantPlantasAplic = 0; float volInicial = 0; float volFinal = 0; float cantPlantasTotales = 0;
        if (!isEmpty(R.id.inputCantPlantasAplic)) {
            cantPlantasAplic = readNumber(R.id.inputCantPlantasAplic);
            all++;
        } else {
            ((TextView)findViewById(R.id.inputCantPlantasAplic)).setHint("Agregar Dato");
            ((TextView)findViewById(R.id.inputCantPlantasAplic)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (!isEmpty(R.id.inputCantPlantasAplic) && cantPlantasAplic == 0) {
            all--;
            ((TextView)findViewById(R.id.inputCantPlantasAplic)).setText("");
            ((TextView)findViewById(R.id.inputCantPlantasAplic)).setHint("No puede ser 0");
            ((TextView)findViewById(R.id.inputCantPlantasAplic)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (!isEmpty(R.id.inputVolInicial)) {
            volInicial = readNumber(R.id.inputVolInicial);
            all++;
        } else {
            ((TextView)findViewById(R.id.inputVolInicial)).setHint("Agregar Dato");
            ((TextView)findViewById(R.id.inputVolInicial)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (!isEmpty(R.id.inputVolFinal)) {
            volFinal = readNumber(R.id.inputVolFinal);
            all++;
        } else {
            ((TextView)findViewById(R.id.inputVolFinal)).setHint("Agregar Dato");
            ((TextView)findViewById(R.id.inputVolFinal)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (!isEmpty(R.id.inputCantPlantasTotales)) {
            cantPlantasTotales = readNumber(R.id.inputCantPlantasTotales);
            all++;
        } else {
            ((TextView)findViewById(R.id.inputCantPlantasTotales)).setHint("Agregar Dato");
            ((TextView)findViewById(R.id.inputCantPlantasTotales)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (all == 4) {
            float result = ((volInicial - volFinal) * cantPlantasTotales / cantPlantasAplic);
            ((TextView)findViewById(R.id.textResultado)).setText(Float.toString(result));
        } else {
            ((TextView)findViewById(R.id.textResultado)).setText("");
            ((TextView)findViewById(R.id.textResultado)).setHint("Resultado");
            ((TextView)findViewById(R.id.textResultado)).setTextColor(Color.parseColor("#FF000000"));
        }
    }
}