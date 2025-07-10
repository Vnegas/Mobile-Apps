package com.example.frijol.fragments;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;

import androidx.core.content.FileProvider;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import com.example.frijol.R;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class InfoFragment extends Fragment {

    private Button btnOpenPdf;

    public InfoFragment() {}

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_info, container, false);

        btnOpenPdf = view.findViewById(R.id.open_pdf);

        btnOpenPdf.setOnClickListener(v -> {
            try {
                // Copiar PDF de assets a archivo interno
                File file = new File(requireContext().getFilesDir(), "referencias.pdf");
                if (!file.exists()) {
                    InputStream asset = requireContext().getAssets().open("pdf/referencias.pdf");
                    FileOutputStream output = new FileOutputStream(file);
                    byte[] buffer = new byte[1024];
                    int length;
                    while ((length = asset.read(buffer)) > 0) {
                        output.write(buffer, 0, length);
                    }
                    output.flush();
                    output.close();
                    asset.close();
                }

                // Abrir PDF usando FileProvider para acceso seguro
                Uri pdfUri = FileProvider.getUriForFile(requireContext(), requireContext().getPackageName() + ".fileprovider", file);

                Intent intent = new Intent(Intent.ACTION_VIEW);
                intent.setDataAndType(pdfUri, "application/pdf");
                intent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION | Intent.FLAG_ACTIVITY_NO_HISTORY);

                startActivity(intent);

            } catch (IOException e) {
                e.printStackTrace();
            }
        });

        return view;
    }
}
