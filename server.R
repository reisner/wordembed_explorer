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
  query_words = row.names(model)


  # ------ Word Formula

  word_formula_result = reactive({
    query = processQuery(input$word_formula)
    as.formula(query)
  })


  # ------ Query by Analogy

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


  # ------ Query Builder

  builder_pos_terms = callModule(wordInput,
                                 'builder_pos_terms',
                                 words = query_words,
                                 label = 'Include Concepts',
                                 selected_words = 'city')
  builder_neg_terms = callModule(wordInput,
                                 'builder_neg_terms',
                                 words = query_words,
                                 label = 'Exclude Concepts',
                                 selected_words = 'waste')
  word_query_builder_result = reactive({
    pos_terms = builder_pos_terms()
    neg_terms = builder_neg_terms()

    req(!is.null(pos_terms) | !is.null(neg_terms))
    pos_present = !is.null(pos_terms)
    neg_present = !is.null(neg_terms)

    if (pos_present & neg_present) {
      model[[pos_terms]] - model[[neg_terms]]
    } else if (pos_present) {
      model[[pos_terms]]
    } else {
      -model[[neg_terms]]
    }
  })


  # ------ Query Result

  output$query_result = renderTable({
    query_type = input$query_type
    if (query_type == 'word_query') {
      query = input$word_query
      wordVectors::closest_to(model, query)
    } else if (query_type == 'word_analogy') {
      query = word_analogy_result()
      wordVectors::closest_to(model, query)
    } else if (query_type == 'word_formula') {
      query = word_formula_result()
      wordVectors::closest_to(model, query)
    } else if (query_type == 'word_query_builder') {
      query = word_query_builder_result()
      wordVectors::closest_to(model, query)
    }
  })
}
