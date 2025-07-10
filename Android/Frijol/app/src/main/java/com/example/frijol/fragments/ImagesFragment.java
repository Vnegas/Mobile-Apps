package com.example.frijol.fragments;

import android.content.res.AssetManager;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.frijol.R;
import com.example.frijol.adapters.ImageAdapter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ImagesFragment extends Fragment {

    private static final String ARG_ITEM_ID = "item_id";
    private RecyclerView recyclerView;
    private int itemId;

    public static ImagesFragment newInstance(int itemId) {
        ImagesFragment fragment = new ImagesFragment();
        Bundle args = new Bundle();
        args.putInt(ARG_ITEM_ID, itemId);
        fragment.setArguments(args);
        return fragment;
    }

    public ImagesFragment() {}

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_images, container, false);
        recyclerView = view.findViewById(R.id.images_recycler);
        recyclerView.setLayoutManager(new GridLayoutManager(getContext(), 2));

        if (getArguments() != null) {
            itemId = getArguments().getInt(ARG_ITEM_ID, -1);
            loadImagesFromAssets(itemId);
        }

        return view;
    }

    private void loadImagesFromAssets(int itemId) {
        List<String> imagePaths = new ArrayList<>();
        AssetManager assetManager = getContext().getAssets();

        try {
            String[] files = assetManager.list("item_images/" + itemId);
            if (files != null) {
                for (String filename : files) {
                    String fullPath = "item_images/" + itemId + "/" + filename;
                    imagePaths.add(fullPath);
                }
            }
        } catch (IOException e) {
            Log.e("ImagesFragment", "Error leyendo assets", e);
        }

        ImageAdapter adapter = new ImageAdapter(getContext(), imagePaths);
        recyclerView.setAdapter(adapter);
    }
}
