#set document(title: [Esperienza di ottica ondulatoria])

#let abstract = [#lorem(100)]

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


#set table(
  stroke: none,
  gutter: 0.2em,
  fill: (x, y) =>
    if y == 0 or y == 1 { gray },
  inset: (right: 1.5em),
  align: center
)
// Fine configurazione del documento

// Importazione dei pacchetti
#import "@preview/drafting:0.2.2": *

#let caution-rect = rect.with(inset: 1em, radius: 0.5em)
#set-margin-note-defaults(rect: caution-rect, fill: orange.lighten(80%))

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
  #footnote[Email: #link("mailto:marco.vianello.14@studenti.unipd.it"). Matricola: 2158657.] <marcovianello>
]
#v(-2em)

#place(top + center, float: true, scope: "parent", clearance: 2em)[
  #text(size: 16pt)[#context document.title]

  Marco Vianello @marcovianello

  #par(justify: false)[
    *Abstract*\
    #abstract
  ]
]

// Il documento vero e proprio

= Che cosa manca
#text(red)[
- tutto
]

= Introduzione <introduzione>
#lorem(200)

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
L'attenuatore OD6 è stato avvitato alla camera. Laser e la camera sono stati montati sulle rispettive strutture di supporto e assicurati alla breadboard ottica. In particolare, la struttura di supporto della camera è stata direttamente fissata a uno dei fori della breadborad. La camera è stata successivamente interfacciata via USB al sistema di acquisizione. Il fascio laser è stato allineato otticamente con l'asse centrale del campo visivo del sistema di imaging, utilizzando il feed video e lo strumento "mirino" del software di acquisizione per ottimizzare l'incidenza sul piano focale del sensore.

== Incertezza sull'intensità luminosa <incertezza_intensità>

L'apparato (laser + camera) finora descritto è stato impiegato per valutare la stabilità temporale dell'emissione luminosa del laser. A tal fine:

+ È stata acquisita un'immagine in formato non compresso `.tif` del profilo del fascio ogni ventina di secondi, per un totale di dieci immagini.

+ L'intensità luminosa totale di ciascun frame è stata determinata come il prodotto tra l'area totale dell'immagine (in pixel) per il suo valore di grigio medio. In particolare si è adottato il parametro _Integrated Density_ del software di analisi delle immagini ImageJ#footnote[Cfr. la documentazione al link #link("https://imagej.net/ij/docs/menus/analyze.html").] (v. 1.54g) come stima dell'intensità luminosa di ciascuna immagine. La @grafico_intensità mostra la dispersione dei valori ottenuti. Un file `.csv` con i valori grezzi è disponibile nella repo associata alla relazione, cfr. @repo.

  #figure(caption: [Dispersione dei valori di intensità luminosa del sistema laser + camera.])[
    #image("grafici/intensita.svg")
  ] <grafico_intensità>

+ La deviazione standard $s_upright(I)$ del campione è stata calcolata pari a
  $
    s_upright(I) = #num("1.7e5") = #num("0.017e8")
  $
  nelle unità arbitrarie specificate sopra.
  
Assumiamo dunque che l'incertezza sui tutti i valori di intensità misurati sia pari a $s_upright(I)$.

== Determinazione dell'asse principale di polarizzazione del fascio laser <calibrazione_p1>

Il primo polarizzatore è montato su un supporto goniometrico che ne permette la rotazione continua attorno al proprio asse geometrico e la misura dall'angolo relativo di orientazione. Poiché l'asse di trasmissione ottico del polarizzatore non è allineato con lo zero della scala, si è resa necessaria la seguente procedura di calibrazione.

+ Il primo polarizzatore è stato montato sui rispettivi supporti e assicurato alla breadboard ottica tra laser e camera per mezzo di una forcella.

+ È stato identificato l'intervallo angolare $#qtyrange(120, 220, "degree")$ come una possibile regione contenente il punto di massima intensità luminosa del fascio emergente dal polarizzatore. A partire dai $#qty(120, "degree")$ è stata scattata un'immagine ogni $#qty(10, "degree")$ fino ai $#qty(220, "degree")$.

+ L'intensità luminosa di ciascun frame è stata determinata come alla @incertezza_intensità. È stato utilizzata routine `curve_fit` del pacchetto `LsqFit` per il linguaggio di programmazione Julia per determinare fittare l'andamento delle coppie angolo-intensità con il modello "di Malus"
  $
    f(theta; A, B, C) = A cos(theta + B)^2 + C
  $
  a tre parametri liberi $A$, $B$ e $C$ mediante il metodo dei minimi quadrati (con i pesi tutti uguali pari all'incertezza $s_upright(I)$ determinata alla @incertezza_intensità). In questa prima fase l'incertezza di lettura sui valori di angolo è stata trascurata. I punti sperimentali, la curva interpolante e i residui del fit sono riportati alla @grafico_calibrazione_p1.

  #figure(caption: [Andamento delle coppie angolo-intensità e fit parametrico con andamento dei residui.])[
    #image("grafici/calibrazione_p1_residui.svg")
  ] <grafico_calibrazione_p1>

  Per i parametri di best-fit $hat(A)$, $hat(B)$ e $hat(C)$ si è ottenuto
  $
    chi_"min"^2 = sum_j (I_j - f(theta_j, hat(A), hat(B), hat(C)))^2 / (s_upright(I)^2) approx #num("3e3")
  $
  e un corrispondente $p$-dei-dati pari a $0$. L'andamento della statistica $chi_"min"^2$ e del $p$-dei-dati al variare dell'incertezza $s_"I"$ sul valore di intensità luminosa in un intervallo arbitrariamente scelto in modo da comprendere il valore di $s_"I"$ per il quale il procedimento qui descritto avrebbe fornito un valore di $chi_"min"^2$ pari al numero $nu = 8$ di gradi di libertà determinati è riportato in @grafico_chisq_mins.

  #figure(caption: [Andamento dei valori di $chi_"min"^2$ al variare dell'incertezza $s_"I"$ tra $#num("1e6")$ e $#num("8e6")$ unità])[
    #image("grafici/chisq_mins.svg")
  ] <grafico_chisq_mins>

  #inline-note()[Qui va discusso il grado di significatività.]

+ #inline-note()[Poi si dice che si è rifatto il fit con ODR e si riportano i risultati.]

= Dati, codice e disegni tecnici <repo>

Il materiale di supporto alla relazione è archiviato in una repository al link #link("https://www.github.com/marcovianello5/es2_diffrazione").
