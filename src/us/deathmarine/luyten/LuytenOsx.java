package us.deathmarine.luyten;

import java.awt.Desktop;
import java.awt.desktop.OpenFilesEvent;
import java.awt.desktop.OpenFilesHandler;
import java.awt.desktop.QuitEvent;
import java.awt.desktop.QuitHandler;
import java.awt.desktop.QuitResponse;
import java.io.File;
import java.util.Collections;
import java.util.List;

/**
 * An OS X-specific initialization method for dragging/dropping
 */
public class LuytenOsx extends Luyten {

    public static void main(String[] args) {

        Desktop desktop = Desktop.getDesktop();
        desktop.setOpenFileHandler(new OpenFilesHandler() {
            @Override
            public void openFiles(OpenFilesEvent e) {
                List<File> files = (null != e.getFiles() && !e.getFiles().isEmpty()) ? e.getFiles() : Collections.emptyList();
                for (File file : files) {
                    Luyten.addToPendingFiles(file);
                }
                Luyten.processPendingFiles();
            }
        });
        desktop.setQuitHandler(new QuitHandler() {
            @Override
            public void handleQuitRequestWith(QuitEvent e, QuitResponse response) {
                Luyten.quitInstance();

            }
        });

        // Call the superclass's main function
        Luyten.main(args);
    }
}
