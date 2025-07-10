package com.example.frijol.fragments;

import android.content.Context;
import android.database.Cursor;
import android.os.Bundle;

import androidx.appcompat.widget.SearchView;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.TextView;

import com.example.frijol.R;
import com.example.frijol.adapters.GalleryAdapter;
import com.example.frijol.database.DBHelper;
import com.example.frijol.helpers.SpacingItems;
import com.example.frijol.models.Item;

import java.util.ArrayList;
import java.util.List;

public class GalleryFragment extends Fragment {

    private RecyclerView recyclerView;
    private GalleryAdapter adapter;
    private List<Item> itemList;
    private SearchView searchView;
    private TextView cant_item;

    public GalleryFragment() {}

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_gallery, container, false);

        searchView = view.findViewById(R.id.search_view);
        searchView.setIconifiedByDefault(false); // Esto expande el SearchView desde el inicio (opcional)
        searchView.setFocusable(true);
        searchView.setFocusableInTouchMode(true);
        searchView.clearFocus();

        cant_item = view.findViewById(R.id.cant_item);
        recyclerView = view.findViewById(R.id.gallery_recycler);

        recyclerView.setLayoutManager(new GridLayoutManager(getContext(), 2));
        int spacingInPixels = getResources().getDimensionPixelSize(R.dimen.grid_spacing);
        recyclerView.addItemDecoration(new SpacingItems(2, spacingInPixels, true));


        itemList = new ArrayList<>();
        loadData();

        adapter = new GalleryAdapter(itemList, getContext());
        recyclerView.setAdapter(adapter);

        cant_item.setText("La cantidad de arvenses es de " + itemList.size());

        searchView.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
            @Override public boolean onQueryTextSubmit(String query) { return false; }

            @Override public boolean onQueryTextChange(String newText) {
                adapter.filter(newText);
                cant_item.setText("La cantidad de arvenses es de " + adapter.getItemCount());
                return true;
            }
        });

        view.setOnTouchListener((v, event) -> {
            View currentFocus = requireActivity().getCurrentFocus();
            if (currentFocus != null && currentFocus != searchView) {
                hideKeyboard(currentFocus);
            }
            return false;
        });

        recyclerView.setOnTouchListener((v, event) -> {
            // Oculta el teclado si no estás tocando el SearchView
            if (searchView.hasFocus()) {
                hideKeyboard(searchView);
                searchView.clearFocus();
            }
            return false; // permite que el RecyclerView siga funcionando normalmente
        });


        return view;
    }

    private void loadData() {
        DBHelper dbHelper = new DBHelper(getContext());
        itemList.clear(); // en caso de recargar
        itemList.addAll(dbHelper.getAllSpecies()); // ← Usa la lista directamente
        Log.d("GalleryFragment", "Species loaded: " + itemList.size()); // ← esto
    }

    private void hideKeyboard(View view) {
        view.clearFocus();
        InputMethodManager imm = (InputMethodManager) requireContext().getSystemService(Context.INPUT_METHOD_SERVICE);
        if (imm != null) {
            imm.hideSoftInputFromWindow(view.getWindowToken(), 0);
        }
    }

}
