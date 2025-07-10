package com.example.frijol.fragments;

import android.os.Bundle;

import androidx.fragment.app.Fragment;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.example.frijol.R;
import com.example.frijol.database.DBHelper;
import com.example.frijol.models.Item;

public class AtributosFragment extends Fragment {

    private TextView txtCategoria, txtFamilia, txtNombreCientifico, txtGenero;

    public static AtributosFragment newInstance(int itemId) {
        AtributosFragment frag = new AtributosFragment();
        Bundle args = new Bundle();
        args.putInt("ITEM_ID", itemId);
        frag.setArguments(args);
        return frag;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_atributos, container, false);

        txtCategoria = view.findViewById(R.id.txt_categoria);
        txtFamilia = view.findViewById(R.id.txt_familia);
        txtNombreCientifico = view.findViewById(R.id.txt_nombre_cientifico);
        txtGenero = view.findViewById(R.id.txt_genero);

        int itemId = getArguments().getInt("ITEM_ID");
        loadData(itemId);

        return view;
    }

    private void loadData(int itemId) {
        DBHelper dbHelper = new DBHelper(getContext());
        try {
            Item item = dbHelper.getSpecieDetails(itemId);
            if (item != null) {
                txtCategoria.setText(item.getCategoria());
                txtFamilia.setText(item.getFamilia());
                txtNombreCientifico.setText(item.getScientific());
                txtGenero.setText(item.getGenero());
            } else {
                Log.e("AtributosFragment", "Item no encontrado.");
            }
        } catch (Exception e) {
            Log.e("AtributosFragment", "Error al cargar datos", e);
        }

    }
}
