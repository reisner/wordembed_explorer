ui <- fluidPage(
  fluidRow(
    column(
      textInput("word", "Word:", "city"),
      tableOutput("word_result")
    , width = 6),
    column(
      textInput("formula", "Word Formula:", "Man"),
      tableOutput("formula_result")
    , width = 6)
  ),

  fluidRow(
    br(), hr(), br()
  ),

  fluidRow(
    fluidRow(
      column(textInput("analogy_a", NULL, "man"), width = 5),
      column("is to", width = 2),
      column(textInput("analogy_b", NULL, "king"), width = 5)
    ),
    fluidRow(
      column("As", width = 4)
    ),
    fluidRow(
      column(textInput("analogy_c", NULL, "woman"), width = 5),
      column("is to", width = 2),
      column(tableOutput("analogy_result"), width = 5)
    )
  )
)
