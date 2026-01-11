// Titolo e abstract

#set document(title: [Esperienza di ottica ondulatoria])

#let abstract = [Si discute la validità del modello "di Malus" $I = I_0cos^2(theta)$ per l'intensità luminosa $I$ di un fascio di luce polarizzata uscente da un polarizzatore che forma un angolo $theta$ con l'asse di trasmissione.]

// Configurazione del documento
#set page(
  paper: "a4",
  numbering: "1",
  columns: 2,
  margin: 2em
)

#set par(
  first-line-indent: 1em,
  justify: true
)

#set text(
  lang: "it",
)

#set heading(
  numbering: "1.1"
)

/* #set math.equation(
numbering: n => { numbering("(1.1)", counter(heading).get().first(), n) }
) */


// #set table(
//   stroke: none,
//   gutter: 0.2em,
//   fill: (x, y) =>
//     if y == 0 or y == 1 { gray },
//   inset: (right: 1.5em),
//   align: center
// )
// Fine configurazione del documento

// Importazione dei pacchetti
#import "@preview/drafting:0.2.2": *

#set-margin-note-defaults(fill: orange.lighten(80%))

#import "@preview/unify:0.7.1": num, qty, numrange, qtyrange
#import "@preview/physica:0.9.5": *

#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#import "@preview/ctheorems:1.1.3": *


// Configurazione di ctheorems
#show: thmrules.with(qed-symbol: $square$)

#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let corollary = thmplain("corollary", "Corollary", base: "theorem", titlefmt: strong)
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em))
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")


// Definizioni matematiche
#show sym.colon: $class("punctuation", colon) space.thin$
#let to = math.arrow
#let mapsto = math.arrow.bar
#let blank = math.class("normal", $dash.en$)
#let diff = math.upright("d")
#let wedge = math.and
#let tb = math.upright("T")
#let tensors(body, ..sink) = $tensor(upright(T), ..sink) (#body)$
#let Hom = math.op("Hom")
#let lin = math.cal("L")
#let ltensors(from, to, ..sink) = $tensor(lin, ..sink) (from; to)$
#let vf = math.cal("X")
#let cntsf(deg) = $cal(C)^deg$
// #let otimes = math.times.o
#let lrangle(fst, snd) = $angle.l fst, snd angle.r$


// Pagina del titolo
#hide[
  #footnote[Turno: 5. Gruppo: 5. Email: #link("mailto:marco.vianello.14@studenti.unipd.it"). Numero di matricola: 2158657.] <marcovianello>
]
#v(-2em)

#place(top + center, float: true, scope: "parent", clearance: 2em)[
  #text(size: 16pt)[#context document.title]

  Marco Vianello @marcovianello\

  #par(justify: false)[
    *Abstract*\
    #abstract
  ]
]

// Il documento vero e proprio

= Che cosa manca
- Punti 3 e 4 della dispensa fornita in laboratorio.

// = Introduzione <introduzione>
// #inline-note[
//   #lorem(100)
// ]

= L'apparato sperimentale e la metodologia di misura <setup>

== Componenti

Sono stati utilizzati
- Breadboard ottica Thorlabs MB4590/M, paletti Thorlabs serie TR, portapaletti Thorlabs serie PH, viteria.
- Forcelle Thorlabs CF125C/M e piedistalli Thorlabs BE1/M.
- Maschera a fenditura singola realizzata tramite stampa 3D montata su un portalenti Thorlabs LMR1/M (impiegato come supporto meccanico stabile).
- Diodo laser Thorlabs PL202 di lunghezza d'onda tipica $#qty(635, "nm")$ con kit di montaggio Thorlabs PLK1/M.
- Polarizzatore montato su goniometro continuo Thorlabs RSP1D/M (in seguito "il primo polarizzatore" o "il polarizzatore P1", ecc.).
- Polarizzatore montato su goniometro a scatti Thorlabs RSP1X15/M (in seguito "il secondo polarizzatore" o "il polarizzatore P2", ecc.).
- #text(red)[lamine]
- Schermo Thorlabs EDU-VS2M (utile per le procedure di allineamento).
- Filtro attenuatore OD6.0 Thorlabs NE60A.
- Camera CCD Thorlabs CS165CU/M con cavetto USB.
- Un PC con software ThorImageCAM per controllare la camera.

== Allestimento del banco ottico
L'attenuatore OD6 è stato avvitato alla camera. Laser e la camera sono stati montati sulle rispettive strutture di supporto e assicurati alla breadboard ottica. In particolare, la struttura di supporto della camera è stata direttamente fissata a uno dei fori della breadborad. La camera è stata successivamente interfacciata via USB al sistema di acquisizione. Il fascio laser è stato allineato otticamente con l'asse centrale del campo visivo del sistema di imaging, utilizzando il feed video e lo strumento "mirino" del software di acquisizione per ottimizzare l'incidenza sul piano focale del sensore. Il tempo di esposizione del sensore è stato regolato per evitare la saturazione ed è stato mantenuto costante per tutta la durata dell'esperimento.

