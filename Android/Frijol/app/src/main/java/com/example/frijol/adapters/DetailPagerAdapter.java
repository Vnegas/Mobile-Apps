package com.example.frijol.adapters;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.viewpager2.adapter.FragmentStateAdapter;

import com.example.frijol.fragments.AtributosFragment;
import com.example.frijol.fragments.ImagesFragment;

public class DetailPagerAdapter extends FragmentStateAdapter {

    private final int itemId;

    public DetailPagerAdapter(@NonNull AppCompatActivity activity, int itemId) {
        super(activity);
        this.itemId = itemId;
    }

    @NonNull
    @Override
    public Fragment createFragment(int position) {
        if (position == 0) return AtributosFragment.newInstance(itemId);
        else return ImagesFragment.newInstance(itemId);
    }

    @Override
    public int getItemCount() {
        return 2;
    }
}

