package com.example.calibracin;

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

import com.example.myapplication.R;

public class fungicidas_area extends AppCompatActivity {

    Button calcular;
    ImageView herbIcon;
    ImageView fungIcon;
    ImageView dosIcon;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_fungicidas_area);
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
                Intent intent = new Intent(fungicidas_area.this, herbicidas.class);
                startActivity(intent);
            }
        });

        fungIcon = findViewById(R.id.imageFungIcon);
        fungIcon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(fungicidas_area.this, fungicidas.class);
                startActivity(intent);
            }
        });

        dosIcon = findViewById(R.id.imageDosIcon);
        dosIcon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(fungicidas_area.this, dosificacion.class);
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
        float areaAplic = 0; float volInicial = 0; float volFinal = 0; float areaCultivo = 0;
        if (!isEmpty(R.id.inputAreaAplic)) {
            areaAplic = readNumber(R.id.inputAreaAplic);
            all++;
        } else {
            ((TextView)findViewById(R.id.inputAreaAplic)).setHint("Agregar Dato");
            ((TextView)findViewById(R.id.inputAreaAplic)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (!isEmpty(R.id.inputAreaAplic) && areaAplic == 0) {
            all--;
            ((TextView)findViewById(R.id.inputAreaAplic)).setText("");
            ((TextView)findViewById(R.id.inputAreaAplic)).setHint("No puede ser 0");
            ((TextView)findViewById(R.id.inputAreaAplic)).setHintTextColor(Color.parseColor("#68FF0000"));
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

        if (!isEmpty(R.id.inputAreaCultivo)) {
            areaCultivo = readNumber(R.id.inputAreaCultivo);
            all++;
        } else {
            ((TextView)findViewById(R.id.inputAreaCultivo)).setHint("Agregar Dato");
            ((TextView)findViewById(R.id.inputAreaCultivo)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (all == 4) {
            float result = ((volInicial - volFinal) * areaCultivo / areaAplic);
            ((TextView)findViewById(R.id.textResultado)).setText(Float.toString(result));
        } else {
            ((TextView)findViewById(R.id.textResultado)).setText("");
            ((TextView)findViewById(R.id.textResultado)).setHint("Resultado");
            ((TextView)findViewById(R.id.textResultado)).setTextColor(Color.parseColor("#FF000000"));
        }
    }
}
