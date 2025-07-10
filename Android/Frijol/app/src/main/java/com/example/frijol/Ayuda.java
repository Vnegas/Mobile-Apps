package com.example.frijol;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.SpannableStringBuilder;
import android.text.method.LinkMovementMethod;
import android.text.style.BulletSpan;
import android.text.style.ClickableSpan;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;

public class Ayuda extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_ayuda);

        // Galeria Vinnetas
        TextView bulletGaleria = findViewById(R.id.galeriaText);

        String[] itemsGaleria = {"Use la galería como una guía convencional ilustrada.", "Desplácese hacia arriba y hacia debajo de la lista de especies. En la parte superior de la pantalla verá el botón buscar. Introduzca un nombre, o parte de este, para buscar una especie determinada; si no aparece es porque no se incluyó en esta versión."};
        SpannableStringBuilder builderGaleria = new SpannableStringBuilder();
        for (int i = 0; i < itemsGaleria.length; i++) {
            SpannableString spannable = new SpannableString(itemsGaleria[i] + (i < itemsGaleria.length - 1 ? "\n\n" : ""));
            spannable.setSpan(new BulletSpan(30), 0, itemsGaleria[i].length(), 0); // 30px bullet gap
            builderGaleria.append(spannable);
        }
        bulletGaleria.setText(builderGaleria);

        // Taxonomia Vinnetas
        TextView bulletTaxonomia = findViewById(R.id.taxonomiaText);

        String[] itemsTaxonomia = {"Use la columna taxonomía para identificar una especie desconocida. De los atributos que se despliegan, recuerde que no tiene que seleccionarlos todos, sólo los que usted requiera. Empiece por la característica más visible de la planta."
                , "Una vez que se despliega menú, se puede desplegar submenús asociados. Si mantiene oprimido un ícono del menú o submenú se desplegará las definiciones de estos."
                , "Cuando se oprime un atributo, se marca el mismo y se reduce el número de especies en la base de datos, cuando el número de especies restantes sea bajo, oprima coincidencias, para desplegar las especies filtradas."
                , "Si oprime de nuevo un atributo, se borrará la respectiva marca."
                , "En el botón “+ Marcas”, en la parte inferior de la pantalla puede revisar los ítems seleccionados, o limpiar las marcas e iniciar de nuevo."};
        SpannableStringBuilder builderTaxonomia = new SpannableStringBuilder();
        for (int i = 0; i < itemsTaxonomia.length; i++) {
            SpannableString spannable = new SpannableString(itemsTaxonomia[i] + (i < itemsTaxonomia.length - 1 ? "\n\n" : ""));
            spannable.setSpan(new BulletSpan(30), 0, itemsTaxonomia[i].length(), 0); // 30px bullet gap
            builderTaxonomia.append(spannable);
        }
        bulletTaxonomia.setText(builderTaxonomia);

        // Coincidencias Vinnetas
        TextView bulletCoincidencias = findViewById(R.id.coincidenciasText);

        String[] itemsCoincidencias = {"La especie no está en la base de datos. Se ha hecho un importante esfuerzo para incluir tantas arvenses de frijol cómo fue posible, pero con los años será necesario seguir añadiendo especies."
                , "Hay un error en los datos. Esto es posible, si descubre algún error por favor contactar al correo: arvenses.eeafbm@ucr.ac.cr"
                , "Usted escogió un atributo incorrecto. Puede revisar los ítems escogidos de la arvense en el menú de marcas."};
        SpannableStringBuilder builderCoincidencias = new SpannableStringBuilder();
        for (int i = 0; i < itemsCoincidencias.length; i++) {
            String text = itemsCoincidencias[i];
            SpannableString spannable = new SpannableString(text + (i < itemsCoincidencias.length - 1 ? "\n\n" : ""));

            // Add bullet
            spannable.setSpan(new BulletSpan(30), 0, text.length(), Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);

            // Make second item (index 1) clickable
            if (i == 1) {
                int start = text.indexOf("arvenses.eeafbm@ucr.ac.cr");
                int end = start + "arvenses.eeafbm@ucr.ac.cr".length();

                if (start != -1) {
                    spannable.setSpan(new ClickableSpan() {
                        @Override
                        public void onClick(View widget) {
                            Intent intent = new Intent(Intent.ACTION_SENDTO);
                            intent.setData(Uri.parse("mailto:contact@example.com"));
                            widget.getContext().startActivity(intent);
                        }
                    }, start, end, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
                }
            }
            builderCoincidencias.append(spannable);
        }
        bulletCoincidencias.setText(builderCoincidencias);
        bulletCoincidencias.setMovementMethod(LinkMovementMethod.getInstance()); // Allow clicking

        Button volver = findViewById(R.id.volver_button);
        volver.setOnClickListener(v -> {
            // Create an Intent to go back to MainActivity
            Intent intent = new Intent(this, MenuTabs.class);
            startActivity(intent);
            finish();
        });
    }
}