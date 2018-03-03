ui <- fluidPage(
  fluidRow(
    column(
      h2("Query a Word"),
      textInput("word", "Word:", "city"),
      tableOutput("word_result"),
    width = 6),
    column(
      h2("Query using a Word Formula"),
      textInput("formula", "Word Formula:", "Man"),
      em("example: transit - lrt + budget"),
      tableOutput("formula_result"),
      width = 6)
  ),

  fluidRow(
    br(), hr(), br()
  ),

  fluidRow(
    fluidRow(
      column(h2("Word Analogy:"), width = 12)
    ),
    fluidRow(
      column(textInput("analogy_a", NULL, "man"), width = 5),
      column("is to", width = 2),
      column(textInput("analogy_b", NULL, "king"), width = 5)
    ),
    fluidRow(
      column("As", width = 12)
    ),
    fluidRow(
      column(textInput("analogy_c", NULL, "woman"), width = 5),
      column("is to?", width = 2),
      column(tableOutput("analogy_result"), width = 5)
    )
  )
)
