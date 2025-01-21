// Copyright 2023-2024 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
package ucr.eefbm.calibracion;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.TextView;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import java.util.ArrayList;
import java.util.List;

public class herbicidas_vol_fijo extends AppCompatActivity implements AdapterView.OnItemSelectedListener {

    Button calcular;
    ImageView herbIcon;
    ImageView fungIcon;
    ImageView dosIcon;
    Spinner spinner;
    boolean hasResult;
    float result;

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



        spinner = findViewById(R.id.spinner);
        spinner.setOnItemSelectedListener(this);

        // Spinner Drop down elements
        List<String> medidas = new ArrayList<String>();
        medidas.add("m/s");
        medidas.add("km/h");

        // Creating adapter for spinner
        ArrayAdapter<String> dataAdapter = new ArrayAdapter<String>(this, R.layout.spinner_layout_result, medidas);

        // Drop down layout style - list view with radio button
        dataAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);

        // attaching data adapter to spinner
        spinner.setAdapter(dataAdapter);

        hasResult = false;
        result = 0;
    }

    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
        if (hasResult) {
            calculate(null);
        }
    }

    @Override
    public void onNothingSelected(AdapterView<?> arg0) { }

    float readNumber(int id) {
        return Float.parseFloat(((EditText)findViewById(id)).getText().toString());
    }

    boolean isEmpty (int id) {
        return ((EditText) findViewById(id)).getText().toString().trim().isEmpty();
    }

    public void calculate(View view) {
        int all = 0; result = 0;
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
            result = ((10000 / ancho) / (vol / descarga)) / 60;
            if (String.valueOf(spinner.getSelectedItem()).equals("km/h")) {
                result = (float) (result * 3.6);
            }
            ((TextView)findViewById(R.id.textResultado)).setText(Float.toString(result));
            hasResult = true;
        } else {
            ((TextView)findViewById(R.id.textResultado)).setText("");
            ((TextView)findViewById(R.id.textResultado)).setHint("Resultado");
            ((TextView)findViewById(R.id.textResultado)).setHintTextColor(Color.parseColor("#FF000000"));
            hasResult = false;
        }
    }
}