== Incertezza sull'intensità luminosa <incertezza_intensità>

L'apparato (laser + camera) finora descritto è stato impiegato per valutare la stabilità temporale dell'emissione luminosa del laser. A tal fine:

+ Sono state acquisite immagini in formato non compresso TIFF del profilo del fascio a intervalli di circa venti di secondi l'una all'altra, per un totale di dieci immagini.

+ L'intensità luminosa totale di ciascun frame è stata determinata come il prodotto tra l'area totale dell'immagine (in pixel) per il suo valore di grigio medio. In particolare si è adottato il parametro _Integrated Density_ del software di analisi delle immagini ImageJ#footnote[Cfr. la documentazione al link #link("https://imagej.net/ij/docs/menus/analyze.html").] (v. 1.54g) come stima dell'intensità luminosa di ciascuna immagine. La @grafico_intensità mostra la dispersione dei valori ottenuti. Un file `.csv` con i valori grezzi è disponibile nella repository associata alla relazione, cfr. @repo.

  #figure(caption: [Dispersione dei valori di intensità luminosa del sistema laser + camera.])[
    #image("grafici/intensita.svg")
  ] <grafico_intensità>

+ La deviazione standard $s_I$ del campione è stata calcolata pari a
  $
    s_I = #num("1.7e5") = #num("0.017e8")
  $
  nelle unità arbitrarie specificate sopra.

Durante il processo di presa dati si è reso spesso necessario riaggiustare l'allineamento del laser con la camera. Per valutare la sensibilità del valore di intensità luminosa alla procedura di riallineamento è stato suggerito di iterare la seguente procedura:
+ perturbare volontariamente l'allineamento del fascio agendo sulle manopole del kit di montaggio Thorlabs PLK1/M oppure su paletto e portapaletto;
+ ripristinare il corretto allineamento agendo sulle manopole del kit di montaggio;
+ acquisire un'immagine in formato non compresso TIFF del profilo del fascio riallineato mediante il sistema di acquisizione;
+ determinare il valore di intensità luminosa del fascio come fatto sopra.

La deviazione standard del campione di misure di intensità così ottenuto si suppone essere rappresentativa dell'incertezza su tutte le misure successive di intensità luminosa effettuate come descritto.

Purtroppo, al contrario di quanto suggerito, le immagini che avrebbero dovuto permettere di fornire questa stima di incertezza sono state salvate in formato JPEG e si è quindi scelto di non utilizzarle a fini metrologici. È stato invece adottato il campione ("campione esterno") fornito da un altro gruppo. La deviazione standard $s_(I,"ext")$ del campione esterno è stata stimata pari a
$
  s_(I,"ext") = #num("7.2e5") = #num("0.072e8")
$
unità.

Il ruolo che gioca il valore di incertezza da associare all'intensità luminosa è discusso alla @analisi. Si anticipa in particolare che entrambi i valori $s_I$ e $s_(I,"ext")$ sono probabilmente delle sottostime, in quanto l'analisi del $chi^2$ di alcuni fit con un modello noto (cfr. @calibrazione_p1_analisi) riportano un valore di $p$-dei-dati eccessivamente vicino allo zero.

== Determinazione dell'asse principale di polarizzazione del fascio laser <calibrazione_p1_procedura>

Il primo polarizzatore è montato su un supporto goniometrico che ne permette la rotazione continua attorno al proprio asse geometrico e la misura dall'angolo relativo di orientazione. Poiché l'asse di trasmissione ottico del polarizzatore non è allineato con lo zero della scala, si è resa necessaria la seguente procedura di calibrazione.

+ Il primo polarizzatore è stato montato sui rispettivi supporti e assicurato alla breadboard ottica tra laser e camera per mezzo di una forcella (con la scala goniometrica rivolta verso la sorgente laser).

+ È stato identificato l'intervallo angolare da $#qty(120, "degree")$ a $#qty(220, "degree")$ come una possibile regione contenente il punto di massima intensità luminosa del fascio emergente dal polarizzatore. A partire dai $#qty(120, "degree")$ è stata scattata un'immagine ogni $#qty(10, "degree")$ fino ai $#qty(220, "degree")$.

