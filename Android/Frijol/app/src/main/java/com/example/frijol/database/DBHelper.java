package com.example.frijol.database;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

import com.example.frijol.models.Item;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

public class DBHelper extends SQLiteOpenHelper {

    private static String DB_NAME = "frijol_db.db";
    private static final int DB_VERSION = 1;
    private final Context context;
    private final String DB_PATH;

    public DBHelper(Context context) {
        super(context, DB_NAME, null, DB_VERSION);
        this.context = context;
        this.DB_PATH = context.getDatabasePath(DB_NAME).getPath();

        copyDatabaseIfNeeded();
    }

    private void copyDatabaseIfNeeded() {
        File dbFile = new File(DB_PATH);
        if (!dbFile.exists()) {
            Log.d("DBHelper", "Base no existe. Se va a copiar desde assets.");

            this.getReadableDatabase(); // Crea la carpeta /databases
            close();
            try {
                InputStream inputStream = context.getAssets().open("databases/" + DB_NAME);
                OutputStream outputStream = new FileOutputStream(DB_PATH);

                byte[] buffer = new byte[1024];
                int length;
                while ((length = inputStream.read(buffer)) > 0) {
                    outputStream.write(buffer, 0, length);
                }

                outputStream.flush();
                outputStream.close();
                inputStream.close();
            } catch (IOException e) {
                throw new RuntimeException("Error copying database", e);
            }
        } else {
            Log.d("DBHelper", "Base ya existe. No se copia.");
        }
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        // No es necesario crear nada aquí
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        // Si actualizás, podés reemplazar la base o migrar
    }

    public List<Item> getAllSpecies() {
        List<Item> speciesList = new ArrayList<>();
        SQLiteDatabase db = this.getReadableDatabase();

        Cursor cursor = db.rawQuery("SELECT * FROM specie", null);
        if (cursor != null) {
            if (cursor.moveToFirst()) {
                do {
                    int id = cursor.getInt(0);
                    String scientific = cursor.getString(3);
                    speciesList.add(new Item(id, scientific));
                } while (cursor.moveToNext());
            }
            cursor.close();
        }
        return speciesList;
    }

    public Item getSpecieDetails(int specieId) {
        SQLiteDatabase db = this.getReadableDatabase();
        Item item = null;

        Log.d("DBHelper", "Buscando especie con ID: " + specieId);

        String query = "SELECT " +
                "s.scientific_name, " +
                "sc.value AS categoria, " +
                "f.family_value AS familia, " +
                "g.gender_value AS genero " +
                "FROM specie s " +
                "LEFT JOIN specie_category sc ON s.specie_category_id = sc._id " +
                "LEFT JOIN family f ON s.family_id = f._id " +
                "LEFT JOIN gender g ON s.gender_id = g._id " +
                "WHERE s._id = ?";

        Cursor cursor = db.rawQuery(query, new String[]{String.valueOf(specieId)});

        Log.d("DBHelper", "Cursor count: " + cursor.getCount());

        if (cursor.moveToFirst()) {
            String scientific = cursor.getString(cursor.getColumnIndexOrThrow("scientific_name"));
            String categoria = cursor.getString(cursor.getColumnIndexOrThrow("categoria"));
            String familia = cursor.getString(cursor.getColumnIndexOrThrow("familia"));
            String genero = cursor.getString(cursor.getColumnIndexOrThrow("genero"));

            item = new Item(specieId, scientific); // Usa tu constructor base
            item.setCategoria(categoria);
            item.setFamilia(familia);
            item.setGenero(genero);
        }

        cursor.close();
        return item;
    }

}
