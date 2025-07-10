package com.example.frijol;

import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.viewpager2.widget.ViewPager2;

import com.example.frijol.adapters.DetailPagerAdapter;
import com.google.android.material.tabs.TabLayout;
import com.google.android.material.tabs.TabLayoutMediator;

public class ItemDetail extends AppCompatActivity {

    private ViewPager2 viewPager;
    private TabLayout tabLayout;
    private ImageView backButton;
    private TextView titleText;
    private int itemId;
    private String scientificName;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_item_detail);

        // Obtener datos
        itemId = getIntent().getIntExtra("ITEM_ID", -1);
        scientificName = getIntent().getStringExtra("SCIENTIFIC_NAME");

        // Inicializar vistas
        viewPager = findViewById(R.id.view_pager);
        tabLayout = findViewById(R.id.tab_layout);
        backButton = findViewById(R.id.back_button);
        titleText = findViewById(R.id.title_text);

        titleText.setText(scientificName);
        backButton.setOnClickListener(v -> finish());

        // Configurar ViewPager y Tabs
        DetailPagerAdapter adapter = new DetailPagerAdapter(this, itemId);
        viewPager.setAdapter(adapter);

        new TabLayoutMediator(tabLayout, viewPager, (tab, position) -> {
            if (position == 0) tab.setText("Atributos");
            else tab.setText("Imágenes");
        }).attach();
    }
}
