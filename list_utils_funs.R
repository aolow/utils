print_items_l <- function(l){
  ItemsList <- gplots::venn(l, show.plot = FALSE)
  for(i in 1:length(attributes(ItemsList)$intersections)){
    cat("\n")
    message(names(attributes(ItemsList)$intersections)[i])
    attributes(ItemsList)$intersections[[i]] %>%  cat(., sep = ", ")
    cat("\n")
  }
}

printIntersectingItems_l_2ints <- function(l){
  ItemsList <- gplots::venn(l, show.plot = FALSE)
  idx_intersecting <- which(lapply(strsplit(names(attributes(ItemsList)$intersections), ":"), length)> 1)
  intersecting_genes <- attributes(ItemsList)$intersections[idx_intersecting] %>% unlist %>% unique
  intersecting_genes %>% sort %>% cat(., sep = ", ") 
  
}
