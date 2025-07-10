package com.example.frijol.models;

public class Item {
    private int id;
    private String scientific;
    private String imageUri; // puede ser ruta local o URL

    public Item(int id, String scientific) {
        this.id = id;
        this.scientific = scientific;
        // this.imageUri = imageUri;
    }

    private String categoria, familia, genero;

    // Getters y setters
    public int getId() { return id; }
    public String getScientific() { return scientific; }

    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }

    public String getFamilia() { return familia; }
    public void setFamilia(String familia) { this.familia = familia; }

    public String getGenero() { return genero; }
    public void setGenero(String genero) { this.genero = genero; }

    // public String getImageUri() { return imageUri; }
}
