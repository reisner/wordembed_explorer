ui <- fixedPage(
  titlePanel("Word Embedding Explorer"),
  mainPanel(
    tabsetPanel(
      tabPanel("Word Query", textInput("word_query", "Word:", "city")),
      tabPanel("Word Analogy", ''),
      tabPanel("Word Formula", ''),
      tabPanel("Query Builder", '')
    ),

    br(), hr(), br(),

    h3("Query Result:"),
    fluidRow(tableOutput('query_result'), width = 12)
  )


  #   column(
  #     h2("Query using a Word Formula"),
  #     textInput("formula", "Word Formula:", "edmonton + budget - waste"),
  #     strong("Usage:"), em("use +/- between words. Ensure spaces between terms."),
  #     br(),br(),
  #     tableOutput("formula_result"),
  #     width = 6)
  # ),
  #
  # fixedRow(
  #   br(), hr(), br()
  # ),
  #
  # fixedRow(
  #   fixedRow(
  #     column(h2("Word Analogy:"), width = 5)
  #   ),
  #   fixedRow(
  #     column(textInput("analogy_a", NULL, "man"), width = 2),
  #     column("is to", width = 1),
  #     column(textInput("analogy_b", NULL, "king"), width = 2)
  #   ),
  #   fixedRow(
  #     column('', width = 1),
  #     column(strong("As"), width = 10)
  #   ),
  #   fixedRow(
  #     column(textInput("analogy_c", NULL, "woman"), width = 2),
  #     column("is to?", width = 1),
  #     column(tableOutput("analogy_result"), width = 2)
  #   )
  # )
)
