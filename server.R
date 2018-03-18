# Convert
#    king - man + woman
# to
#    ~"king" - "man" + "woman"
processQuery <- function(query) {
  query_str = ''
  parts = unlist(strsplit(query, ' '))
  operators = c('+', '-', '*', '/')
  for (part in parts) {
    if (part %in% operators) {
      query_str = paste(query_str, part)
    } else {
      query_str = paste0(query_str, ' "', part, '"')
    }
  }
  paste0("~", query_str)
}

# ----- Server

server <- function(input, output) {
  model = wordVectors::read.vectors("word_embeddings.bin")

  model_query = reactiveVal(value = "")

  observeEvent(input$word_query, {
    model_query(input$word_query)
  })

  observeEvent(input$word_formula, {
    query = processQuery(input$word_formula)
    formula = as.formula(query)
    model_query(formula)
  })

  observeEvent(
    {
      input$analogy_a
      input$analogy_b
      input$analogy_c
    },
    {
      query_a = input$analogy_a
      query_b = input$analogy_b
      query_c = input$analogy_c
      req(query_a)
      req(query_b)
      req(query_c)
      query_str = paste0('~"', query_b, '" - "', query_a, '" + "', query_c, '"')
      formula = as.formula(query_str)
      formula = eval(formula)
      model_query(formula)
    }
  )

  #    if (input$cluster_tabset == "manual") {
  observeEvent(input$query_type, {
    print("HERE!")
    print(input$query_type)
  })

  output$query_result <- renderTable({
    wordVectors::closest_to(model, model_query())
  })
}
