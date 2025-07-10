package com.example.frijol.adapters;

import android.content.Context;
import android.content.res.AssetManager;
import android.graphics.drawable.Drawable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.frijol.R;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public class FullscreenImageAdapter extends RecyclerView.Adapter<FullscreenImageAdapter.ViewHolder> {

    public interface OnOutsideImageClickListener {
        void onOutsideImageClicked();
    }

    private final List<String> imagePaths;
    private final Context context;
    private final OnOutsideImageClickListener outsideClickListener;

    public FullscreenImageAdapter(Context context, List<String> imagePaths, OnOutsideImageClickListener listener) {
        this.context = context;
        this.imagePaths = imagePaths;
        this.outsideClickListener = listener;
    }

    @NonNull
    @Override
    public FullscreenImageAdapter.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(context).inflate(R.layout.item_fullscreen_image, parent, false);
        return new ViewHolder(view, outsideClickListener);
    }

    @Override
    public void onBindViewHolder(@NonNull FullscreenImageAdapter.ViewHolder holder, int position) {
        String assetPath = imagePaths.get(position);
        try {
            AssetManager assetManager = context.getAssets();
            InputStream inputStream = assetManager.open(assetPath);
            Drawable drawable = Drawable.createFromStream(inputStream, null);
            holder.imageView.setImageDrawable(drawable);
            inputStream.close();
        } catch (IOException e) {
            holder.imageView.setImageResource(R.drawable.ic_image_placeholder);
        }
    }

    @Override
    public int getItemCount() {
        return imagePaths.size();
    }

    static class ViewHolder extends RecyclerView.ViewHolder {
        ImageView imageView;
        View parentLayout;

        ViewHolder(View itemView, OnOutsideImageClickListener listener) {
            super(itemView);
            imageView = itemView.findViewById(R.id.fullscreen_image);
            parentLayout = itemView;

            parentLayout.setOnTouchListener((v, event) -> {
                // Detectar si toque está fuera de la imagen visible
                int[] imageLocation = new int[2];
                imageView.getLocationOnScreen(imageLocation);

                float touchX = event.getRawX();
                float touchY = event.getRawY();

                int left = imageLocation[0];
                int top = imageLocation[1];
                int right = left + imageView.getWidth();
                int bottom = top + imageView.getHeight();

                if (touchX < left || touchX > right || touchY < top || touchY > bottom) {
                    // Toque fuera de la imagen
                    listener.onOutsideImageClicked();
                    return true; // consume evento
                }

                // Toque dentro de la imagen, no hacer nada especial
                return false;
            });
        }
    }
}
