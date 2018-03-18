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

  word_formula_result = reactive({
    query = processQuery(input$word_formula)
    as.formula(query)
  })

  word_analogy_result = reactive({
    query_a = input$analogy_a
    query_b = input$analogy_b
    query_c = input$analogy_c
    req(query_a)
    req(query_b)
    req(query_c)
    query_str = paste0('~"', query_b, '" - "', query_a, '" + "', query_c, '"')
    formula = as.formula(query_str)
    eval(formula)
  })

  word_query_builder_result = reactive({
    'test'
  })

  model_query = reactive({
    query_type = input$query_type
    if (query_type == 'word_query') {
      return(input$word_query)
    } else if (query_type == 'word_analogy') {
      return(word_analogy_result())
    } else if (query_type == 'word_formula') {
      return(word_formula_result())
    } else if (query_type == 'word_query_builder') {
      return(word_query_builder_result())
    }
  })

  output$query_result <- renderTable({
    wordVectors::closest_to(model, model_query())
  })
}
