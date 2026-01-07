// === Algorithmic Logistics ===
#import "@preview/algorithmic:1.0.0"
#import algorithmic: *

// === Codly Logistics ===
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#let printer_friendly = false

// === Template ===
#let minimal-note(
  title: [Paper Title],
  author: [Albert Einstein],
  date: datetime.today().display("[month repr:long], [year]"),
  show_outline: true,
  doc
) = {
  // Styling Configurations
  set heading(numbering: "1.")
  set figure(numbering: "1")

  // Color links
  show link: it => {
    let default-color = rgb("#57B9FF")
    let label-color = rgb("#57B94F")
  
    if type(it.dest) == label {
      underline(text(fill: label-color)[#it])
    } else {
      underline(text(fill: default-color)[#it])
    }
  }

  // Packages
  show: codly-init.with()
  codly(
    languages: codly-languages,
  )

  show: style-algorithm

  // Title and Date
  align(center, text(18pt)[*#title*])
  align(center)[#author \ #date]

  // Table of Contents
  if show_outline {
    outline()
  }

  // Document
  doc
}


// === Prompting Boxes ===
#let color-box(header, body, color: rgb("B8F0D3"), outline: none) = {
  set align(center)
  
  box(
    fill: color,
    inset: 13pt,
    radius: 10pt,
    width: 100%, 
    stroke: outline
  )[
    #set align(left)
    
    #place(top + left)[
      *#header*
    ] \
    #body
  ]
}

// To add additional box colors, follow the below function definitions and replace the color named argument.

#let green-box(header, body) = {
  color-box(header, body, color: rgb("B8F0D3"))
}

#let orange-box(header, body) = {
  color-box(header, body, color: rgb("FFDAB8"))
}

#let blue-box(header, body) = {
  color-box(header, body, color: rgb("B5EAFF"))
}

#let solid-box(header, body) = {
  color-box(header, body, color: white, outline:stroke(paint: black, dash: "solid"))
}

#let dashed-box(header, body) = {
  color-box(header, body, color: white, outline:stroke(paint: black, dash: "densely-dashed"))
}

#let dotted-box(header, body) = {
  color-box(header, body, color: white, outline:stroke(paint: black, dash: "loosely-dotted"))
}

#let (rule, useCase, example) = if printer_friendly == true {
  (solid-box, dashed-box, dotted-box)
} else {
  (green-box, orange-box, blue-box)
}