+ L'intensità luminosa di ciascun frame è stata determinata come alla @incertezza_intensità. È stata utilizzata la routine `curve_fit` del pacchetto `LsqFit.jl` per il linguaggio di programmazione Julia per determinare i parametri di best fit alle coppie angolo-intensità misurate del modello "di Malus"
  $
    f(theta; A, B, C) = A cos(theta + B)^2 + C
  $
  a tre parametri liberi $A$, $B$ e $C$ mediante il metodo dei minimi quadrati ordinario (con i pesi tutti uguali pari all'incertezza $s_I$ determinata alla @incertezza_intensità). In questa prima fase l'incertezza $s_theta$ di lettura sui valori di angolo (che si assume pari all'incertezza di lettura pesata con il modello triangolare, $s_theta = #qty(0.2, "degree")$) è stata trascurata.
  
+ È stato determinato numericamente il valore angolare $theta_0 = #qty(177.2, "degree")$ che massimizza la curva interpolante. Questo valore è stato utilizzato per azzerare la scala graduata del goniometro.
  
L'analisi riportata fino a questo punto è stata condotta direttamente in laboratorio. A posteriori (cfr. @calibrazione_p1_analisi) _si sconsiglia_ di determinare l'angolo di massima intensità $theta_0$ come indicato qui, cfr. @calibrazione_p1_analisi. Le considerazioni della Sezione non si applicano infatti al procedimento suggerito sulla dispensa fornita in laboratorio, il quale potrebbe pertanto fornire una miglior stima dell'angolo di massima intensità $theta_0$. Va comunque tenuto conto della difficoltà pratica incontrata nella regolazione del goniometro: è realistico assumere che una differenza di $#qty("+-0.5", "degree")$ sul valore di $theta_0$ non avrebbe influito particolarmente.

== Verifica della legge di Malus <malus_procedura>

Si è seguita la procedura riportata nella dispensa fornita in laboratorio per determinare la dipendenza dell'intensità luminosa trasmessa da un secondo polarizzatore posto a seguito del primo in funzione dell'angolo relativo di orientazione. I punti ottenuti e la curva di miglior fit ottenuta con il pacchetto `LsqFit` sono riportati in @grafico_malus. I dati sono discussi alla sezione @malus_analisi.

#figure(
  caption: [L'andamento della curva di Malus per un angolo relativo da $#qty(-30, "degree")$ a $#qty(195, "degree")$.],
)[
  #image("grafici/malus_residui.svg")
] <grafico_malus>

= Commento sui dati ottenuti <analisi>

== Misure effettuate per determinare l'asse principale di polarizzazione del fascio laser <calibrazione_p1_analisi>
I punti sperimentali ottenuti mediante la procedura delineata alla @calibrazione_p1_procedura, la curva interpolante determinata come specificato sempre alla @calibrazione_p1_procedura e i residui del fit sono riportati alla @grafico_calibrazione_p1.

#figure(caption: [Andamento delle coppie angolo-intensità e fit parametrico con andamento dei residui.])[
  #image("grafici/calibrazione_p1_residui.svg")
] <grafico_calibrazione_p1>


Per i parametri di best-fit $hat(A)$, $hat(B)$ e $hat(C)$ si è ottenuto
$
  chi_"min"^2 = sum_j (I_j - f(theta_j; hat(A), hat(B), hat(C)))^2 / (s_I^2) approx #num("3e3")
$

e un corrispondente $p$-dei-dati pari a $0$.
  
Si sospetta che il valore $s_I$ di incertezza sull'intensità luminosa determinato alla @incertezza_intensità sia una _sottostima_ del valore vero. Si è pertanto optato per riportare in in @grafico_chisq_mins l'andamento della quantità $chi_"min"^2$ e del $p$-dei-dati al variare di $s_I$ in un intervallo arbitrariamente scelto in modo da comprendere il valore di $s_I$ per il quale il procedimento qui descritto avrebbe fornito un valore di $chi_"min"^2$ comparabile con il numero di gradi di libertà $nu = 8$ determinati.

#figure(caption: [Andamento dei valori di $chi_"min"^2$ e del $p$-dei-dati al variare dell'incertezza $s_I$ tra $#num("1e6")$ e $#num("8e6")$ unità. È evidenziata in verde la regione $nu plus.minus nu sqrt(2 nu)$, corrispondente a una deviazione standard della media $nu$ della statistica $chi_nu^2$. Il valore di $s_I$ al punto rosso (corrispondente a $chi_"min"^2 = 8$ e $p$-dei dati pari a $0.43$) è pari a $s_I = #num("3.7e6")$ unità. Il valore di $s_I$ al punto arancione (corrispondente a $chi_"min"^2 = 16$ e $p$-dei dati pari a $0.04$) è pari a $s_I = #num("2.6e6")$ unità.])[
  #image("grafici/chisq_mins.svg")
] <grafico_chisq_mins>

