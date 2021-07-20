library(ComplexHeatmap)
library(tidyr)
library(dplyr)
library(purrr)
library(stringr)

m = make_comb_mat(l)
comb_name(m)
comb_size(m)
extract_comb(m, "0000011")

m[comb_size(m) >= 4]

m[comb_degree(m) == 2]

comb_colors_df <- data.frame(combname = comb_name(m), color = NA)  %>% unique


comb_colors_df <- comb_colors_df %>% mutate(split=map(combname, ~unlist(str_split(., "")))) %>% #split into characters
  unnest(cols = c(split)) %>%                         #unnest into a new column
  group_by(combname) %>% #group
  count(split) %>%                     #count letters for each group
  tidyr::spread(key=split, value=n, fill=0)   #convert to wide format

comb_colors_df <- comb_colors_df %>% mutate(last_chr = substr(combname, nchar(combname), nchar(combname))) %>%
  mutate(color = ifelse(`1` >=3, "red", "black")) %>%
  mutate(color = ifelse(`1` == 2 & last_chr == "0" , "red",  color)) %>%
  mutate(color = ifelse(`1` == 2 & last_chr == "1" , "blue", color)) %>%
  mutate(color = ifelse(`1` == 1 & last_chr == "1" , "grey45", color)) %>%
  arrange(color)
comb_colors <- comb_colors_df$color
comb_order_sel <-  match( comb_colors_df$combname, comb_name(m))
comb_colors_df$idx <- comb_order_sel

comb_colors_df <- comb_colors_df %>% arrange(idx)

UpSet(m,  set_order= names(l), 
      comb_order = order(comb_colors_df$color), 
      comb_col = comb_colors_df$color)

ht = draw(UpSet(m,  set_order= names(l), 
                      comb_order = order(comb_colors_df$color), 
                      comb_col = comb_colors_df$color))

od = column_order(ht)
cs = comb_size(m)
decorate_annotation("intersection_size", {
  grid.text(cs[od], x = seq_along(cs), y = unit(cs[od], "native") + unit(2, "pt"), 
            default.units = "native", just = "bottom", gp = gpar(fontsize = 8))
})
