print_items_l <- function(l){
  ItemsList <- gplots::venn(l, show.plot = FALSE)
  for(i in 1:length(attributes(ItemsList)$intersections)){
    cat("\n")
    message(names(attributes(ItemsList)$intersections)[i])
    attributes(ItemsList)$intersections[[i]] %>%  cat(., sep = ", ")
    cat("\n")
  }
}
