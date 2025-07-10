package com.example.frijol.adapters;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import androidx.recyclerview.widget.RecyclerView;

import com.example.frijol.ItemDetail;
import com.example.frijol.R;
import com.example.frijol.models.Item;

import java.util.ArrayList;
import java.util.List;

public class GalleryAdapter extends RecyclerView.Adapter<GalleryAdapter.ItemViewHolder> {
    private List<Item> fullList;
    private List<Item> filteredList;
    private Context context;

    public GalleryAdapter(List<Item> list, Context ctx) {
        this.fullList = new ArrayList<>(list);
        this.filteredList = list;
        this.context = ctx;
    }

    public void filter(String text) {
        text = text.toLowerCase();
        filteredList = new ArrayList<>();
        for (Item item : fullList) {
            if (item.getScientific().toLowerCase().contains(text)) {
                filteredList.add(item);
            }
        }
        notifyDataSetChanged();
    }

    @Override
    public ItemViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(context).inflate(R.layout.item_card, parent, false);
        return new ItemViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ItemViewHolder holder, int position) {
        Item item = filteredList.get(position);
        holder.nameText.setText(item.getScientific());
        holder.itemView.setOnClickListener(v -> {
            Intent intent = new Intent(context, ItemDetail.class);
            intent.putExtra("ITEM_ID", item.getId());
            intent.putExtra("SCIENTIFIC_NAME", item.getScientific());
            context.startActivity(intent);
        });
    }

    @Override
    public int getItemCount() {
        return filteredList.size();
    }

    public static class ItemViewHolder extends RecyclerView.ViewHolder {
        TextView nameText;
        public ItemViewHolder(View itemView) {
            super(itemView);
            nameText = itemView.findViewById(R.id.item_name);
        }
    }
}
