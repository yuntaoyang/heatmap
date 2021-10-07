#---- set up libraries----------------------------------------------------------
library(ComplexHeatmap)
library(ggplot2)
library(readr)
#---- read files ---------------------------------------------------------------
matrix <- read.csv("matrix.csv", row.names = 1)
group <- read.csv("group.csv")
#---- set up parameters --------------------------------------------------------
# color for heatmap
color <- colorRampPalette(colors = c("blue","white","red"))(100)
# color for different group
colAnn <- HeatmapAnnotation(df = data.frame(condition = group$group),
                            col = list('condition' = c('group_a' = 'blue', 'group_b' = 'red')))
# legend of heatmap
heatmap_legend = list(title= "Z-Score(logCPM)", title_position = "topcenter", legend_direction="horizontal")
# make heatmap
pdf('test.pdf',width = 8, height = 10)
p <- Heatmap(as.matrix(matrix), 
            show_row_names = FALSE, # show gene name
            cluster_rows = FALSE, # clustering in genes
            cluster_columns = FALSE, #clustering in samples
            col = color, 
            top_annotation=colAnn,
            heatmap_legend_param = heatmap_legend)
draw(p, merge_legend = FALSE, heatmap_legend_side = "bottom",annotation_legend_side = "right")
dev.off()

