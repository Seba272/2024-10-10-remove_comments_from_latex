Il file 
remove_tex_comments.command 
è un codice python che elimina i commenti dai file latex.
(Si può aprire con un file di editor).

Nello specifico, in ogni riga del file dato elimina tutti i caratteri da '%' compreso a '\n' compreso.
Il file originale non viene modificato (viene aperto in sola lettura).
Il risultato dell'operazione viene salvato in un nuovo file che ha per nome quello originale, ma nella cartella
./no_comments/ 
Per esempio, il file 'path/to/file.tex' viene affiancato da 'no_comments/path/to/file-no_comments.tex'.

Per rendere eseguibile il file, da linea di comando:
chmod +x remove_tex_comments.command

Per eseguire il file, da linea di comando:
./remove_tex_comments.command file1 file2 file3 ...

Se si vogliono dare tutti i file tex nella cartella in cui siamo:
./remove_tex_comments.command *.tex

Se si vogliono dare in pasto tutti i file tex nella cartella 'capitoli':
./remove_tex_comments.command capitoli/*.tex
(in questo caso, il risultato sarà in 'no_comments/capitoli/...' )

