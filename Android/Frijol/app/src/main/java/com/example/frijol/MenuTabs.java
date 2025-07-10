package com.example.frijol;

import android.content.Intent;
import android.os.Bundle;
import android.view.MenuInflater;
import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.viewpager2.widget.ViewPager2;

import com.example.frijol.adapters.MenuTabsAdapter;
import com.google.android.material.tabs.TabLayout;
import com.google.android.material.tabs.TabLayoutMediator;

public class MenuTabs extends AppCompatActivity {

    private ViewPager2 viewPager;
    private ImageButton popupMenuButton;
    private TabLayout tabLayout;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_menu_tabs);

        viewPager = findViewById(R.id.fragment_container);
        tabLayout = findViewById(R.id.tab_layout);
        popupMenuButton = findViewById(R.id.popup_menu_button);

        MenuTabsAdapter adapter = new MenuTabsAdapter(this);
        viewPager.setAdapter(adapter);

        new TabLayoutMediator(tabLayout, viewPager, (tab, position) -> {
            switch (position) {
                case 0:
                    tab.setText("Galería");
                    break;
                case 1:
                    tab.setText("Taxonomía");
                    break;
                case 2:
                    tab.setText("Información Adicional");
                    break;
            }
        }).attach();

        // Popup Menu
        popupMenuButton.setOnClickListener(this::showPopupMenu);
    }

    private void showPopupMenu(View anchor) {
        androidx.appcompat.widget.PopupMenu popup = new androidx.appcompat.widget.PopupMenu(this, anchor);
        MenuInflater inflater = popup.getMenuInflater();
        inflater.inflate(R.menu.popup_menu, popup.getMenu());

        popup.setOnMenuItemClickListener(item -> {
            int itemId = item.getItemId();

            if (itemId == R.id.menu_info_app) {
                Intent intent = new Intent(MenuTabs.this, MainActivity.class);
                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_SINGLE_TOP);
                startActivity(intent);
                finish();
                return true;
            } else if (itemId == R.id.menu_sobre_nosotros) {
                // Create an Intent to start the about_us Activity
                Intent intent = new Intent(MenuTabs.this, AboutUs.class);
                startActivity(intent);
                return true;
            } else {
                Intent intent = new Intent(MenuTabs.this, Ayuda.class);
                startActivity(intent);
                return true;
            }
        });

        popup.show();
    }
}
