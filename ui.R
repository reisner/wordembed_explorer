source("WordInputModules.R")

ui <- fixedPage(
  titlePanel("Word Embedding Explorer"),

  mainPanel(
    tabsetPanel(
      tabPanel(
        "Single Word Query",
        textInput("word_query", "Word:", "city"),
        value = 'word_query'
      ),

      tabPanel(
        "Query by Analogy",
        fixedRow(
          br(), br(),
          fixedRow(
            column(textInput("analogy_a", NULL, "rec"), width = 2),
            column("is to", width = 1),
            column(textInput("analogy_b", NULL, "fun"), width = 2)
          ),
          fixedRow(
            column('', width = 1),
            column(strong("As"), width = 10)
          ),
          fixedRow(
            column(textInput("analogy_c", NULL, "edmonton"), width = 2),
            column("is to?", width = 1),
            column(tableOutput("analogy_result"), width = 2)
          )
        ),
        value = 'word_analogy'
      ),

      tabPanel(
        "Word Formula",
        tagList(
          textInput("word_formula", "Word Formula:", "rec - affordable"),
          strong("Usage:"), em("use +/- between words. Ensure spaces between terms.")
        ),
        value = 'word_formula'
      ),

      tabPanel(
        "Query Builder",
        wordInputUI('builder_pos_terms'),
        wordInputUI('builder_neg_terms'),
        value = 'word_query_builder'
      ),

      id = "query_type"
    ),

    br(), hr(), br(),

    h3("Query Result:"),
    fluidRow(tableOutput('query_result'), width = 12)
  )
)
