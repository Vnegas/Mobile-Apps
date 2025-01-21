// Copyright 2023-2024 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
package ucr.eefbm.calibracion;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class herbicidas extends AppCompatActivity {

    Button volFijo;
    Button velFija;
    Button volAplic;
    TextView atras;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_herbicidas);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        volFijo = findViewById(R.id.buttonVolFijo);
        volFijo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Intent intent = new Intent(herbicidas.this, herbicidas_vol_fijo.class);
                startActivity(intent);

            }
        });

        velFija = findViewById(R.id.buttonVel);
        velFija.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Intent intent = new Intent(herbicidas.this, herbicidas_vel_fija.class);
                startActivity(intent);

            }
        });

        volAplic = findViewById(R.id.buttonVolApl);
        volAplic.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Intent intent = new Intent(herbicidas.this, herbicidas_vol_apl.class);
                startActivity(intent);

            }
        });

        atras = findViewById(R.id.buttonAtras);
        atras.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(herbicidas.this, menu.class);
                startActivity(intent);
            }
        });
    }
}