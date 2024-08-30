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

public class herbicidas_vol_fijo extends AppCompatActivity {

    Button calcular;
    ImageView herbIcon;
    ImageView fungIcon;
    ImageView dosIcon;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_herbicidas_vol_fijo);
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
                Intent intent = new Intent(herbicidas_vol_fijo.this, herbicidas.class);
                startActivity(intent);
            }
        });

        fungIcon = findViewById(R.id.imageFungIcon);
        fungIcon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(herbicidas_vol_fijo.this, fungicidas.class);
                startActivity(intent);
            }
        });

        dosIcon = findViewById(R.id.imageDosIcon);
        dosIcon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(herbicidas_vol_fijo.this, dosificacion.class);
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
        float descarga = 0; float ancho = 0; float vol = 0;
        if (!isEmpty(R.id.inputDescarga)) {
            descarga = readNumber(R.id.inputDescarga);
            all++;
        } else {
            ((TextView)findViewById(R.id.inputDescarga)).setHint("Agregar Dato");
            ((TextView)findViewById(R.id.inputDescarga)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (!isEmpty(R.id.inputDescarga) && descarga == 0) {
            all--;
            ((TextView)findViewById(R.id.inputDescarga)).setText("");
            ((TextView)findViewById(R.id.inputDescarga)).setHint("No puede ser 0");
            ((TextView)findViewById(R.id.inputDescarga)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (!isEmpty(R.id.inputAncho)) {
            ancho = readNumber(R.id.inputAncho);
            all++;
        } else {
            ((TextView)findViewById(R.id.inputAncho)).setHint("Agregar Dato");
            ((TextView)findViewById(R.id.inputAncho)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (!isEmpty(R.id.inputAncho) && ancho == 0) {
            all--;
            ((TextView)findViewById(R.id.inputAncho)).setText("");
            ((TextView)findViewById(R.id.inputAncho)).setHint("No puede ser 0");
            ((TextView)findViewById(R.id.inputAncho)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (!isEmpty(R.id.inputVolAplic)) {
            vol = readNumber(R.id.inputVolAplic);
            all++;
        } else {
            ((TextView)findViewById(R.id.inputVolAplic)).setHint("Agregar Dato");
            ((TextView)findViewById(R.id.inputVolAplic)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (all == 3) {
            float result = ((10000 / ancho) / (vol / descarga)) / 60;
            ((TextView)findViewById(R.id.textResultado)).setText(Float.toString(result));
        } else {
            ((TextView)findViewById(R.id.textResultado)).setText("");
            ((TextView)findViewById(R.id.textResultado)).setHint("Resultado");
            ((TextView)findViewById(R.id.textResultado)).setHintTextColor(Color.parseColor("#FF000000"));
        }
    }
}