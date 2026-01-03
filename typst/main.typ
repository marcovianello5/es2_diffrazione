#set document(title: [Esperienza di ottica ondulatoria])

#let abstract = [sdsa]


#import "@preview/unify:0.7.1": num, qty, numrange, qtyrange
#import "@preview/drafting:0.2.2": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/physica:0.9.5": *
#import "@preview/ctheorems:1.1.3": *

// Configurazione di ctheorems

#show: thmrules.with(qed-symbol: $square$)

#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))

#let corollary = thmplain("corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)

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

// Configurazione del documento 

#set par(
  first-line-indent: 1em,
  justify: true
)

#set page(
  paper: "a4"
)

#set text(
  size: 12pt,
  lang: "it",
)

#set heading(
  numbering: "1.1"
)

#set math.equation(numbering: n => {
  numbering("(1.1)", counter(heading).get().first(), n)
  // if you want change the number of number of displayed
  // section numbers, modify it this way:
  /*
  let count = counter(heading).get()
  let h1 = count.first()
  let h2 = count.at(1, default: 0)
  numbering("(1.1.1)", h1, h2, n)
  */
})

#set table(
  stroke: none,
  gutter: 0.2em,
  fill: (x, y) =>
    if y == 0 or y == 1 { gray },
  inset: (right: 1.5em),
  align: center
)

// Pagina del titolo

#align(center)[#text(size: 16pt)[#context document.title]]

#align(center)[
    Marco Vianello\
    #link("mailto:marco.vianello.14@studenti.unipd.it")\
    2158657
]

#align(center)[
  #par(justify: false)[
    *Abstract* \
    #abstract
  ]
]

// Il documento vero e proprio

= Che cosa manca
- Tutto

= Introduzione <introduzione>


= L'apparato sperimentale e la metodologia di misura <setup>

== Componenti

Sono stati utilizzati
  - Breadboard ottica Thorlabs MB4590/M, paletti Thorlabs serie TR, portapaletti Thorlabs serie PH, viteria.
  - Forcelle Thorlabs CF152 e piedistalli Thorlabs BE1.
  - Maschera a fenditura singola realizzata tramite stampa 3D.
  - Portalenti Thorlabs LMR1/M (impiegato come supporto meccanico stabile per la maschera).
  - Laser Thorlabs PL202 di lunghezza d'onda tipica $#qty(635, "nm")$.
  - #text(red)[polarizzatori]
  - #text(red)[lamine]
  - #text(red)[fenditura]
  - Schermo Thorlabs EDU-VS2M (utile per le procedure di allineamento).
  - Camera CCD Thorlabs CS165CU/M con cavetto USB.
  - Un PC con software ThorImageCAM per controllare la camera.

== Allestimento del banco ottico
I componenti principali (camera, lente, ecc.) sono stati montati sulle rispettive strutture di supporto Thorlabs serie TR e PH, ad ognuna delle quali è stato avvitato uno carrello Thorlabs RC1. La sorgente luminosa equipaggiata con maschera e filtri è stata collegata all'alimentatore e assieme alla guida metrica è invece fissata direttamente alla breadboard ottica.

Al momento della stesura di questo documento non è nota l'incertezza con cui sono riportate le misure dei componenti Thorlabs. 


= Dati, codice e disegni tecnici <repo>

Il materiale di supporto alla relazione è archiviato in una repository al link #link("https://www.github.com/marcovianello5/es2_focale").
