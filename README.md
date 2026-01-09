# es2_diffrazione
La seconda esperienza di laboratorio per il corso "Sperimentazioni di fisica 2" del corso di laurea in Fisica dell'Università degli Studi di Padova.

## Che cosa c'è qui

  - Un notebook di [Jupyter](https://jupyter.org/) per il linguaggio [Julia](https://julialang.org/);
  
  - Una cartella `dati` nella quale sono presenti
 
    - una cartella `allineamento` contenente la serie temporale di immagini acquisita per stimare l'incertezza sui valori di intensità del laser (più il file `.csv` ottenuto da ImageJ);

    - le cartelle `calibrazione_px` per `x` uguale a `1` o a `2` contenenti le immagini dalle quali sono stati ricavati i profili di intensità rispettivamente del primo e del secondo polarizzatore (più i rispettivi file `.csv` ottenuti da ImageJ);
 
    - eccetera eccetera;
	
  - Una cartella `typst` con il sorgente [Typst](https://typst.app/) della relazione.
  

## Come si usa tutto ciò

Per visualizzare il notebook e interagire con esso ho utilizzato il pacchetto [IJulia](https://github.com/JuliaLang/IJulia.jl) e l'editor [VSCodium](https://vscodium.com/) con le estensioni per Jupyter e Julia.

## Che cosa manca da fare

Al momento _tantissime_ cose. In particolare andrebbero [precompilati](https://julialang.github.io/PackageCompiler.jl/stable/) i pacchetti che uso.
