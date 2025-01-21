package ucr.eefbm.calibracion;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.net.Uri;
import android.widget.TextView;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class ayuda extends AppCompatActivity {
    Button politicas;
    Button ayuda;
    TextView atras;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_ayuda);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        ayuda = findViewById(R.id.ayuda);
        ayuda.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                goToUrl("https://www.youtube.com/watch?v=ufisItmEEpU&ab_channel=Malezas%26Arvenses");

            }
        });

        politicas = findViewById(R.id.politic);
        politicas.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                goToUrl("https://arvenses-eeafbm.ucr.ac.cr/index.php/es/politicas-de-privacidad/calibracion-politicas-de-privacidad");

            }
        });

        atras = findViewById(R.id.buttonAtras);
        atras.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(ayuda.this, menu.class);
                startActivity(intent);
            }
        });
    }

    private void goToUrl(String s) {
        Uri uri = Uri.parse(s);
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
        startActivity(intent);
    }
}