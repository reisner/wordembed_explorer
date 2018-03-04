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

  output$word_result <- renderTable({
    query = input$word
    req(query)
    wordVectors::closest_to(model, query)
  })

  output$formula_result <- renderTable({
    query = input$formula
    req(query)
    query = processQuery(query)
    formula = as.formula(query)
    wordVectors::closest_to(model, eval(formula))
  })

  output$analogy_result <- renderTable({
    query_a = input$analogy_a
    query_b = input$analogy_b
    query_c = input$analogy_c
    req(query_a)
    req(query_b)
    req(query_c)
    query_str = paste0('~"', query_b, '" - "', query_a, '" + "', query_c, '"')
    formula = as.formula(query_str)
    wordVectors::closest_to(model, eval(formula))
  })
}
