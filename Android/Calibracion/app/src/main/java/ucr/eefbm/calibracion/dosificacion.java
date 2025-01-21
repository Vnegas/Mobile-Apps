// Copyright 2023-2024 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
package ucr.eefbm.calibracion;

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

public class dosificacion extends AppCompatActivity {

    Button calcular;
    ImageView herbIcon;
    ImageView fungIcon;
    ImageView dosIcon;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_dosificacion);
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
                Intent intent = new Intent(dosificacion.this, herbicidas.class);
                startActivity(intent);
            }
        });

        fungIcon = findViewById(R.id.imageFungIcon);
        fungIcon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(dosificacion.this, fungicidas.class);
                startActivity(intent);
            }
        });

        dosIcon = findViewById(R.id.imageDosIcon);
        dosIcon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(dosificacion.this, dosificacion.class);
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
        float vol = 0; float dosis = 0; float area = 0;
        if (!isEmpty(R.id.inputVolAplicado)) {
            vol = readNumber(R.id.inputVolAplicado);
            all++;
        } else {
            ((TextView)findViewById(R.id.inputVolAplicado)).setHint("Agregar Dato");
            ((TextView)findViewById(R.id.inputVolAplicado)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (!isEmpty(R.id.inputVolAplicado) && vol == 0) {
            all--;
            ((TextView)findViewById(R.id.inputVolAplicado)).setText("");
            ((TextView)findViewById(R.id.inputVolAplicado)).setHint("No puede ser 0");
            ((TextView)findViewById(R.id.inputVolAplicado)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (!isEmpty(R.id.inputDosisPc)) {
            dosis = readNumber(R.id.inputDosisPc);
            all++;
        } else {
            ((TextView)findViewById(R.id.inputDosisPc)).setHint("Agregar Dato");
            ((TextView)findViewById(R.id.inputDosisPc)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (!isEmpty(R.id.inputAreaAplicar)) {
            area = readNumber(R.id.inputAreaAplicar);
            all++;
        } else {
            ((TextView)findViewById(R.id.inputAreaAplicar)).setHint("Agregar Dato");
            ((TextView)findViewById(R.id.inputAreaAplicar)).setHintTextColor(Color.parseColor("#68FF0000"));
        }

        if (all == 3) {
            float result1 = (dosis / vol) * 1000;
            ((TextView)findViewById(R.id.textResultado1)).setText(Float.toString(result1));
            float result2 = vol * area / 10000;
            ((TextView)findViewById(R.id.textResultado2)).setText(Float.toString(result2));
            float result3 = (dosis * area / 10000) * 1000;
            ((TextView)findViewById(R.id.textResultado3)).setText(Float.toString(result3));
        } else {
            ((TextView)findViewById(R.id.textResultado1)).setText("");
            ((TextView)findViewById(R.id.textResultado1)).setHint("Resultado");
            ((TextView)findViewById(R.id.textResultado1)).setTextColor(Color.parseColor("#FF000000"));
            ((TextView)findViewById(R.id.textResultado2)).setText("");
            ((TextView)findViewById(R.id.textResultado2)).setHint("Resultado");
            ((TextView)findViewById(R.id.textResultado2)).setTextColor(Color.parseColor("#FF000000"));
            ((TextView)findViewById(R.id.textResultado3)).setText("");
            ((TextView)findViewById(R.id.textResultado3)).setHint("Resultado");
            ((TextView)findViewById(R.id.textResultado3)).setTextColor(Color.parseColor("#FF000000"));
        }
    }
}