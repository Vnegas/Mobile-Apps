package com.example.frijol.adapters;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentActivity;
import androidx.viewpager2.adapter.FragmentStateAdapter;

import com.example.frijol.fragments.GalleryFragment;
import com.example.frijol.fragments.TaxonomiaFragment;
import com.example.frijol.fragments.InfoFragment;

public class MenuTabsAdapter extends FragmentStateAdapter {

    public MenuTabsAdapter(FragmentActivity fa) {
        super(fa);
    }

    @NonNull
    @Override
    public Fragment createFragment(int position) {
        if (position == 0) return new GalleryFragment();
        else if (position == 1) return new TaxonomiaFragment();
        else return new InfoFragment();
    }

    @Override
    public int getItemCount() {
        return 3; // cantidad de tabs
    }
}
