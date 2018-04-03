source("WordInputModules.R")

ui <- fixedPage(
  titlePanel("Word Embedding Explorer"),

  mainPanel(
    tabsetPanel(
      tabPanel(
        "Single Word Query",
        wordInputUI('word_query'),
        value = 'word_query'
      ),

      tabPanel(
        "Query by Analogy",
        fixedRow(
          br(), br(),
          fixedRow(
            column(wordInputUI("analogy_a"), width = 2),
            column(br(), "is to", width = 1),
            column(wordInputUI("analogy_b"), width = 2)
          ),
          fixedRow(
            column('', width = 1),
            column(strong("As"), width = 10)
          ),
          fixedRow(
            column(wordInputUI("analogy_c"), width = 2),
            column(br(), "is to?", width = 1)
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

      tabPanel(
        "Query by Text",
        textInput("text_query", "Query Text:", "What can I do for fun?"),
        value = 'query_by_text'
      ),

      id = "query_type"
    ),

    br(), hr(), br(),

    h3("Query Result:"),
    fluidRow(tableOutput('query_result'), width = 12)
  )
)