I valori $s_I = #num("1.7e5")$ e $s_(I,"ext") = #num("7.2e5")$ di incertezza dichiarati alla sezione @incertezza_intensità _non_ rientrano nella soglia $s_I > #num("2.6e6")$ entro la quale il presente fit non porta evidenza statistica sufficiente per rifiutare al $5%$ di significatività il modello parametrico proposto.

Il fit con il modello di Malus è stato ripetuto tenendo conto dell'incertezza $s_theta = #qty("0.2", "degree")$ sulla variabile angolare. Si è cioè utilizzato il pacchetto `Odrpack.jl` per il linguaggio di programmazione Julia per ripetere la stima dei parametri di miglior fit con _Orthogonal Distance Regression_ prendendo come pesi i valori $1/s_theta^2$ e $1/s_I^2$ oppure $1/s_(I,"ext")^2$ rispettivamente per la variabile indipendente e per la variabile dipendente. Le quantità#footnote[Nonostante la notazione fuorviante, _non_ si assume che le quantità $chi_"min"^2$ determinate con ODR siano distribuite come una variabile $chi_nu^2$ (viene a mancare l'ipotesi di linearità del modello di Malus sul coefficiente di correzione angolare).]
$
  chi_"min"^2 = sum_j {hat(delta_j)^2/s_theta^2 +  (I_j - f(theta_j - hat(delta_j); hat(A), hat(B), hat(C)))^2 / s_I^2}
$
sono state calcolate per i parametri di best-fit $hat(A)$, $hat(B)$ e $hat(C)$ e per i valori ottimali di scarto $hat(delta_j)$ sulla coordinata angolare, e i risultati dell'analisi sono riportati in @tabella_chisq-min_ols_odr.

#show table.cell.where(y: 0): strong
#set table(
  stroke: (x, y) => {
    if (y == 0 or y == 2) {(bottom: 0.7pt + black)}
    if (x == 1) {(left: 0.7pt)}
  },
  align: center
  )

#figure(
  caption: [Valori di $chi_"min"^2$ corrispondenti ai valori di incertezza $s_I = #num("1.7e5")$ e $s_(I,"ext") = #num("7.2e5")$ unità sull'intensità del laser in funzione del metodo di regressione adottato ("OLS" per il metodo dei minimi quadrati ordinario e "ODR" per _Orthogonal Distance Regression_).]
)[
  #table(
    columns: 3,
    table.header([], [OLS], [ODR]),
    [$s_I$], [$#num("3.9e3")$], [$#num("0.56e3")$],
    [$s_(I,"ext")$], [$#num("0.21e3")$], [$#num("0.15e3")$],
  )
] <tabella_chisq-min_ols_odr>

In @grafico_chisq_mins_ols_vs_odr sono stati confrontati gli andamenti delle quantità $chi_"min"^2$ determinate con OLS e ODR in un range di incertezze sul valore di intensità del laser tale da comprendere entrambi i valori $s_I = #num("1.7e5")$ e $s_(I,"ext") = #num("7.2e5")$ unità determinati alla @incertezza_intensità.

#figure(caption: [Andamento dei valori di $chi_"min"^2$ calcolato al variare dell'incertezza $s_I$ tra $#num("1e6")$ e $#num("8e6")$ unità (linee tratteggiate) per fit a minimi quadrati pesati ordinari ("OLS") e con _Orthogonal Distance Regression_ ("ODR").])[
  #image("grafici/chisq_mins_ols_vs_odr.svg")
] <grafico_chisq_mins_ols_vs_odr>

I valori della @tabella_chisq-min_ols_odr escono dalle quattro deviazioni standard della media $nu = 8$ di una distribuzione $chi_nu^2$ a $8$ gradi di libertà. Ci si chiede d'altro canto se abbia senso un confronto del genere, o se sia opportuno cercare di determinare perlomeno la distribuzione delle quantità $chi_"min"^2$ calcolate con ODR (con il metodo di Monte Carlo, ad esempio). Non è stato risposto a queste domande nella presente relazione.

= Misure effettuate per verificare la dipendenza dell'intensità luminosa in funzione dell'angolo <malus_analisi>
Le analisi della sezione precedente sono state riproposte per i dati acquisiti con la procedura descritta alla @malus_procedura. Le stime di incertezza fornite alla @incertezza_intensità risultano in valori di $chi_"min"^2$ ottimali dell'ordine di $10^8$ per OLS e $10^6$ per ODR. Allo stato attuale, le competenze dell'autore di questa relazione non permettono di trarre alcuna conclusione significativa da queste analisi, perlomeno in tempi brevi.

= Dati e codice <repo>

Il materiale di supporto alla relazione è archiviato in una repository al link #link("https://www.github.com/marcovianello5/es2_diffrazione").
