#---- set up libraries----------------------------------------------------------
library(ComplexHeatmap)
library(ggplot2)
library(readr)

#---- read files ---------------------------------------------------------------
matrix <- read.csv("matrix.csv", row.names = 1)
group <- read.csv("group.csv")

#---- set up parameters --------------------------------------------------------
condition <- group$group # group information for samples
color_heatmap <- c("blue","white","red") # color for heatmap
color_group <- c('group_a' = 'blue', 'group_b' = 'red') # color for different group
file_name <- 'example.pdf' # file name
width <- 8 # width of plot
height <- 10 # height of plot
show_row_names <- FALSE # show gene names or not
cluster_rows <- FALSE # cluster genes or not
cluster_columns <- FALSE # cluster samples of not

#---- heatmap ------------------------------------------------------------------
color <- colorRampPalette(colors = color_heatmap)(100)
colAnn <- HeatmapAnnotation(df = data.frame(condition = condition),
                            col = list('condition' = color_group))
heatmap_legend = list(title= "Z-Score(logCPM)", title_position = "topcenter", legend_direction="horizontal")
pdf(file_name,width = width, height = height)
p <- Heatmap(as.matrix(matrix), 
            show_row_names = show_row_names,
            cluster_rows = cluster_rows, 
            cluster_columns = cluster_columns,
            col = color, 
            top_annotation=colAnn,
            heatmap_legend_param = heatmap_legend)
draw(p, merge_legend = FALSE, heatmap_legend_side = "bottom",annotation_legend_side = "right")
dev.off()

